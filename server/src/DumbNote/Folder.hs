module DumbNote.Folder where

import           Data.Text
import           Data.Void
import           DumbNote.Util

data FolderData = FolderData { name  :: Text
                             , attrs :: Void
                             }

type Folder = UniqueData FolderData
