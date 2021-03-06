module DumbNote.Util.FileSystem where

import           System.Directory

expandHome :: FilePath -> IO FilePath
expandHome ('~':xs) = getHomeDirectory >>= return . (++ xs)
expandHome path     = return path
