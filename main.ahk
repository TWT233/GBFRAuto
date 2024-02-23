#Requires AutoHotkey v2.0

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

loop {
    Sleep 500
    if G.v.check == 1 {
        M.OnFound(PATH.CHECK, F_CB_CHECK)
    }
    if G.v.back == 1 {
        M.OnFound(PATH.BACK, F_CB_BACK)
    }
    if G.v.mission == 1 {
        M.OnFound(PATH.MISSION, F_CB_MISSION)
    }
    if G.v.autokill == 1 {
        M.OnFound(PATH.AUTOKILL, F_CB_AUTOKILL)
    }
}

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

F_CB_BACK() {
    Sleep 5000 ; wait for the animation to finish
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
    } until (M.Search(PATH.MISSION) == 0)

    DATA.times.mission++
    Refresh()
}

F_CB_AUTOKILL() {
    loop 30 { ; walk to some place near to the center
        WrappedClick("LButton", 300) ; hit of "just"
        Sleep 4
        WrappedClick("w", 300)
        Sleep 4
    } until (M.Search(C_PATH.AUTOKILL) == 0)
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
    GAME_NAME := edit.Value
    M.SetName(GAME_NAME)
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

WrappedClick(key, len := 50) {
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
}

OnClose(_) {
    ExitApp
}