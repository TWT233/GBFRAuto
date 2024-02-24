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