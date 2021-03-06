module DumbNote.Test where

import           DumbNote.Test.Async    as TAsync
import           DumbNote.Test.Folder   as TFolder
import           DumbNote.Test.Metadata as TMetadata
import           Test.Tasty
import           Test.Tasty.HUnit

tests :: TestTree
tests = testGroup "Tests"
  [ TFolder.tests
  , TMetadata.tests
  ]
