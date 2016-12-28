{-# LANGUAGE RecordWildCards #-}

module DumbNote.Store where

import           DumbNote.Folder
import           DumbNote.Note
import           DumbNote.Store.Config
import           System.Directory
import           System.FilePath

data DNStore = DNStore { location :: FilePath
                       }


open :: DNStoreConfig -> IO DNStore
open DNStoreConfig{..} = do
  return DNStore { location = location }

dnFolderRoot :: DNStore -> IO FilePath
dnFolderRoot DNStore{..} = location </> "folders"

getRootFolders :: DNStore -> IO [Folder]
getRootFolders DNStore{..} = listRootEntries >>= mapM toFolder
  where
    listRootEntries = filterM (doesDirectoryExist) dnFolderRoot
    toFolder entry = do
      (entry, FolderData {})

