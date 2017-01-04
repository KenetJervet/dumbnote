{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module DumbNote.Server.Handler where

import           Control.Monad
import           Control.Monad.IO.Class
import           Data.IORef
import           Data.List              (find)
import           Data.Maybe
import qualified Data.Text              as T
import           Data.Time.Clock
import           Data.Tree
import           DumbNote.Folder
import           DumbNote.Note
import           DumbNote.Store         as DNStore
import           DumbNote.UniqueData
import           Servant
import           System.IO.Unsafe
import           Text.Printf

-- Folders-related handlers

getFolderTreeHandler :: Handler FolderTree
getFolderTreeHandler = liftIO (getFolderTree DNStore.def >>= return . fromJust)

getNoteListHandler :: FilePath -> Handler [Note]
getNoteListHandler filePath = undefined

getNoteHandler :: String -> Handler Note
getNoteHandler strUuid = undefined
