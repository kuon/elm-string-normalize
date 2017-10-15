# Elm String Normalize

[![Build Status](https://travis-ci.org/kuon/elm-string-normalize.svg?branch=master)](https://travis-ci.org/kuon/elm-string-normalize)

This package provides a few utilities to process user input into search token
or filenames.


While this library will remove diacritics for easier string matching, it will
NOT cleanup all unicode characters. This means that Homoglyph will be
preserved.


## Basic Usage

```elm
String.Normalize.filename "Crazy / User Input:soɱeṳser.jpg"
```

Will return:

```elm
"crazy-user-input-someuser.jpg"
```
