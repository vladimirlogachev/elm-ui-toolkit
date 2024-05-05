module Color exposing (black, blue, grey, white)

import Element exposing (..)
import ExtraColor exposing (ExtraColor)


white : Color
white =
    rgb255 255 255 255


grey : Color
grey =
    rgb255 140 140 140


blue : ExtraColor
blue =
    ExtraColor.oklchPercent 53.64 0.209 252.92


black : Color
black =
    rgb255 0 0 0
