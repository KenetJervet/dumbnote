module DumbNote.Command where

import           DumbNote.Folder
import           DumbNote.Note

data DNCommand a

createNote :: NoteData -> DNCommand Note
createNote = undefined

updateNote :: Note -> DNCommand Note
updateNote = undefined

createFolder :: FolderData -> DNCommand Folder
createFolder = undefined
