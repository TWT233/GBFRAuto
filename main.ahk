﻿#Requires AutoHotkey v2.0

#Include utils.ahk
#Include macro.ahk
#Include components.ahk

; main
Init()

M.Register(CONDS.CHECK, CB_CHECK, (*) => P.skip.check)
M.Register(CONDS.BACK, CB_BACK, (*) => P.skip.back)
M.Register(CONDS.MISSION, CB_MISSION, (*) => P.skip.mission)
M.Register(CONDS.AUTOKILL, CB_AUTOKILL, (*) => P.autokill.all)

M.Run()

; init

Init() {
    SetKeyDelay -1

    Refresh()

    P.hotkey.BindReset(OnReset, "]")
    P.hotkey.BindExit(OnClose, "[")
    P.hotkey.BindSellSigils(SellSigilsAndLottery, "\")
    P.hotkey.BindSellCharms(SellCharmAndLottery, "=")

    P.OnClose(OnClose)
    P.OnGameNameChange((edit, *) => (
        M.name := edit.Value
        Refresh()
    ))
    P.Show()
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
    } until (M.Match(CONDS.MISSION) == 0)

    DATA.times.mission++
    Refresh()
}

CB_AUTOKILL(*) {
    v := P.autokill

    AUTOKILL_ENTER()
    loop {
        if v.aaa {
            loop 20 {
                EventClick("LButton", 15, , 15)
            }
        } else if v.seya {
            EventClick("RButton", 15, , 15)
        } else {
            Sleep(500)
        }
        AUTOKILL_ROUTINED(M, v)
    } until (M.Match(CONDS.AUTOKILL) == 0)
    AUTOKILL_LEAVE()
}

AUTOKILL_ENTER() {
    v := P.autokill

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
    v := P.autokill

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

AUTOKILL_ROUTINED(M, v) {
    if v.skills {
        AUTOKILL_SKILLS()
    }
    if v.r {
        EventClick("r", 20, , 20)
    }
    if v.g {
        EventClick("g", 20, , 20)
    }
    if v.chain {
        GuardLoop(() => (!M.Match(CONDS.CHAIN)), () => (EventClick("g", 20, , 20)), () => 0)
    }
}

AUTOKILL_SKILLS() {
    EventClick("1", 20, , 20)
    EventClick("2", 20, , 20)
    EventClick("3", 20, , 20)
    EventClick("4", 20, , 20)
}

; util functions

Refresh() {
    t := DATA.times
    P.UpdateReport(t.check, t.back, t.mission)

    w := 0
    h := 0
    M.GetGameWindow(&w, &h)
    P.UpdateWindowInfo(w, h)
}