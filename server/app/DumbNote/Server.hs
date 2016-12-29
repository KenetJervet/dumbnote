{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module DumbNote.Server where

import           DumbNote.Note
import           DumbNote.Server.Handler
import           DumbNote.Util
import           Servant

type API = "notes" :> Get '[JSON] [Note]
           :<|> "notes" :> Capture "id" String :> Get '[JSON] Note

api :: Server API
api = getNoteListHandler
      :<|> getNoteHandler

apiProxy :: Proxy API
apiProxy = Proxy

server :: Application
server = serve apiProxy api
