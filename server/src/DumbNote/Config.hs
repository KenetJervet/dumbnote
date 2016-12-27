module DumbNote.Config where

import Data.Text

data DNConfig = DNConfig { repoConfig :: DNRepoConfig
                         }

data DNRepoConfig = DNRepoConfig { repoLocation :: Text
                                 }
