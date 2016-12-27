{-# LANGUAGE OverloadedStrings  #-}

module DumbNote.Util where

import           Data.Aeson
import           Data.UUID
import           Data.UUID.V4
import           GHC.Generics

type Id = UUID

instance ToJSON UUID where
  toJSON _ = String ""

newId :: IO UUID
newId = nextRandom
