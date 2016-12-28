module DumbNote.Test.Async where

import           Control.Concurrent
import           Control.Concurrent.Async
import           Test.Tasty
import           Test.Tasty.HUnit

tests :: TestTree
tests = testGroup "Tests"
  [ testCase "Test async IO" $ do
      putStrLn "Main thread"
      fa <- async $ do
        putStrLn "Async 1"
        threadDelay 4000000
        putStrLn "Async 1 done"
        return 123
      fb <- async $ do
        putStrLn "Async 2"
        threadDelay 200000
        putStrLn "Async 2 done"
        return 234
      a <- wait fa
      b <- wait fb
      putStrLn "Main thread done"
      putStrLn $ "a + b = " ++ show (a+b)
  ]
