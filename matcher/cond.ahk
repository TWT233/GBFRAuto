#Requires AutoHotkey v2.0

#Include pixel.ahk

class Cond {
    matcher := unset

    Imgs(shades := 128, paths*) {
        matcher(this, M) {
            w := 0
            h := 0
            ret := M.GetGameWindow(&w, &h)
            if ret != 1 {
                return 0
            }

            _ := 0
            for p in paths {
                if ImageSearch(&_, &_, 0, 0, w, h, "*" shades " *TransBlack *w" w " *h-1 " p) == true {
                    return true
                }
            }
            return false
        }
        this.matcher := matcher
        return this
    }

    Pixels(shades := 2, pixels*) {
        matcher(this, M) {
            w := 0
            h := 0
            ret := M.GetGameWindow(&w, &h)
            if ret != 1 {
                return 0
            }

            for p in pixels {
                val := HexToColor(PixelGetColor(p.x * h // p.h, p.y * h // p.h))
                if !p.MatchWithShades(val, shades) {
                    NG.UpdateBar("miss " p.ToString() " " val.ToString())
                    return false
                }
            }
            return true
        }
        this.matcher := matcher
        return this
    }
}