module InlineStyle exposing (InlineStyle, render)

{-| InlineStyle is a workaround for styling elements in ways not supported by the `elm-ui`.

Here's some context:

1.  Elm can render several `Html.Attributes.style` as an inline style, and they will be "merged" in such a way that there will be no repeating properties.
2.  If we pass several `Html.Attributes.attribute` of type "style", they won't be merged. Only one will be used.
3.  If we pass `Html.Attributes.attribute` of type "style", it replace any of the previous styles (both `attribute` and `style`).
4.  Modern CSS properties require us to set fallback values for outdated browsers.
5.  Fallback style property values require us to set the same property several times. Which is not supported neither by `Html.Attributes.attribute` nor by `Html.Attributes.style`.

The solution is the `InlineStyle` type and the `render function`.

@docs InlineStyle, render

-}

import Element exposing (..)
import Html.Attributes


{-| A list of (property, value) pairs
e.g.:

     [ ( "background-color", "rgba(275,61,0,1)" )
     , ( "background-color", "oklch(0.6864 0.255 36.4)" )
     ]

-}
type alias InlineStyle =
    List ( String, String )


{-| The `render` of inline styles must be done only once per element, because otherwise some styles will break.

The only working approach to customize a single element with several functions is to:

  - pass fallback values first, and main ones – later, as in usual CSS.
  - return `InlineStyle` instead of `Attribute msg` from custom styling functions.
  - combine styles in the client code using the `render` function, only once per element.

-}
render : InlineStyle -> Attribute msg
render =
    List.map (\( k, v ) -> k ++ ": " ++ v ++ ";")
        >> String.concat
        >> Html.Attributes.attribute "style"
        >> htmlAttribute
