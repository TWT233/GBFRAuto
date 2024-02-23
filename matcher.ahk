#Requires AutoHotkey v2.0

class Matcher {
    name => String ; attached window name

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
        WinGetClientPos(, , &w, &h, this.name)

        _ := 0
        return ImageSearch(&_, &_, 0, 0, w, h, "*128 *TransBlack *w" w " *h-1 " path)
    }

    ; returns 1 if exists, otherwise 0
    CheckWindow(&w, &h) {
        try {
            WinGetClientPos(, , &w, &h, this.name)
        }
        catch TargetError {
            return 0
        }
        return 1
    }
}