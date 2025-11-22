module View.Posts exposing (..)

-- Modified to expose more functions for the table view

import Html exposing (Html, a, div, option, select, table, tbody, td, text, th, thead, tr,label,input)
import Html.Attributes exposing (class, href, id, value,for,type_, selected, checked)
import Html.Events exposing (onInput, onCheck)
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time
import Util.Time



-- Helper function used in postTable to make a row from post
postRow : Time.Posix -> Post -> Html Msg
postRow now post =
    tr []
        [ td [ class "post-score" ] [ text (String.fromInt post.score) ]
        , td [ class "post-title" ] [ text post.title ]
        , td [ class "post-type" ] [ text post.type_ ]
        , td [ class "post-time" ]
             [
                let
                    absoluteTime = Util.Time.formatTime Time.utc post.time
                    suffix =
                        case Util.Time.durationBetween post.time now of
                            Just duration ->
                                " (" ++ Util.Time.formatDuration duration ++ " ago)"

                            Nothing ->
                                ""
                in
                text (absoluteTime ++ suffix)
             ]
        , td [ class "post-url" ]
            [ case post.url of
                Just u ->
                    a [ href u ] [ text "Link" ]

                Nothing ->
                    text "-"
            ]
        ]


{-| Show posts as a HTML [table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)

Relevant local functions:

  - Util.Time.formatDate
  - Util.Time.formatTime
  - Util.Time.formatDuration (once implemented)
  - Util.Time.durationBetween (once implemented)

Relevant library functions:

  - [Html.table](https://package.elm-lang.org/packages/elm/html/latest/Html#table)
  - [Html.tr](https://package.elm-lang.org/packages/elm/html/latest/Html#tr)
  - [Html.th](https://package.elm-lang.org/packages/elm/html/latest/Html#th)
  - [Html.td](https://package.elm-lang.org/packages/elm/html/latest/Html#td)

-}
postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable config now posts =
    let
        visiblePosts = filterPosts config posts
    in
    div []
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Score" ]
                    , th [] [ text "Title" ]
                    , th [] [ text "Type" ]
                    , th [] [ text "Posted" ]
                    , th [] [ text "Link" ]
                    ]
                ]
            , tbody [] (List.map (postRow now) visiblePosts)
            ]
        ]



--Debug.todo "postTable"


{-| Show the configuration options for the posts table

Relevant functions:

  - [Html.select](https://package.elm-lang.org/packages/elm/html/latest/Html#select)
  - [Html.option](https://package.elm-lang.org/packages/elm/html/latest/Html#option)
  - [Html.input](https://package.elm-lang.org/packages/elm/html/latest/Html#input)
  - [Html.Attributes.type\_](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_)
  - [Html.Attributes.checked](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#checked)
  - [Html.Attributes.selected](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#selected)
  - [Html.Events.onCheck](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onCheck)
  - [Html.Events.onInput](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onInput)

-}

postsConfigView : PostsConfig -> Html Msg
postsConfigView config =
    div []
        [ select [ id "select-posts-per-page", onInput (\str -> String.toInt str |> Maybe.map ChangeNumPosts |> Maybe.withDefault (ChangeNumPosts config.postsToShow) |> ConfigChanged) ]
            [ option [ value "10", selected (config.postsToShow == 10) ] [ text "10" ]
            , option [ value "25", selected (config.postsToShow == 25)  ] [ text "25" ]
            , option [ value "50", selected (config.postsToShow == 50)  ] [ text "50" ]
            ]
        , select [ id "select-sort-by", onInput (ChangeSortBy >> ConfigChanged) ]
            [ option [ value "Score", selected (config.sortBy == Score) ] [ text "Score" ]
            , option [ value "Title", selected (config.sortBy == Title)  ] [ text "Title" ]
            , option [ value "Posted", selected (config.sortBy == Posted)  ] [ text "Posted" ]
            , option [ value "None", selected (config.sortBy == None)  ] [ text "None" ]
            ]
        , div []
            [ input [ type_ "checkbox", id "checkbox-show-job-posts", checked config.showJobs, onCheck (ChangeShowJobs >> ConfigChanged) ] []
            , text "Show job posts"
            ]
        , div []
            [ input [ type_ "checkbox", id "checkbox-show-text-only-posts", checked config.showTextOnly, onCheck (ChangeShowTextOnly >> ConfigChanged) ] []
            , text "Show text-only posts"
            ]
        ]
    -- Debug.todo "postsConfigView";
