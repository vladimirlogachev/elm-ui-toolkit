module Pages.Home_ exposing (Model, Msg, page)

import Color
import Effect
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import ExtraColor exposing (ExtraColor)
import GridLayout1 exposing (..)
import InlineStyle exposing (InlineStyle)
import Layouts
import Page exposing (Page)
import Route exposing (Route)
import Shared
import TextStyle
import Typography exposing (preparedText)
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    ()


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = always ( (), Effect.none )
        , update = \_ _ -> ( (), Effect.none )
        , subscriptions = always Sub.none
        , view = always <| view shared
        }
        |> Page.withLayout (always <| Layouts.SingleSectionLayout {})



-- DATA


type ColorSample
    = As_oklch Float Float Float
    | As_oklchPercent Float Float Float
    | As_oklcha Float Float Float Float
    | As_oklchaPercent Float Float Float Float


toElmCode : ColorSample -> String
toElmCode sample =
    case sample of
        As_oklch l c h ->
            "oklch " ++ String.fromFloat l ++ " " ++ String.fromFloat c ++ " " ++ String.fromFloat h

        As_oklchPercent l c h ->
            "oklchPercent " ++ String.fromFloat l ++ " " ++ String.fromFloat c ++ " " ++ String.fromFloat h

        As_oklcha l c h a ->
            "oklcha " ++ String.fromFloat l ++ " " ++ String.fromFloat c ++ " " ++ String.fromFloat h ++ " " ++ String.fromFloat a

        As_oklchaPercent l c h a ->
            "oklchaPercent " ++ String.fromFloat l ++ String.fromFloat c ++ " " ++ String.fromFloat h ++ " " ++ String.fromFloat a


toExtraColor : ColorSample -> ExtraColor
toExtraColor sample =
    case sample of
        As_oklch l c h ->
            ExtraColor.oklch l c h

        As_oklchPercent l c h ->
            ExtraColor.oklchPercent l c h

        As_oklcha l c h a ->
            ExtraColor.oklcha l c h a

        As_oklchaPercent l c h a ->
            ExtraColor.oklchaPercent l c h a


color1 : ColorSample
color1 =
    As_oklch 0.6864 0.255 36.4


color2 : ColorSample
color2 =
    As_oklchPercent 72.75 0.181 229.1


color3 : ColorSample
color3 =
    As_oklcha 0.8393 0.336 147.57 0.5


color4 : ColorSample
color4 =
    As_oklchaPercent 91.28 0.208 102.04 0.5


pageTitle : String
pageTitle =
    "elm-ui-toolkit"


sampleText : String
sampleText =
    """There is an island in the ocean where in 1914 a few Englishmen,
Frenchmen, and Germans lived. No cable reaches that island, and the
British mail steamer comes but once in sixty days. In September it had
not yet come, and the islanders were still talking about the latest
newspaper which told about the approaching trial of Madame Caillaux
for the shooting of Gaston Calmette. It was, therefore, with more than
usual eagerness that the whole colony assembled at the quay on a day
in mid-September to hear from the captain what the verdict had been.
They learned that for over six weeks now those of them who were
English and those of them who were French had been fighting in behalf
of the sanctity of treaties against those of them who were Germans.
For six strange weeks they had acted as if they were friends, when in
fact they were enemies."""



-- VIEW


view : Shared.Model -> View msg
view { layout } =
    { title = pageTitle
    , attributes = [ Background.color Color.black, Font.color Color.white ]
    , element =
        viewMobile layout
    }


viewMobile : LayoutState -> Element msg
viewMobile layout =
    column
        [ width fill
        , spacing layout.grid.gutter
        ]
        [ paragraph TextStyle.headline.attrs [ text pageTitle ]
        , paragraph TextStyle.header.attrs [ text "ExtraColor" ]
        , column [ width fill, spacing 12, Font.color Color.grey ]
            [ paragraph [] [ preparedText "Wide-gamut colors (OKLCH, DCI-P3, Rec. 2020) for elm-ui" ]
            , paragraph [] [ preparedText "Browsers will display a similar color anyway, even if it's not supported by the display." ]
            , paragraph [] [ preparedText "Think of the calculated fallback color as the one that will be used by the outdated browsers." ]
            , paragraph [] [ text "This package heavily borrows from the ", newTabLink [ ExtraColor.fontColor Color.blue ] { url = "https://culorijs.org/", label = preparedText "culori" }, text " library." ]
            ]
        , paragraph TextStyle.header2.attrs [ text "More info" ]
        , column [ width fill, spacing 12, Font.color Color.grey ]
            [ paragraph [] [ newTabLink [ ExtraColor.fontColor Color.blue ] { url = "https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl", label = preparedText "OKLCH in CSS: why we moved from RGB and HSL (by Evil Martians)" } ]
            , paragraph [] [ newTabLink [ ExtraColor.fontColor Color.blue ] { url = "https://oklch.com", label = preparedText "OKLCH Color Picker & Converter (by Evil Martians)" } ]
            , paragraph [] [ newTabLink [ ExtraColor.fontColor Color.blue ] { url = "https://oklch-palette.vercel.app", label = preparedText "OKlch palette generator (by Pleisto)" } ]
            ]
        , paragraph TextStyle.header2.attrs [ text "Examples" ]
        , column [ width fill, spacing layout.grid.gutter ] <|
            (gridRow layout
                [ gridColumn layout { widthSteps = 4 } [ Font.color Color.grey ] [ text "Elm code" ]
                , gridColumn layout { widthSteps = 1 } [ Font.color Color.grey ] [ text "Color" ]
                , gridColumn layout { widthSteps = 1 } [ Font.color Color.grey ] [ text "Fallback" ]
                , gridColumn layout { widthSteps = 6 } [ Font.color Color.grey ] [ text "Actual inline style" ]
                ]
                :: List.map (viewColor layout) [ color1, color2, color3, color4 ]
            )
        , paragraph TextStyle.header.attrs [ text "Typography" ]
        , paragraph [] [ text "Notice how the lines are wrapped:" ]
        , paragraph [ Font.color Color.grey ] [ preparedText sampleText ]
        ]


viewColor : LayoutState -> ColorSample -> Element msg
viewColor layout sample =
    let
        color : ExtraColor
        color =
            toExtraColor sample
    in
    gridRow layout
        [ gridColumn layout
            { widthSteps = 4 }
            [ Font.color Color.grey ]
            [ paragraph TextStyle.code.attrs [ text <| toElmCode sample ] ]
        , gridBox layout
            { widthSteps = 1, heightSteps = 1 }
            [ ExtraColor.backgroundColor color ]
            []
        , gridBox layout
            { widthSteps = 1, heightSteps = 1 }
            [ Background.color <| toElmUiColor <| ExtraColor.toRgbaFallback color ]
            []
        , gridColumn layout
            { widthSteps = 6 }
            [ Font.color Color.grey ]
            [ renderInlineStyleForPreview (ExtraColor.backgroundColorStyle color) ]
        ]


toElmUiColor : { r : Float, g : Float, b : Float, alpha : Float } -> Color
toElmUiColor { r, g, b, alpha } =
    Element.rgba r g b alpha


renderInlineStyleForPreview : InlineStyle -> Element msg
renderInlineStyleForPreview =
    List.map (\( k, v ) -> paragraph TextStyle.code.attrs [ text <| k ++ ": " ++ v ++ ";" ])
        >> column [ spacing 8 ]
