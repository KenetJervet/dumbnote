module DumbNote.Store where

import DumbNote.Session

data DNStore

open :: DNStore -> IO DNSession
open store = undefined
