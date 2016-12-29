module DumbNote.Server.Config where

data Config = Config { port :: Int }

def = Config { port = 8130
             }
