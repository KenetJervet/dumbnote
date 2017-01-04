{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module DumbNote.Store where

import           Control.Monad
import           Data.Maybe
import qualified Data.Text                as T
import           Debug.Trace
import           DumbNote.Config
import           DumbNote.Folder          as F
import           DumbNote.Folder.Metadata (toFolderTree)
import qualified DumbNote.Folder.Metadata as FMD
import           DumbNote.Note
import           DumbNote.UniqueData
import           DumbNote.Util.FileSystem
import           System.Directory
import           System.FilePath

-- Data store

data DNStore = DNStore { location :: FilePath
                       }

def :: DNStore
def = DNStore { location = "~/.local/share/dumbnote/store" }

type StoreAction a = DNStore -> a
type StoreIOAction a = StoreAction (IO a)


open :: DNConfig -> IO DNStore
open DNConfig{ repoConfig = DNRepoConfig{..} } = do
  return DNStore { location = T.unpack repoLocation }

dnFolderRoot :: StoreIOAction FilePath
dnFolderRoot DNStore{..} = expandHome $ location </> "folders"

-- Folder meta data

dnFolderMetaFile :: StoreIOAction FilePath
dnFolderMetaFile store = dnFolderRoot store >>= return . (</> ".meta")

dnFolderMeta :: StoreIOAction (Maybe FMD.Metadata)
dnFolderMeta store = dnFolderMetaFile store >>= FMD.readFile

getFolderTree :: StoreIOAction (Maybe FolderTree)
getFolderTree store = do
  metadata <- dnFolderMeta store
  return $ maybe Nothing (Just . toFolderTree) metadata
