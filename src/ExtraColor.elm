module ExtraColor exposing (ExtraColor, backgroundColor, backgroundColorStyle, fontColor, fontColorStyle, oklch, oklchPercent, oklcha, oklchaPercent, toRgba)

import Culori
import Element exposing (..)
import Util.InlineStyle as InlineStyle exposing (InlineStyle)


type alias Oklch =
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
    ColorOklch <| { l = l, c = c, h = h, alpha = 1 }


oklchPercent : Float -> Float -> Float -> ExtraColor
oklchPercent l c h =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = 1 }


fromPercent : Float -> Float
fromPercent p =
    p / 100.0


oklcha : Float -> Float -> Float -> Float -> ExtraColor
oklcha l c h a =
    ColorOklch <| { l = l, c = c, h = h, alpha = a }


oklchaPercent : Float -> Float -> Float -> Float -> ExtraColor
oklchaPercent l c h a =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = a }


toRgba : ExtraColor -> Color
toRgba ce =
    case ce of
        ColorOklch x ->
            Culori.convertOklchToRgba x



--- Atrributes


fontColor : ExtraColor -> Attribute msg
fontColor ce =
    InlineStyle.render
        [ ( "color", rgbaToCssString (toRgba ce) )
        , ( "color", toCssString ce )
        ]


fontColorStyle : ExtraColor -> InlineStyle
fontColorStyle ce =
    [ ( "color", rgbaToCssString (toRgba ce) )
    , ( "color", toCssString ce )
    ]


backgroundColor : ExtraColor -> Attribute msg
backgroundColor ce =
    InlineStyle.render
        [ ( "background-color", rgbaToCssString (toRgba ce) )
        , ( "background-color", toCssString ce )
        ]


backgroundColorStyle : ExtraColor -> InlineStyle
backgroundColorStyle ce =
    [ ( "background-color", rgbaToCssString (toRgba ce) )
    , ( "background-color", toCssString ce )
    ]



--- Implementation details


toCssString : ExtraColor -> String
toCssString ce =
    case ce of
        ColorOklch { l, c, h, alpha } ->
            if alpha == 1 then
                "oklch("
                    ++ String.fromFloat l
                    ++ " "
                    ++ String.fromFloat c
                    ++ " "
                    ++ String.fromFloat h
                    ++ ")"

            else
                "oklch("
                    ++ String.fromFloat l
                    ++ " "
                    ++ String.fromFloat c
                    ++ " "
                    ++ String.fromFloat h
                    ++ " / "
                    ++ String.fromFloat alpha
                    ++ ")"


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
