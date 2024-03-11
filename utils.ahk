#Requires AutoHotkey v2.0

#Include matcher/pixel.ahk

EventClick(key, len := 50, pre := 0, post := 0) {
    Sleep pre
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
    Sleep post
}

GuardLoop(untiler, body, post) {
    while (untiler() == 0) {
        loop {
            body()
        } until (untiler() == 1)
        post()
    }
}

Cleanup() {
    SendEvent("{1 up}")
    SendEvent("{2 up}")
    SendEvent("{3 up}")
    SendEvent("{4 up}")
    SendEvent("{w up}")
    SendEvent("{s up}")
    SendEvent("{q up}")
    SendEvent("{r up}")
    SendEvent("{g up}")
    SendEvent("{MButton up}")
    SendEvent("{RButton up}")
    SendEvent("{LButton up}")
}

OnReset(*) {
    Cleanup()
    Reload
}

OnClose(*) {
    Cleanup()
    ExitApp
}

WhitePixel2K(x, y) {
    return Pixel(Color(0xFF, 0xFF, 0xFF), x, y, 1440)
}