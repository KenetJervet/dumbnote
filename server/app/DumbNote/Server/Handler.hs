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
import           DumbNote.Util
import           Servant
import           System.IO.Unsafe
import           Text.Printf

-- Folders-related handlers

{-# NOINLINE foldersRef #-}
foldersRef :: IORef FolderTree
foldersRef = unsafePerformIO $ do
  rootId:leafId1:leafId2:_ <- replicateM 3 newId
  return $
    FolderTree { folder = Folder (rootId, FolderData { name = "Root" })
               , children = [ FolderTree { folder = Folder (leafId1, FolderData { name = "1" })
                                         , children = [ FolderTree { folder = Folder (leafId1, FolderData { name = "1.1" })
                                                                   , children = []
                                                                   }
                                                      , FolderTree { folder = Folder (leafId2, FolderData { name = "1.2" })
                                                                   , children = []
                                                                   }
                                                      ]
                                         }
                            , FolderTree { folder = Folder (leafId2, FolderData { name = "2" })
                                         , children = []
                                         }
                            ]
               }
  >>= newIORef


getFolderTreeHandler :: Handler FolderTree
getFolderTreeHandler = liftIO $ readIORef foldersRef

{-# NOINLINE notesRef #-}
notesRef :: IORef [Note]
notesRef = unsafePerformIO $ mapM (
  \ (seqNo :: Int) -> do
    uuid <- newId
    currTime <- getCurrentTime
    return $ Note (uuid, NoteData { title = T.pack $ printf "Title %d" seqNo
                                  , content = NoteContent PlainText $
                                              T.pack $ printf "Content %d" seqNo
                                  , creationTime = currTime
                                  })
  ) [1..3] >>= newIORef

getNoteListHandler :: Handler [Note]
getNoteListHandler = liftIO $ readIORef notesRef

getNoteHandler :: String -> Handler Note
getNoteHandler strUuid = liftIO $ do
  let uuid = fromJust $ fromString strUuid
  notes <- readIORef notesRef
  return $ fromJust $ find ((== uuid) . fst . unNote) notes
