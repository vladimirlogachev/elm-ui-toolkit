module TextStyle exposing (body, code, header, subheader, subheader2)

import Element.Font as Font
import Typography exposing (TextStyle)


header : TextStyle msg
header =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.semiBold
        , fontSizePx = 55
        , lineHeightPx = 55
        , letterSpacingPercent = 0
        }


subheader : TextStyle msg
subheader =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.medium
        , fontSizePx = 40
        , lineHeightPx = 40
        , letterSpacingPercent = 0
        }


subheader2 : TextStyle msg
subheader2 =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.medium
        , fontSizePx = 28
        , lineHeightPx = 28
        , letterSpacingPercent = 0
        }


body : TextStyle msg
body =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.regular
        , fontSizePx = 20
        , lineHeightPx = 20
        , letterSpacingPercent = 0
        }


code : TextStyle msg
code =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "JetBrains Mono", Font.monospace ]
        , fontWeight = Font.regular
        , fontSizePx = 16
        , lineHeightPx = 16
        , letterSpacingPercent = 0
        }
