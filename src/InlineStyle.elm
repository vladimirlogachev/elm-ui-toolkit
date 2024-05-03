module InlineStyle exposing (InlineStyle, render)

import Element exposing (..)
import Html.Attributes


type alias InlineStyle =
    List ( String, String )


{-| `render` should be done only once per element,
because elm-ui may override duplicate style attributes.
-}
render : InlineStyle -> Attribute msg
render =
    List.map (\( k, v ) -> k ++ ": " ++ v ++ ";")
        >> String.concat
        >> Html.Attributes.attribute "style"
        >> htmlAttribute
