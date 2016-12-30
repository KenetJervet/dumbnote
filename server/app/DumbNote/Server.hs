{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module DumbNote.Server where

import           DumbNote.Note
import           DumbNote.Folder
import           DumbNote.Server.Handler
import           DumbNote.Util
import           Servant

type API = "folders" :> Get '[JSON] FolderTree
           :<|> "notes" :> Get '[JSON] [Note]
           :<|> "notes" :> Capture "id" String :> Get '[JSON] Note

api :: Server API
api = getFolderTreeHandler
  :<|> getNoteListHandler
  :<|> getNoteHandler

apiProxy :: Proxy API
apiProxy = Proxy

server :: Application
server = serve apiProxy api
