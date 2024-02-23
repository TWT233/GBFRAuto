#Requires AutoHotkey v2.0

EventClick(key, len := 50, pre := 0, post := 0) {
    Sleep pre
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
    Sleep post
}

OnClose(_) {
    ExitApp
}