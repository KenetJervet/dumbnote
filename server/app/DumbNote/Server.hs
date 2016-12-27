{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module DumbNote.Server where

import           DumbNote.Note
import           Servant

type API = "notes" :> Get '[JSON] [Note]

api :: Server API
api = return []

apiProxy :: Proxy API
apiProxy = Proxy

server :: Application
server = serve apiProxy api
