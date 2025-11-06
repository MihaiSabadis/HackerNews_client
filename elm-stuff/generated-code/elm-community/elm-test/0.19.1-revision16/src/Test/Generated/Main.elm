module Test.Generated.Main exposing (main)

import ExampleTests.CursorTests
import ExampleTests.ModelPostIdsTests
import ExampleTests.ModelPostsConfigTests
import ExampleTests.UtilTimeTests
import MainTests
import PostTests
import PostsConfigTests
import PostsViewTests
import SimulatedEffect
import TestData
import TestUtils

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport Monochrome
        , seed = 376158560164992
        , processes = 4
        , globs =
            []
        , paths =
            [ "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/ExampleTests/CursorTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/ExampleTests/ModelPostIdsTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/ExampleTests/ModelPostsConfigTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/ExampleTests/UtilTimeTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/MainTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/PostTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/PostsConfigTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/PostsViewTests.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/SimulatedEffect.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/TestData.elm"
            , "/home/mihai/facultate/FP/ElmProject/Elm-Project/tests/TestUtils.elm"
            ]
        }
        [ ( "ExampleTests.CursorTests"
          , [ Test.Runner.Node.check ExampleTests.CursorTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostIdsTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostIdsTests.suite
            ]
          )
        , ( "ExampleTests.ModelPostsConfigTests"
          , [ Test.Runner.Node.check ExampleTests.ModelPostsConfigTests.suite
            ]
          )
        , ( "ExampleTests.UtilTimeTests"
          , [ Test.Runner.Node.check ExampleTests.UtilTimeTests.suite
            ]
          )
        , ( "MainTests"
          , [ Test.Runner.Node.check MainTests.suite
            ]
          )
        , ( "PostTests"
          , [ Test.Runner.Node.check PostTests.requiredFields
            , Test.Runner.Node.check PostTests.fields
            , Test.Runner.Node.check PostTests.fieldNames
            , Test.Runner.Node.check PostTests.completePost
            , Test.Runner.Node.check PostTests.suite
            ]
          )
        , ( "PostsConfigTests"
          , [ Test.Runner.Node.check PostsConfigTests.suite
            ]
          )
        , ( "PostsViewTests"
          , [ Test.Runner.Node.check PostsViewTests.currentTime
            , Test.Runner.Node.check PostsViewTests.selectShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowJobPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.selectElementContainingShowTextPostsCheckbox
            , Test.Runner.Node.check PostsViewTests.suite
            ]
          )
        , ( "SimulatedEffect"
          , [ Test.Runner.Node.check SimulatedEffect.start
            , Test.Runner.Node.check SimulatedEffect.fromLoadedState
            ]
          )
        , ( "TestData"
          , [ Test.Runner.Node.check TestData.posts
            , Test.Runner.Node.check TestData.allPosts
            , Test.Runner.Node.check TestData.textPosts
            , Test.Runner.Node.check TestData.jobPosts
            ]
          )
        , ( "TestUtils"
          , []
          )
        ]