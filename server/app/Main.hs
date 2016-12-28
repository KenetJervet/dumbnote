{-# LANGUAGE RecordWildCards #-}

module Main where

import           DumbNote.Server
import           Network.Wai
import           Network.Wai.Handler.Warp

runServer :: ServerConfig -> IO ()
runServer ServerConfig{..} = run port server

main :: IO ()
main = run 8081 server
