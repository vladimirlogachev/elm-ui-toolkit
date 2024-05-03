module TextStyle exposing (body, headerMobile, subheaderMobile)

import Element exposing (..)
import Element.Font as Font


headerMobile : List (Attribute msg)
headerMobile =
    [ Font.size 55, Font.bold, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


subheaderMobile : List (Attribute msg)
subheaderMobile =
    [ Font.size 34, Font.medium, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


body : List (Attribute msg)
body =
    [ Font.size 20, Font.regular, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]
