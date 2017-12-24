module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode


main : Program Never Model Msg
main =
    Html.program
        { init = ( [], getPeople )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Person =
    { name : String
    , country : String
    , city : String
    , salary : String
    }


type alias People =
    List Person


type alias Model =
    People



-- UPDATE


type Msg
    = ListPeople (Result Http.Error People)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListPeople (Ok people) ->
            ( people, Cmd.none )

        ListPeople (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    table [ class "table" ]
        [ thead [ class "text-primary" ]
            [ th []
                [ text "Name" ]
            , th []
                [ text "Country" ]
            , th []
                [ text "City" ]
            , th []
                [ text "Salary" ]
            ]
        , tbody [] (List.map personRow model)
        ]


personRow : Person -> Html Msg
personRow person =
    tr []
        [ td []
            [ text person.name ]
        , td []
            [ text person.country ]
        , td []
            [ text person.city ]
        , td [ class "text-primary" ]
            [ text person.salary ]
        ]



-- HTTP


getPeople : Cmd Msg
getPeople =
    Http.send ListPeople (Http.get "https://gae-zero-side-effect-stack.appspot.com/people" decodePeople)


decodePeople : Decode.Decoder People
decodePeople =
    Decode.list
        (Decode.map4 Person
            (Decode.field "name" Decode.string)
            (Decode.field "country" Decode.string)
            (Decode.field "city" Decode.string)
            (Decode.field "salary" Decode.string)
        )
