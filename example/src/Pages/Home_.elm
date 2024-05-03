module Pages.Home_ exposing (Model, Msg, page)

import Color
import Effect
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import ExtraColor exposing (ExtraColor)
import GridLayout1 exposing (..)
import Layouts
import Page exposing (Page)
import Route exposing (Route)
import Shared
import TextStyle
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


color1 : ExtraColor
color1 =
    ExtraColor.oklchPercent 68.64 0.255 36.4


color2 : ExtraColor
color2 =
    ExtraColor.oklchPercent 71.87 0.181 229.1


color3 : ExtraColor
color3 =
    ExtraColor.oklchPercent 83.93 0.336 147.57


color4 : ExtraColor
color4 =
    ExtraColor.oklchPercent 91.28 0.208 102.04


pageTitle : String
pageTitle =
    "elm-ui color extra"



-- VIEW


view : Shared.Model -> View msg
view { layout } =
    { title = "elm-ui-color-extra"
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
        ([ paragraph TextStyle.header [ text pageTitle ]
         , gridRow layout
            [ gridColumn layout { widthSteps = 2 } [ Font.color Color.white ] [ text "OKLCH" ]
            , gridColumn layout { widthSteps = 2 } [ Font.color Color.white ] [ text "RGB fallback" ]
            ]
         ]
            ++ List.map (viewColor layout) [ color1, color2, color3, color4 ]
        )


viewColor : LayoutState -> ExtraColor -> Element msg
viewColor layout c =
    gridRow layout
        [ gridBox layout { widthSteps = 2, heightSteps = 2 } [ ExtraColor.backgroundColor c ] []
        , gridBox layout { widthSteps = 2, heightSteps = 2 } [ Background.color (ExtraColor.toRgba c) ] []
        ]
