{-# LANGUAGE RecordWildCards #-}

module Main where

import           DumbNote.Server
import           DumbNote.Server.Config
import           Network.Wai
import           Network.Wai.Handler.Warp

runServer :: Config -> IO ()
runServer Config{..} = run port server

main :: IO ()
main = runServer def
