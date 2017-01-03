{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module DumbNote.Note where

import           Data.Aeson
import           Data.Text
import           Data.Time
import           DumbNote.UniqueData
import           GHC.Generics

data NoteData = NoteData { title        :: Text
                         , content      :: NoteContent
                         , creationTime :: UTCTime
                         } deriving (Generic, ToJSON)

data NoteType = PlainText | Markdown deriving (Generic, ToJSON)
data NoteContent = NoteContent NoteType Text
                 deriving (Generic, ToJSON)

newtype Note = Note { unNote :: (UniqueData NoteData) } deriving Generic

instance ToJSON Note where
  toJSON (Note (uuid, NoteData{..})) =
    object [ "id" .= show uuid
           , "title" .= title
           , "type" .= typeOf content
           , "content" .= contentOf content
           , "creationTime" .= creationTime
           ]
    where
      typeOf (NoteContent PlainText _) = "plaintext" :: Text
      typeOf (NoteContent Markdown _)  = "markdown" :: Text
      contentOf (NoteContent _ content) = content
