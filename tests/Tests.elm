module Tests exposing (..)

import Test exposing (..)
import Expect exposing (equal)
import String.Normalize exposing (removeDiacritics, slug, url, filename, path)


removeDiacriticsTests : Test
removeDiacriticsTests =
    Test.describe "String.Normalize.removeDiacritics"
        [ test "removes lowercase accents" <|
            \_ ->
                removeDiacritics "éeaèüàäö"
                    |> equal "eeaeuaao"
        , test "removes uppercase accents" <|
            \_ ->
                removeDiacritics "ÉEAÈÜÀÄÖ"
                    |> equal "EEAEUAAO"
        , test "removes ligatures" <|
            \_ ->
                removeDiacritics "Æƕ"
                    |> equal "AEhv"
        , test "normalizes a sentence" <|
            \_ ->
                removeDiacritics "La liberté commence où l'ignorance finit."
                    |> equal "La liberte commence ou l'ignorance finit."
        , test "don't touch punctuation" <|
            \_ ->
                removeDiacritics "é()/& abc"
                    |> equal "e()/& abc"
        , test "don't touch non latin characters" <|
            \_ ->
                removeDiacritics "こんにちは"
                    |> equal "こんにちは"
        ]


slugTests : Test
slugTests =
    Test.describe "String.Normalize.slug"
        [ test "simple slug" <|
            \_ ->
                slug "Écoute la vie!"
                    |> equal "ecoute-la-vie"
        , test "mixed slug" <|
            \_ ->
                slug "日本語&(co)"
                    |> equal "日本語-co"
        , test "trimmed slug" <|
            \_ ->
                slug "  () - Écoute __ la  () -- vie!!!"
                    |> equal "ecoute-la-vie"
        , test "removes slashes" <|
            \_ ->
                slug "ceci va devenir / un slug"
                    |> equal "ceci-va-devenir-un-slug"
        ]


urlTests : Test
urlTests =
    Test.describe "String.Normalize.url"
        [ test "simple url" <|
            \_ ->
                url "Écoute la vie!"
                    |> equal "ecoute-la-vie"
        , test "mixed url" <|
            \_ ->
                url "日本語&(co)/hello"
                    |> equal "日本語-co/hello"
        , test "trimmed url" <|
            \_ ->
                url "  () - Écoute __ la  /() -- vie!!!"
                    |> equal "ecoute-la/vie"
        , test "keeps slashes" <|
            \_ ->
                url "ceci va devenir / un url"
                    |> equal "ceci-va-devenir/un-url"
        ]


filenameTests : Test
filenameTests =
    Test.describe "String.Normalize.filename"
        [ test "simple filename" <|
            \_ ->
                filename "Écoute la vie!.MP3"
                    |> equal "ecoute-la-vie.mp3"
        , test "mixed filename" <|
            \_ ->
                filename "日本語&(co).ttf"
                    |> equal "日本語-co.ttf"
        , test "trimmed filename" <|
            \_ ->
                filename "  () - Écoute __ la  () -- vie!!!.JPG"
                    |> equal "ecoute-la-vie.jpg"
        , test "removes slashes" <|
            \_ ->
                filename "ceci va devenir / un filename.mpg"
                    |> equal "ceci-va-devenir-un-filename.mpg"
        , test "README example " <|
            \_ ->
                filename "Crazy / User Input:soɱeṳser.jpg"
                    |> equal "crazy-user-input-someuser.jpg"
        ]

pathTests : Test
pathTests =
    Test.describe "String.Normalize.path"
        [ test "simple path" <|
            \_ ->
                path "Écoute/-la vie!.MP3"
                    |> equal "ecoute/la-vie.mp3"
        , test "mixed path" <|
            \_ ->
                path "日本語&(co).ttf"
                    |> equal "日本語-co.ttf"
        , test "trimmed path" <|
            \_ ->
                path "  () - Écoute __ la  () /- vie!!!.JPG"
                    |> equal "ecoute-la/vie.jpg"
        , test "removes slashes" <|
            \_ ->
                path "ceci va devenir / un path.mpg"
                    |> equal "ceci-va-devenir/un-path.mpg"
        ]
