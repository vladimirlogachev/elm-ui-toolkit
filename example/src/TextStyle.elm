module TextStyle exposing (body, code, header, header2, headline)

import Element.Font as Font
import Element.Region as Region
import Typography exposing (TextStyle)


headline : TextStyle msg
headline =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.semiBold
        , fontSizePx = 55
        , lineHeightPx = 55
        , letterSpacingPercent = 0
        , region = Just <| Region.heading 1
        }


header : TextStyle msg
header =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.medium
        , fontSizePx = 40
        , lineHeightPx = 40
        , letterSpacingPercent = 0
        , region = Just <| Region.heading 2
        }


header2 : TextStyle msg
header2 =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.medium
        , fontSizePx = 28
        , lineHeightPx = 28
        , letterSpacingPercent = 0
        , region = Just <| Region.heading 3
        }


body : TextStyle msg
body =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "Inter", Font.sansSerif ]
        , fontWeight = Font.regular
        , fontSizePx = 20
        , lineHeightPx = 20
        , letterSpacingPercent = 0
        , region = Nothing
        }


code : TextStyle msg
code =
    Typography.textStyleFromFigma
        { fontFamily = [ Font.typeface "JetBrains Mono", Font.monospace ]
        , fontWeight = Font.regular
        , fontSizePx = 16
        , lineHeightPx = 16
        , letterSpacingPercent = 0
        , region = Just Region.mainContent
        }
