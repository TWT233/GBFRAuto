#Requires AutoHotkey v2.0

class Condition {
    paths := [] ; path to trigger image

    cb := 0 ; callback on match

    enabler := 0 ; dynamic check if this condition is enabled

    __New(paths, cb, enabler) {
        if Type(paths) != "Array" {
            paths := [paths]
        }
        this.paths := paths
        this.cb := cb
        this.enabler := enabler
    }
}

class Matcher {
    name := "" ; attached window name

    interval := 500

    conds := [] ; registered conditions

    __New(name, interval := 500) {
        this.name := name
        this.interval := interval
    }

    Add(cond) {
        this.conds.Push(cond)
    }

    Run() {
        loop {
            Sleep(this.interval)
            for cond in this.conds {
                if cond.enabler() != 1 {
                    continue
                }
                if this.Search(cond.paths) == 0 {
                    continue
                }
                cond.cb()
            }
        }
    }

    Search(paths, shades := 128) {
        w := 0
        h := 0
        ret := this.CheckWindow(&w, &h)
        if ret != 1 {
            return 0
        }

        _ := 0
        ps := paths
        if Type(paths) != "Array" {
            ps := [paths]
        }
        for p in ps {
            if ImageSearch(&_, &_, 0, 0, w, h, "*" shades " *TransBlack *w" w " *h-1 " p) == true {
                return true
            }
        }
        return false
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