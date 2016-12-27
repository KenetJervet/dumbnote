{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module DumbNote.Note where

import           Data.Aeson
import           Data.Text
import           Data.Time
import           DumbNote.Util
import           GHC.Generics

data NoteData = NoteData { title        :: Text
                         , content      :: NoteContent
                         , creationTime :: UTCTime
                         } deriving (Generic, ToJSON)

data NoteContent = PlainTextContent Text
                 | MarkdownContent Text
                 deriving (Generic, ToJSON)

type Note = UniqueData NoteData
