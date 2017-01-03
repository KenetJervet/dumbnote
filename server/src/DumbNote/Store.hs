{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module DumbNote.Store where

import           Control.Monad
import           Data.Maybe
import qualified Data.Text                as T
import           Debug.Trace
import           DumbNote.Config
import           DumbNote.Folder as F
import           DumbNote.Folder.Metadata as MD
import           DumbNote.Note
import           DumbNote.UniqueData
import           DumbNote.Util.FileSystem
import           Prelude                  hiding (readFile)
import           System.Directory
import           System.FilePath

-- Data store

data DNStore = DNStore { location :: FilePath
                       }

def :: DNStore
def = DNStore { location = "~/.local/share/dumbnote/store" }


open :: DNConfig -> IO DNStore
open DNConfig{ repoConfig = DNRepoConfig{..} } = do
  return DNStore { location = T.unpack repoLocation }

dnFolderRoot :: DNStore -> IO FilePath
dnFolderRoot DNStore{..} = expandHome $ location </> "folders"

-- Folder meta data

dnFolderMetaFile :: DNStore -> IO FilePath
dnFolderMetaFile store = dnFolderRoot store >>= return . (</> ".meta")

dnFolderMeta :: DNStore -> IO (Maybe Metadata)
dnFolderMeta store = dnFolderMetaFile store >>= readFile

getFolderTree :: FilePath -> IO FolderTree
getFolderTree entry = do
  let uuid = maybe nil id (fromString entry)
  createDirectoryIfMissing {- create parents -}True entry
  children <- listDirectory entry
              >>= return . map (entry </>)
              >>= filterM doesDirectoryExist
              >>= mapM getFolderTree
  return $ FolderTree { folder = Folder (uuid, FolderData { name = T.pack entry })
                      , children
                      }

getRootFolder :: DNStore -> IO [FolderTree]
getRootFolder store@DNStore{..} = dnFolderRoot store >>= getFolderTree >>= return . F.children
