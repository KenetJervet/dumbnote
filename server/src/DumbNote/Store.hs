{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module DumbNote.Store where

import           Control.Monad
import           Data.Maybe
import           DumbNote.Folder
import           DumbNote.Note
import           DumbNote.Store.Config
import           DumbNote.Util
import           System.Directory
import           System.FilePath

data DNStore = DNStore { location :: FilePath
                       }


open :: DNStoreConfig -> IO DNStore
open DNStoreConfig{..} = do
  return DNStore { location = location }

dnFolderRoot :: DNStore -> IO FilePath
dnFolderRoot DNStore{..} = return $ location </> "folders"

getRootFolders :: DNStore -> IO [Folder]
getRootFolders store@DNStore{..} = listRootEntries >>= mapM toFolder
  where
    listRootEntries = (dnFolderRoot store >>= listDirectory) >>= filterM doesDirectoryExist
    toFolder entry = do
      let uuid = fromJust $ fromString entry
      return (uuid, FolderData { name = "GG" })

