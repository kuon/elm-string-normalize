module Main exposing (main)

{-| To run the benchmarks, first compile them with

    elm make benchmarks / DiacriticsBench.elm --optimize

from the root directory of the project. Then open the generated
index.html file in a browser.

-}

import Array exposing (Array)
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Dict exposing (Dict)
import Set exposing (Set)
import String.Normalize as Normalize
import String.Normalize.Diacritics as Diacritics


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    let
        aboveMinString =
            "£££££££££££££££££££££££££££££££££££££"

        belowMinString =
            "asdfereqerqerpqoiweruqwerqwerpqoweAAA"

        bench description str =
            Benchmark.compare description
                "original"
                (\_ -> removeDiacritics str)
                "new"
                (\_ -> Normalize.removeDiacritics str)
    in
    Benchmark.describe "remove diacritics"
        [ bench "below lowest diacritic code" belowMinString
        , bench "above lowest diacritic code" aboveMinString
        ]


removeDiacritics : String -> String
removeDiacritics str =
    let
        replace c result =
            case Dict.get c Diacritics.lookupTable of
                Just candidate ->
                    result ++ candidate

                Nothing ->
                    result ++ String.fromChar c
    in
    String.foldl replace "" str
