{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module DumbNote.UniqueData ( module DumbNote.UniqueData
                     , Data.UUID.fromString
                     , Data.UUID.toString
                     , Data.UUID.nil
                     ) where

import           Data.Aeson
import           Data.Maybe
import           Data.Text    as T
import           Data.UUID
import           Data.UUID.V4
import           GHC.Generics

type Id = UUID

instance ToJSON Id where
  toJSON = toJSON . toString

instance FromJSON Id where
  parseJSON (String text) = pure $ fromJust $ fromString $ T.unpack text

newId :: IO Id
newId = nextRandom

type UniqueData d = (Id, d)
