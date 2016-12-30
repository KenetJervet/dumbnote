{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE RecordWildCards      #-}

module DumbNote.Folder where

import           Data.Aeson
import           Data.Text
import           Data.Tree
import           Data.Void
import           DumbNote.Util

data FolderData = FolderData { name  :: Text
                             }

newtype Folder = Folder (UniqueData FolderData)

data FolderTree = FolderTree { folder :: Folder
                             , children :: [FolderTree]
                             }

-- instance ToJSON Folder where
--   toJSON (Folder (uuid, FolderData{..})) = object [ "id" .= show uuid
--                                                   , "name" .= name
--                                                   ]

instance ToJSON FolderTree where
  toJSON FolderTree{..} = let
    Folder (uuid, folderData) = folder
    in
    object [ "id" .= show uuid
           , "name" .= name folderData
           , "children" .= toJSON children
           ]
