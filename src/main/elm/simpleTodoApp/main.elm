module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text, input, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { count : Int, content: String, todos: List String }


initialModel : Model
initialModel =
    { count = 0, content = "", todos = [] }


type Msg
    = Increment
    | Decrement
    | Reset
    | Change String
    | AddTodo


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }
        Decrement ->
            { model | count = model.count - 1 }
        Reset ->
            { model | count = 0}   
        Change newContent -> 
            { model | content = newContent}
        AddTodo ->
            { model | todos = (model.content :: model.todos ), content = ""}
            
            
todoList : Model -> Html Msg
todoList model =
    div []
        [
            ul []
                (List.map (\l -> li [] [ text l ]) model.todos)
        ]


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Decrement ] [ text "-1" ]
        , div [] []
        , button [ onClick Reset ] [ text "Reset" ]
        , div [] [
            input [placeholder "Todo Item", value model.content, onInput Change ] [],
            button [ onClick AddTodo ] [ text "Add" ],
            todoList model
        ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
