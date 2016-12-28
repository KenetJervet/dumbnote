module DumbNote.Worker where

import           Control.Concurrent
import           Control.Concurrent.STM
import           Control.Concurrent.STM.TChan
import           Control.Monad
import           Data.IORef
import           System.IO.Unsafe

data DNMessage = DNMessage

type DNMessageChannel = TChan DNMessage

{-# NOINLINE workChan #-}
workChan :: IORef DNMessageChannel
workChan = unsafePerformIO $ newTChanIO >>= newIORef

sendMessage :: DNMessage -> DNMessageChannel -> IO ()
sendMessage msg chan = atomically $ writeTChan chan msg

getMessage :: DNMessageChannel -> IO DNMessage
getMessage chan = atomically $ readTChan chan

loop :: IO ()
loop = readIORef workChan >>= \ chan -> forever $ do
  return ()  -- TODO: Dunno what to do
