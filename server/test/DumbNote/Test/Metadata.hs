{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module DumbNote.Test.Metadata where

import           Data.FileEmbed
import           Data.Text          as T
import           Data.Text.Encoding as TE
import           DumbNote.Metadata
import           Test.Tasty
import           Test.Tasty.HUnit

testConfigParser :: TestTree
testConfigParser = testCase "Config parser test" $ do
  configParser <- readByteString $(embedFile "test/fixture/sample.cfg")
  (readValue ("Foo" :.: "bar") configParser :: IO Int) >>= (@=? 123)
  (readValue ("Foo" :.: "baz") configParser :: IO String) >>= (@=? "GGHH")

tests :: TestTree
tests = testGroup "Metadata tests"
  [ testConfigParser
  ]
