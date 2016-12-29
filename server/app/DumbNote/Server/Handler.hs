{-# LANGUAGE ScopedTypeVariables #-}

module DumbNote.Server.Handler where

import           Control.Monad.IO.Class
import           Data.IORef
import           Data.List              (find)
import           Data.Maybe
import qualified Data.Text              as T
import           Data.Time.Clock
import           DumbNote.Note
import           DumbNote.Util
import           Servant
import           System.IO.Unsafe
import           Text.Printf

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
