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

    Pixels(pixels*) {
        matcher(this, M) {
            w := 0
            h := 0
            ret := M.GetGameWindow(&w, &h)
            if ret != 1 {
                return 0
            }

            for p in pixels {
                ratio := h // p.h
                if p.val != PixelGetColor(p.x * ratio, p.y * ratio) {
                    return false
                }
            }
            return true
        }
        return this
    }
}