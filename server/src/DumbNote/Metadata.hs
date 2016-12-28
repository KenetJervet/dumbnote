{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs            #-}

module DumbNote.Metadata where

import           Control.Monad
import           Control.Monad.Except
import           Control.Monad.Except
import           Data.ByteString      as BS
import           Data.ConfigFile
import           Data.Either
import           Data.Text            as T
import           Data.Text.Encoding   as TE

newtype ConfigFile = ConfigFile ConfigParser
data Key = {- Section -}Text :.: {- Option -}Text


exceptTToIO :: (ExceptT CPError IO a) -> (CPError -> a) -> IO a
exceptTToIO action actionOnError = runExceptT (
    action
  ) >>= return . either actionOnError id

readByteString :: ByteString -> IO ConfigFile
readByteString bs = exceptTToIO
  (readstring emptyCP $ T.unpack $ TE.decodeUtf8 bs)
  (error . show)
  >>= return . ConfigFile

readFile :: FilePath -> IO ConfigFile
readFile filePath = exceptTToIO
  (join $ liftIO $ readfile emptyCP filePath)
  (error . show)
  >>= return . ConfigFile

readValue :: Get_C a => Key -> ConfigFile -> IO a
readValue (section :.: option) (ConfigFile parser) = exceptTToIO
  (get parser (T.unpack section) (T.unpack option))
  (error . show)
