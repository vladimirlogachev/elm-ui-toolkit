module Culori exposing (OklchColor, RgbaColor, convertOklchToRgba)


type alias OklchColor =
    { l : Float
    , c : Float
    , h : Float
    , alpha : Float
    }


type alias LabColor =
    { l : Float
    , a : Float
    , b : Float
    , alpha : Float
    }


type alias RgbaColor =
    { r : Float
    , g : Float
    , b : Float
    , alpha : Float
    }


convertOklchToRgba : OklchColor -> RgbaColor
convertOklchToRgba c =
    convertLrgbToRgb <| convertOklabToLrgb <| convertLchToLab c


convertLchToLab : OklchColor -> LabColor
convertLchToLab { l, c, h, alpha } =
    { l = l
    , a =
        if c /= 0 then
            c * cos ((h / 180) * pi)

        else
            0
    , b =
        if c /= 0 then
            c * sin ((h / 180) * pi)

        else
            0
    , alpha = alpha
    }


convertOklabToLrgb : LabColor -> RgbaColor
convertOklabToLrgb { l, a, b, alpha } =
    let
        l_ : Float
        l_ =
            l
                * 0.9999999984505198
                + 0.39633779217376786
                * a
                + 0.2158037580607588
                * b
                |> (\x -> x ^ 3)

        m : Float
        m =
            l
                * 1.0000000088817609
                - 0.10556134232365635
                * a
                - 0.06385417477170591
                * b
                |> (\x -> x ^ 3)

        s : Float
        s =
            l
                * 1.0000000546724108
                - 0.08948418209496575
                * a
                - 1.2914855378640917
                * b
                |> (\x -> x ^ 3)
    in
    { r = 4.076741661347994 * l_ - 3.307711590408193 * m + 0.230969928729428 * s
    , g = -1.2684380040921763 * l_ + 2.6097574006633715 * m - 0.3413193963102197 * s
    , b = -0.004196086541837188 * l_ - 0.7034186144594493 * m + 1.7076147009309444 * s
    , alpha = alpha
    }


fn : Float -> Float
fn c =
    let
        absC : Float
        absC =
            abs c
    in
    if absC > 0.0031308 then
        let
            sign : Float
            sign =
                if c < 0 then
                    -1

                else
                    1
        in
        sign * (1.055 * (absC ^ (1 / 2.4)) - 0.055)

    else
        c * 12.92


convertLrgbToRgb : RgbaColor -> RgbaColor
convertLrgbToRgb { r, g, b, alpha } =
    { r = clamp 0 1 <| fn r
    , g = clamp 0 1 <| fn g
    , b = clamp 0 1 <| fn b
    , alpha = clamp 0 1 alpha
    }
