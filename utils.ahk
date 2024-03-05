#Requires AutoHotkey v2.0

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

OnClose(*) {
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
    ExitApp
}
