module DiacriticsBench exposing (main)

{-| To run the benchmarks, first compile them with

    elm make DiacriticsBench.elm --optimize

from this folder. Then open the generated index.html file in a browser.

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
        -- These characters have a higher Unicode code point than the
        -- lowest diacritic code point.
        aboveMinString =
            "£££££££££££££££££££££££££££££££££££££"

        -- These characters have lower Unicode code points than the
        -- lowest diacritic code point.
        belowMinString =
            "asdfereqerqerpqoiweruqwerqwerpqoweAAA"

        bench description str =
            Benchmark.compare description
                "old"
                (\_ -> oldRemoveDiacritics str)
                "new"
                (\_ -> Normalize.removeDiacritics str)
    in
    Benchmark.describe "remove diacritics"
        [ bench "below lowest diacritic code" belowMinString
        , bench "above lowest diacritic code" aboveMinString
        ]


oldRemoveDiacritics : String -> String
oldRemoveDiacritics str =
    let
        replace c result =
            case Dict.get c Diacritics.lookupTable of
                Just candidate ->
                    result ++ candidate

                Nothing ->
                    result ++ String.fromChar c
    in
    String.foldl replace "" str
