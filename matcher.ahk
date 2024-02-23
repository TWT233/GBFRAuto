#Requires AutoHotkey v2.0

class Matcher {
    name := "" ; attached window name

    __New(name) {
        this.SetName(name)
    }

    SetName(name) {
        this.name := name
    }

    OnFound(path, callback) {
        if this.Search(path) == 0 {
            return
        }
        callback()
    }

    Search(path) {
        w := 0
        h := 0
        ret := this.CheckWindow(&w, &h)
        if ret != 1 {
            return 0
        }

        _ := 0
        return ImageSearch(&_, &_, 0, 0, w, h, "*128 *TransBlack *w" w " *h-1 " path)
    }

    ; returns 1 if exists, otherwise 0
    CheckWindow(&w, &h) {
        try {
            WinGetClientPos(, , &w, &h, this.name)
        }
        catch TargetError {
            w := 0
            h := 0
            return 0
        }
        return 1
    }
}