{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module DumbNote.Util ( module DumbNote.Util
                     , Data.UUID.fromString
                     ) where

import           Data.Aeson
import           Data.UUID
import           Data.UUID.V4
import           GHC.Generics

type Id = UUID

instance ToJSON Id where
  toJSON = toJSON . toString

newId :: IO Id
newId = nextRandom

type UniqueData d = (Id, d)
