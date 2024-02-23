#Requires AutoHotkey v2.0

WrappedClick(key, len := 50) {
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
}

OnClose(_) {
    ExitApp
}