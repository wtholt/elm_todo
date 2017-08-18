import Html exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

main =
  Html.program
  {
    init = init "name"
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

type alias Model =
  {
    name : String
  }

init : String -> (Model, Cmd Msg)
init name =
  ( Model "", getRandomQuote )

type Msg
  = GetQuote
  | NewQuote (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)

update msg model =
  case msg of
    GetQuote ->
      (model, getRandomQuote)

    NewQuote (Ok name) ->
      ( { model | name = name }, Cmd.none)

    NewQuote (Result.Err _) ->
      (model, Cmd.none)
view : Model -> Html Msg

view model =
  div []
  [ h2 [] [text "Seinfeld Quotes" ]
  , button [ onClick GetQuote ] [ text "More Seinfeld Please!" ]
  , br [] []
  , p [] [ text model.name ]
  ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

getRandomQuote : Cmd Msg

getRandomQuote =
  let
    url =
      "http://localhost:5000/todos.json"
  in
    Http.send NewQuote (Http.get url decodeUrl)

decodeUrl : Decode.Decoder String
decodeUrl =
  Decode.at ["name"] Decode.string
