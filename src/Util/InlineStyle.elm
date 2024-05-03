module Util.InlineStyle exposing (InlineStyle, render)

import Element exposing (..)
import Html.Attributes


{-| (property, value) pair
e.g. ("color", "red")
-}
type alias InlineStyle =
    List ( String, String )


{-| The `render` of inline styles must be done only once per element, because otherwise styles will break.

Here's some context:

1.  Elm can render several `Html.Attributes.style` as inline style, and they will be "merged" in such a way that there will be no repeating properties.
2.  If we pass `Html.Attributes.attribute` of type "style", it replace any of the previous styles.
3.  If we pass several `Html.Attributes.attribute` of type "style", they won't be merged. Only one will be used.
4.  Fallback style property values require us to set the same property several times.

So, the only option is to:

  - combine styles ourselves with the `render` function
  - do it only once per element
  - pass fallback values first, and main ones – later, as in usual CSS.

-}
render : InlineStyle -> Attribute msg
render =
    List.map (\( k, v ) -> k ++ ": " ++ v ++ ";")
        >> String.concat
        >> Html.Attributes.attribute "style"
        >> htmlAttribute
