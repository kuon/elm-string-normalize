# Elm String Normalize

![CI](https://github.com/kuon/elm-string-normalize/workflows/CI/badge.svg)

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

```
"crazy-user-input-someuser.jpg"
```

## Testing

```shell
make test
```
