#Requires AutoHotkey v2.0

#Include panel.ahk
#Include matcher.ahk

; const
C_GAME_NAME := "Granblue Fantasy: Relink"

C_PATH := {
    CHECK: "./assets/继续挑战.png",
    BACK: "./assets/奖励确认.png",
    MISSION: "./assets/任务结算.png",
    AUTOKILL: "./assets/autokill.png",
}

; always an emergency exit
[:: ExitApp

; components
G := GBFRPanel(End)
M := Matcher(C_GAME_NAME)

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

loop {
    Sleep 500
    if G.v.check == 1 {
        M.OnFound(C_PATH.CHECK, F_CB_CHECK)
    }
    if G.v.back == 1 {
        M.OnFound(C_PATH.BACK, F_CB_BACK)
    }
    if G.v.mission == 1 {
        M.OnFound(C_PATH.MISSION, F_CB_MISSION)
    }
    if G.v.autokill == 1 {
        M.OnFound(C_PATH.AUTOKILL, F_CB_AUTOKILL)
    }
}

; init

Init() {
    SetKeyDelay -1

    InitWindowInfo()

    Refresh()
    G.Show()
}

InitWindowInfo() {
    w := 0
    h := 0
    M.CheckWindow(&w, &h)
    G.UpdateWindowInfo(w, h)
}

;;;;;;;;;;;;;
; call backs on search found
;;;;;;;;;;;;;

F_CB_BACK() {
    WrappedClick("LButton", 100)
    Sleep 1000
    WrappedClick("LButton", 100)
    Sleep 1000

    DATA.times.back++
    Refresh()
}

F_CB_CHECK() {
    WrappedClick("w")
    Sleep 1000
    WrappedClick("LButton")

    DATA.times.check++
    Refresh()
}

F_CB_MISSION() {
    loop {
        WrappedClick("LButton")
        Sleep 200
    } until (M.Search(C_PATH.MISSION) == 0)

    DATA.times.mission++
    Refresh()
}

F_CB_AUTOKILL() {
    loop {
        loop 120 {
            WrappedClick("LButton", 4)
            Sleep 4
        }
    } until (M.Search(C_PATH.AUTOKILL) == 0)
}

;;;;;;;;;;;;;
; util functions
;;;;;;;;;;;;;

Refresh() {
    t := DATA.times
    G.UpdateTimesReport(t.mission, t.back, t.check)
}

WrappedClick(key, len := 50) {
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
}

End(_) {
    ExitApp
}