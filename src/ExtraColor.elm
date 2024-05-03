module ExtraColor exposing (ExtraColor, fontColor, oklch, oklcha, toRgba)

import Element exposing (..)
import Html exposing (a)
import InlineStyle


type Oklch
    = Oklch
        { l : Float
        , c : Float
        , h : Float
        , alpha : Float
        }


{-| Note: We may add more colors in the future: LCH, LAB, OKLAB, etc.
Attribute functions will remain the same.
-}
type ExtraColor
    = ColorOklch Oklch


oklch : Float -> Float -> Float -> ExtraColor
oklch l c h =
    ColorOklch <| Oklch { l = l, c = c, h = h, alpha = 1 }


oklcha : Float -> Float -> Float -> Float -> ExtraColor
oklcha l c h a =
    ColorOklch <| Oklch { l = l, c = c, h = h, alpha = a }


{-| TODO: implement
-}
toRgba : ExtraColor -> Color
toRgba ce =
    case ce of
        ColorOklch (Oklch _) ->
            rgb255 0x00 0x89 0xB3



--- Atrributes


fontColor : ExtraColor -> Attribute msg
fontColor ce =
    InlineStyle.render
        [ ( "color", rgbaToCssString (toRgba ce) )
        , ( "color", toCssString ce )
        ]



--- Implementation details


toCssString : ExtraColor -> String
toCssString ce =
    case ce of
        ColorOklch (Oklch { l, c, h, alpha }) ->
            if alpha == 1 then
                "oklch(" ++ String.fromFloat l ++ " " ++ String.fromFloat c ++ " " ++ String.fromFloat h ++ ")"

            else
                "oklch(" ++ String.fromFloat l ++ " " ++ String.fromFloat c ++ " " ++ String.fromFloat h ++ " / " ++ String.fromFloat a ++ ")"


rgbaToCssString : Color -> String
rgbaToCssString x =
    let
        { red, green, blue, alpha } =
            toRgb x

        colors : List String
        colors =
            [ red, green, blue ]
                |> List.map ((*) 255 >> round >> String.fromInt)
    in
    "rgba("
        ++ String.join "," colors
        ++ ","
        ++ String.fromFloat alpha
        ++ ")"
