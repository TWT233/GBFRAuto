#Requires AutoHotkey v2.0

#Include utils.ahk
#Include km.ahk
#Include components.ahk

; main
Init()

M.Add(Condition(PATH.CHECK, CB_CHECK, (*) => NG.skip.check))
M.Add(Condition(PATH.BACK, CB_BACK, (*) => NG.skip.back))
M.Add(Condition(PATH.BACK2, CB_BACK, (*) => NG.skip.back))
M.Add(Condition(PATH.MISSION, CB_MISSION, (*) => NG.skip.mission))
M.Add(Condition(PATH.AUTOKILL, CB_AUTOKILL, (*) => NG.autokill.all))

M.Run()

; init

Init() {
    SetKeyDelay -1

    Refresh()

    NG.hotkey.BindReset(OnReset, "]")
    NG.hotkey.BindExit(OnClose, "[")
    NG.hotkey.BindSell(AutoSellAndLottery, "\")

    NG.OnClose(OnClose)
    NG.OnGameNameChange((edit, *) => (
        M.name := edit.Value
        Refresh()
    ))
    NG.Show()
}

; call backs on search found

CB_BACK(*) {
    EventClick("LButton", , 500)
    EventClick("LButton", , 500)

    DATA.times.back++
    Refresh()
}

CB_CHECK(*) {
    EventClick("w", , 500)
    EventClick("LButton", , 500)

    DATA.times.check++
    Refresh()
}

CB_MISSION(*) {
    loop {
        EventClick("LButton", , , 200)
    } until (M.Search(PATH.MISSION) == 0)

    DATA.times.mission++
    Refresh()
}

CB_AUTOKILL(*) {
    v := NG.autokill

    AUTOKILL_ENTER()
    loop {
        if v.aaa {
            loop 50 {
                EventClick("LButton", 4, , 4)
            }
        } else if v.seya {
            loop 40 {
                EventClick("RButton", 4, , 4)
            }
        } else {
            Sleep(500)
        }

        if v.skills {
            AUTOKILL_SKILLS()
        }
        if v.r_and_g {
            AUTOKILL_R_AND_G()
        }
    } until (M.Search(PATH.AUTOKILL) == 0)
    AUTOKILL_LEAVE()
}

AUTOKILL_ENTER() {
    v := NG.autokill

    if v.guard {
        SendEvent("{q down}")
    }
    if v.aim {
        SendEvent("{MButton down}")
    }
    if v.forward {
        SendEvent("{w down}")
    }
}

AUTOKILL_LEAVE() {
    v := NG.autokill

    if v.guard {
        SendEvent("{q up}")
    }
    if v.aim {
        SendEvent("{MButton up}")
    }
    if v.forward {
        SendEvent("{w up}")
    }
}

AUTOKILL_SKILLS() {
    EventClick("1", 4, , 4)
    EventClick("2", 4, , 4)
    EventClick("3", 4, , 4)
    EventClick("4", 4, , 4)
}

AUTOKILL_R_AND_G() {
    EventClick("r", 4, , 4)
    EventClick("g", 4, , 4)
}

; util functions

Refresh() {
    t := DATA.times
    NG.UpdateReport(t.check, t.back, t.mission)

    w := 0
    h := 0
    M.CheckWindow(&w, &h)
    NG.UpdateWindowInfo(w, h)
}