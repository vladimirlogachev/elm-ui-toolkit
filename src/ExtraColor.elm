module ExtraColor exposing
    ( ExtraColor
    , backgroundColor
    , backgroundColorStyle
    , borderColor
    , borderColorStyle
    , fontColor
    , fontColorStyle
    , oklch
    , oklchPercent
    , oklcha
    , oklchaPercent
    , toRgba
    )

import Culori
import Element exposing (..)
import InlineStyle exposing (InlineStyle)



-- More info:
-- https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl
-- https://oklch.com
-- https://oklch-palette.vercel.app


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


oklcha : Float -> Float -> Float -> Float -> ExtraColor
oklcha l c h a =
    ColorOklch <| { l = l, c = c, h = h, alpha = a }


{-| Allows at most 2 decimal places for percent values, e.g. 12.34
Other decimal places are truncated. If you need more precision, use `oklch` or `oklchPercent`.
-}
oklchPercent : Float -> Float -> Float -> ExtraColor
oklchPercent l c h =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = 1 }


{-| Allows at most 2 decimal places for percent values, e.g. 12.34
Other decimal places are truncated. If you need more precision, use `oklch` or `oklcha`.
-}
oklchaPercent : Float -> Float -> Float -> Float -> ExtraColor
oklchaPercent l c h a =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = a }


toRgba : ExtraColor -> Color
toRgba ce =
    case ce of
        ColorOklch x ->
            convertOklchToRgba x



--- Atrributes


fontColor : ExtraColor -> Attribute msg
fontColor =
    fontColorStyle >> InlineStyle.render


fontColorStyle : ExtraColor -> InlineStyle
fontColorStyle ce =
    [ ( "color", rgbaToCssString (toRgba ce) )
    , ( "color", toCssString ce )
    ]


backgroundColor : ExtraColor -> Attribute msg
backgroundColor =
    backgroundColorStyle >> InlineStyle.render


backgroundColorStyle : ExtraColor -> InlineStyle
backgroundColorStyle ce =
    [ ( "background-color", rgbaToCssString (toRgba ce) )
    , ( "background-color", toCssString ce )
    ]


borderColor : ExtraColor -> Attribute msg
borderColor =
    borderColorStyle >> InlineStyle.render


borderColorStyle : ExtraColor -> InlineStyle
borderColorStyle ce =
    [ ( "border-color", rgbaToCssString (toRgba ce) )
    , ( "border-color", toCssString ce )
    ]


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


{-| Allows at most 2 decimal places for percent values, e.g. 12.34
Other decimal places are truncated.
-}
fromPercent : Float -> Float
fromPercent p =
    (toFloat <| floor (p * 100)) / (100 * 100)


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


convertOklchToRgba : Culori.OklchColor -> Color
convertOklchToRgba =
    Culori.convertOklchToRgba >> toElmUiColor


toElmUiColor : Culori.RgbaColor -> Color
toElmUiColor { r, g, b, alpha } =
    Element.rgba r g b alpha
