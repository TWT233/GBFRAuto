#Requires AutoHotkey v2.0


class Condition {
    path := "" ; path to trigger image

    cb := 0 ; callback on match

    enabler := 0 ; dynamic check if this condition is enabled

    __New(path, cb, enabler) {
        this.path := path
        this.cb := cb
        this.enabler := enabler
    }
}