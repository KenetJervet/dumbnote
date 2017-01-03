module DumbNote.Test.Folder where

import           DumbNote.Test.Folder.Metadata as MD
import           Test.Tasty

tests :: TestTree
tests = testGroup "Folder tests"
  [ MD.tests
  ]
