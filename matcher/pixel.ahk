#Requires AutoHotkey v2.0

class Color {
    __New(r, g, b) {
        this.r := r
        this.g := g
        this.b := b
    }

    ToString() {
        return Format("{:02X}{:02X}{:02X}", this.r, this.g, this.b)
    }

}


class Pixel {
    __New(color, x, y, h) {
        this.color := color

        this.x := x
        this.y := y
        this.h := h
    }

    MatchWithShades(color, shades := 2) {
        ; MsgBox(color.ToString() " vs " this.color.ToString())
        dr := Abs(color.r - this.color.r)
        dg := Abs(color.g - this.color.g)
        db := Abs(color.b - this.color.b)
        return dr <= shades && dg <= shades && db <= shades
    }

    ToString() {
        return Format("[{},{}]({})", this.x, this.y, this.color.ToString())
    }
}

HexToColor(hex) {
    return Color(
        ("0x" SubStr(hex, 3, 2)) + 0,
        ("0x" SubStr(hex, 5, 2)) + 0,
        ("0x" SubStr(hex, 7, 2)) + 0
    )
}