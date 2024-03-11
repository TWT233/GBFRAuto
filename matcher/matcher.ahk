#Requires AutoHotkey v2.0

#Include cond.ahk


class Matcher {
    name := "" ; attached window name

    interval := 500

    regs := [] ; registered conditions

    __New(name, interval := 500) {
        this.name := name
        this.interval := interval
    }

    Register(con, cb, enabler := (*) => true) {
        this.regs.Push({
            cond: con,
            cb: cb,
            enabler: enabler,
        })
    }

    Run() {
        loop {
            Sleep(this.interval)

            if (!this.IsCurrentGameWindow()) {
                continue
            }

            for reg in this.regs {
                if reg.enabler() != 1 {
                    continue
                }
                if this.Match(reg.cond) == 0 {
                    continue
                }
                reg.cb()
            }
        }
    }

    Match(con) {
        return con.matcher(this)
    }

    ; returns 1 if exists, otherwise 0
    GetGameWindow(&w, &h) {
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

    IsCurrentGameWindow() {
        return !!WinActive(this.name)
    }

}