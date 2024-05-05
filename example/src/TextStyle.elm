module TextStyle exposing (body, code, header, subheader, subheader2)

import Element exposing (..)
import Element.Font as Font


header : List (Attribute msg)
header =
    [ Font.size 55, Font.semiBold, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


subheader : List (Attribute msg)
subheader =
    [ Font.size 40, Font.medium, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


subheader2 : List (Attribute msg)
subheader2 =
    [ Font.size 28, Font.medium, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


body : List (Attribute msg)
body =
    [ Font.size 20, Font.regular, Font.family [ Font.typeface "Inter", Font.sansSerif ] ]


code : List (Attribute msg)
code =
    [ Font.size 16, Font.regular, Font.family [ Font.typeface "JetBrains Mono", Font.monospace ] ]
