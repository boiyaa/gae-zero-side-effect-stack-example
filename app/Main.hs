{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

import Web.Spock
import Web.Spock.Config

import Data.Aeson hiding (json)
import Data.Monoid ((<>))
import Data.Text (Text, pack)
import GHC.Generics


data Person = Person
  { name :: Text
  , country :: Text
  , city :: Text
  , salary :: Text
  } deriving (Generic, Show)

instance ToJSON Person

instance FromJSON Person


type Api = SpockM () () () ()

type ApiAction a = SpockAction () () () a

main :: IO ()
main = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 8080 (spock spockCfg app)
  
app :: Api
app = do
  get "people" $ do
    json [ Person { name = "Dakota Rice", country = "Niger", city = "Oud-Turnhout", salary = "$36,738" }
         , Person { name = "Minerva Hooper", country = "Curaçao", city = "Sinaai-Waas", salary = "$23,789" }
         , Person { name = "Sage Rodriguez", country = "Netherlands", city = "Baileux", salary = "$56,142" }
         , Person { name = "Philip Chaney", country = "Korea, South", city = "Overland Park", salary = "$38,735" }
         , Person { name = "Doris Greene", country = "Malawi", city = "Feldkirchen in Kärnten", salary = "$63,542" }
         , Person { name = "Mason Porter", country = "Chile", city = "Gloucester", salary = "$78,615" }
         ]