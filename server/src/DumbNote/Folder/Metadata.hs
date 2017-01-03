{-# LANGUAGE ApplicativeDo        #-}
{-# LANGUAGE DeriveAnyClass       #-}
{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE NamedFieldPuns       #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE RecordWildCards      #-}
{-# LANGUAGE StandaloneDeriving   #-}
{-# LANGUAGE TypeSynonymInstances #-}

module DumbNote.Folder.Metadata where

import           Control.Arrow
import           Data.ByteString     (ByteString)
import qualified Data.HashMap.Lazy   as HM
import           Data.Maybe
import           Data.Text           (Text)
import qualified Data.Text           as T
import           Data.Yaml
import           DumbNote.UniqueData
import           GHC.Generics


data Metadata = Metadata { root    :: Id
                         , folders :: MDFolderMap
                         } deriving (Generic, ToJSON, FromJSON, Show)

data MDFolderData = MDFolderData { name     :: Text
                                 , children :: [Id]
                                 } deriving (Generic, ToJSON, FromJSON, Show)

type MDFolderMap = HM.HashMap Id MDFolderData

instance ToJSON MDFolderMap where
  toJSON = toJSON . HM.fromList . map ((T.pack . toString) *** id) . HM.toList

instance FromJSON MDFolderMap where
  -- TODO: Improve this garbage implementation
  parseJSON value = (parseJSON value :: Parser (HM.HashMap Text MDFolderData))
                >>= return . HM.fromList . map ((fromJust . fromString . T.unpack) *** id) . HM.toList

------------------------------
-- JSON/YAML related instances
------------------------------

readByteString :: ByteString -> IO (Maybe Metadata)
readByteString = return . decode

readFile :: FilePath -> IO (Maybe Metadata)
readFile filePath = decodeFile filePath
