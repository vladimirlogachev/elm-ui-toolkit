module ExtraColor exposing
    ( ExtraColor, oklch, oklchPercent, oklcha, oklchaPercent
    , backgroundColor, backgroundColorStyle, borderColor, borderColorStyle, fontColor, fontColorStyle
    , toRgbaFallback
    )

{-| This module allows to use the wide-gamut colors (OKLCH, DCI-P3, Rec. 2020) with `elm-ui`.

Browsers will display a similar color anyway, even if it's not supported by the display.
Think of the calculated fallback color as the one that will be used by the outdated browsers.
This package heavily borrows from the [culori](https://culorijs.org) library.

  - Example: [live](https://vladimirlogachev.github.io/elm-ui-toolkit), [code](https://github.com/vladimirlogachev/elm-ui-toolkit/tree/main/example)
  - More info:
      - [OKLCH in CSS: why we moved from RGB and HSL (by Evil Martians)](https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl)
      - [OKLCH Color Picker & Converter (by Evil Martians)](https://oklch.com)
      - [OKlch palette generator (by Pleisto)](https://oklch-palette.vercel.app)


# Creation

@docs ExtraColor, oklch, oklchPercent, oklcha, oklchaPercent


# Styling

@docs backgroundColor, backgroundColorStyle, borderColor, borderColorStyle, fontColor, fontColorStyle


# Conversion

@docs toRgbaFallback

-}

import Culori
import Element exposing (..)
import InlineStyle exposing (InlineStyle)


type alias Oklch =
    { l : Float
    , c : Float
    , h : Float
    , alpha : Float
    }


{-| An opaque type for extra colors. We may add more colors in the future: OKLAB, etc.
Styling functions will likely remain the same.
-}
type ExtraColor
    = ColorOklch Oklch


{-| Creates a color with the given lightness, chroma, and hue.

  - Lightness [0 .. 1]
  - Chroma [0 .. 1]
  - Hue [0 .. 360]
  - Alpha set to 1.

-}
oklch : Float -> Float -> Float -> ExtraColor
oklch l c h =
    ColorOklch <| { l = l, c = c, h = h, alpha = 1 }


{-| Same as `oklch`, but accepts percent values for Lightness.

  - Lightness [0 .. 100]
  - Chroma [0 .. 1]
  - Hue [0 .. 360]
  - Alpha set to 1.

Allows at most 2 decimal places for percent values, e.g. `12.34`. Other decimal places are truncated. If you need more precision, use `oklch` or `oklchPercent`.

-}
oklchPercent : Float -> Float -> Float -> ExtraColor
oklchPercent l c h =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = 1 }


{-| Creates a color with the given lightness, chroma, and hue.

  - Lightness [0 .. 1]
  - Chroma [0 .. 1]
  - Hue [0 .. 360]
  - Alpha [0 .. 1]

-}
oklcha : Float -> Float -> Float -> Float -> ExtraColor
oklcha l c h a =
    ColorOklch <| { l = l, c = c, h = h, alpha = a }


{-| Same as `oklcha`, but accepts percent values for Lightness.

  - Lightness [0 .. 100]
  - Chroma [0 .. 1]
  - Hue [0 .. 360]
  - Alpha [0 .. 1]

Allows at most 2 decimal places for percent values, e.g. `12.34`. Other decimal places are truncated. If you need more precision, use `oklch` or `oklchPercent`.

-}
oklchaPercent : Float -> Float -> Float -> Float -> ExtraColor
oklchaPercent l c h a =
    ColorOklch <| { l = fromPercent l, c = c, h = h, alpha = a }



-- Styling


fontColor : ExtraColor -> Attribute msg
fontColor =
    fontColorStyle >> InlineStyle.render


fontColorStyle : ExtraColor -> InlineStyle
fontColorStyle ce =
    [ ( "color", rgbaToCssString (toRgbaFallback ce) )
    , ( "color", toCssString ce )
    ]


backgroundColor : ExtraColor -> Attribute msg
backgroundColor =
    backgroundColorStyle >> InlineStyle.render


backgroundColorStyle : ExtraColor -> InlineStyle
backgroundColorStyle ce =
    [ ( "background-color", rgbaToCssString (toRgbaFallback ce) )
    , ( "background-color", toCssString ce )
    ]


borderColor : ExtraColor -> Attribute msg
borderColor =
    borderColorStyle >> InlineStyle.render


borderColorStyle : ExtraColor -> InlineStyle
borderColorStyle ce =
    [ ( "border-color", rgbaToCssString (toRgbaFallback ce) )
    , ( "border-color", toCssString ce )
    ]



-- Conversion


{-| This function is not expected to be used frequently,
because you don't often need to display only the fallback color.
It is exposed for demonstration purposes.
-}
toRgbaFallback : ExtraColor -> { r : Float, g : Float, b : Float, alpha : Float }
toRgbaFallback ce =
    case ce of
        ColorOklch x ->
            Culori.convertOklchToRgba x



-- Implementation details


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


rgbaToCssString : Culori.RgbaColor -> String
rgbaToCssString { r, g, b, alpha } =
    -- Note: we use the legacy `rgb` syntax intentionally, because it's a fallback.
    let
        colors : List String
        colors =
            [ r, g, b ]
                |> List.map ((*) 255 >> round >> String.fromInt)
    in
    "rgba("
        ++ String.join ", " colors
        ++ ", "
        ++ String.fromFloat alpha
        ++ ")"
