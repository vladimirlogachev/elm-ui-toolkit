module TextStyle exposing (body, header)

import Element exposing (..)
import Element.Font as Font


header : List (Attribute msg)
header =
    [ Font.size 55, Font.bold, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


body : List (Attribute msg)
body =
    [ Font.size 20, Font.regular, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]
