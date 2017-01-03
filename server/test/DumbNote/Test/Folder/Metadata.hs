{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}

module DumbNote.Test.Folder.Metadata where

import           Data.FileEmbed
import           Data.HashMap.Lazy        as HM
import           Data.Maybe
import           Data.Text                as T
import           Data.Text.Encoding       as TE
import           DumbNote.Folder.Metadata
import           DumbNote.UniqueData
import           Test.Tasty
import           Test.Tasty.HUnit

testDecodeYAML :: TestTree
testDecodeYAML = testCase "Folder metadata file test" $ do
  Just Metadata{..} <- readByteString $(embedFile "test/fixture/sample_mdfolder.yml")
  "98462757-e421-49e0-b342-ceecfbe771be" @=? toString root
  "Bar" @=? name (folders ! (fromJust . fromString) "9004db51-149d-4748-8875-78338bbf6192")

tests :: TestTree
tests = testGroup "Folder metadata tests"
  [ testDecodeYAML
  ]
