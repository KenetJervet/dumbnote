module Main where

import           DumbNote.Server
import           Network.Wai
import           Network.Wai.Handler.Warp

main :: IO ()
main = run 8081 server
