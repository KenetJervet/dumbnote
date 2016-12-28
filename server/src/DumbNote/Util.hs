{-# LANGUAGE OverloadedStrings  #-}

module DumbNote.Util ( module DumbNote.Util
                     , Data.UUID.fromString
                     ) where

import           Data.Aeson
import           Data.UUID
import           Data.UUID.V4
import           GHC.Generics

type Id = UUID

instance ToJSON UUID where
  toJSON = toJSON . toString

newId :: IO UUID
newId = nextRandom

type UniqueData d = (Id, d)
