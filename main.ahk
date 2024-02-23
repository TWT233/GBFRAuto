#Requires AutoHotkey v2.0

#Include utils.ahk
#Include panel.ahk
#Include matcher.ahk

; configurable
GAME_NAME := "Granblue Fantasy: Relink"

PATH := {
    CHECK: "./assets/继续挑战.png",
    BACK: "./assets/奖励确认.png",
    MISSION: "./assets/任务结算.png",
    AUTOKILL: "./assets/autokill.png",
}

; always an emergency exit
[:: ExitApp

; components
G := GBFRPanel(GAME_NAME, OnGameNameChanged, OnClose)
M := Matcher(GAME_NAME)

DATA := {
    times: {
        check: 0,
        back: 0,
        mission: 0,
        autokill: 0,
    }
}

; main
Init()

M.Add(Condition(PATH.CHECK, CB_CHECK, (*) => G.v.check))
M.Add(Condition(PATH.BACK, CB_BACK, (*) => G.v.back))
M.Add(Condition(PATH.MISSION, CB_MISSION, (*) => G.v.mission))
M.Add(Condition(PATH.AUTOKILL, CB_AUTOKILL, (*) => G.v.autokill))

M.Run()

; init

Init() {
    SetKeyDelay -1

    RefreshWindowInfo()

    Refresh()
    G.Show()
}


;;;;;;;;;;;;;
; call backs on search found
;;;;;;;;;;;;;

CB_BACK(*) {
    Sleep 500
    WrappedClick("LButton")
    Sleep 500
    WrappedClick("LButton")

    DATA.times.back++
    Refresh()
}

CB_CHECK(*) {
    Sleep 500
    WrappedClick("w")
    Sleep 500
    WrappedClick("LButton")

    DATA.times.check++
    Refresh()
}

CB_MISSION(*) {
    loop {
        WrappedClick("LButton")
        Sleep 200
    } until (M.Search(PATH.MISSION) == 0)

    DATA.times.mission++
    Refresh()
}

CB_AUTOKILL(*) {
    if G.v.step_for_slime{
        loop 3{
            SendEvent "{w Down}"
            SendEvent "{e Down}"
            Sleep 50
            SendEvent "{e up}"
            SendEvent "{w up}"
            Sleep 500
        }
        Sleep 1100
        loop 2{
            SendEvent "{w Down}"
            SendEvent "{e Down}"
            Sleep 50
            SendEvent "{e up}"
            SendEvent "{w up}"
            Sleep 500
        }
    }
    loop {
        loop 120 {
            WrappedClick("LButton", 4)
            Sleep 4
        }
    } until (M.Search(PATH.AUTOKILL) == 0)
}

;;;;;;;;;;;;;
; util functions
;;;;;;;;;;;;;

OnGameNameChanged(edit, info) {
    M.name := edit.Value
    Refresh()
}

Refresh() {
    t := DATA.times
    G.UpdateTimesReport(t.mission, t.back, t.check)

    RefreshWindowInfo()
}

RefreshWindowInfo() {
    w := 0
    h := 0
    M.CheckWindow(&w, &h)
    G.UpdateWindowInfo(w, h)
}
