#Requires AutoHotkey v2.0

; always an emergency exit
[:: ExitApp

; CONST
CONST_WINDOW_INFO := "WINDOW_INFO"
CONST_TIMES_REPORT := "TIMES_REPORT"

CONST_PATH:={
    CHECK: "./assets/继续挑战.png",
    BACK: "./assets/奖励确认.png",
    MISSION: "./assets/任务结算.png",
    AUTOKILL: "./assets/autokill.png",
}

; global vars
GAME_WINDOW := {
    W: 0,
    H: 0,
}

NEED := {
    CHECK: 1,
    BACK: 1,
    MISSION: 1,
    AUTOKILL: 0,
}

TIMES := {
    CHECK: 0,
    BACK: 0,
    MISSION: 0,
    AUTOKILL: 0,
}

G := Gui("", "GBFR Auto")

; main loop

InitGUI()
InitWindowInfo()

loop {
    Sleep 500
    if NEED.CHECK == 1 {
        OnFound(CONST_PATH.CHECK, F_CB_CHECK)
    }
    if NEED.BACK == 1 {
        OnFound(CONST_PATH.BACK, F_CB_BACK)
    }
    if NEED.MISSION == 1 {
        OnFound(CONST_PATH.MISSION, F_CB_MISSION)
    }
    if NEED.AUTOKILL == 1 {
        OnFound(CONST_PATH.AUTOKILL, F_CB_AUTOKILL)
    }
}

; init

InitGUI() {
    global G
    G.SetFont("s10")
    G.OnEvent("Close", End)

    G.Add("Text", "w200 v" CONST_WINDOW_INFO, "")

    G.Add("Text", "w200 v" CONST_TIMES_REPORT, "`n`r`n`r")
    RefreshTimesReport()

    G.Add("CheckBox", "vCB_NEED_MISSION Checked", "跳过任务结算").OnEvent("Click", CB_NEED_MISSION)
    CB_NEED_MISSION(cb, info) {
        NEED.MISSION := cb.Value
    }

    G.Add("CheckBox", "vCB_NEED_BACK Checked", "跳过奖励确认").OnEvent("Click", CB_NEED_BACK)
    CB_NEED_BACK(cb, info) {
        NEED.BACK := cb.Value
    }

    G.Add("CheckBox", "vCB_NEED_CHECK Checked", "自动继续挑战").OnEvent("Click", CB_NEED_CHECK)
    CB_NEED_CHECK(cb, info) {
        NEED.CHECK := cb.Value
    }

    G.Add("CheckBox", "vCB_NEED_AUTOKILL", "自动连发平A（仅限史莱姆本）").OnEvent("Click", CB_NEED_AUTOKILL)
    CB_NEED_AUTOKILL(cb, info) {
        NEED.AUTOKILL := cb.Value
    }

    G.Show()
}

InitWindowInfo() {
    W := 0
    H := 0
    WinGetClientPos(, , &W, &H, "Granblue Fantasy: Relink")
    GAME_WINDOW.W := W
    GAME_WINDOW.H := H
    G.__Item[CONST_WINDOW_INFO].Value := "游戏窗口大小：" GAME_WINDOW.W " x " GAME_WINDOW.H
}

;;;;;;;;;;;;;
; call backs on search found
;;;;;;;;;;;;;

F_CB_BACK() {
    WrappedClick("LButton")
    Sleep 1000
    WrappedClick("LButton")
    Sleep 1000

    TIMES.BACK += 1
    RefreshTimesReport()
}

F_CB_CHECK() {
    WrappedClick("w")
    Sleep 1000
    WrappedClick("LButton")

    TIMES.CHECK += 1
    RefreshTimesReport()
}

F_CB_MISSION() {
    loop {
        WrappedClick("LButton")
        Sleep 200
    } until (Search(CONST_PATH.MISSION) == 0)

    TIMES.MISSION += 1
    RefreshTimesReport()
}

F_CB_AUTOKILL() {
    loop {
        loop 120 {
            WrappedClick("LButton", 4)
            Sleep 4
        }
    } until (Search(CONST_PATH.AUTOKILL) == 0)
}

;;;;;;;;;;;;;
; util functions
;;;;;;;;;;;;;

RefreshTimesReport() {
    G.__Item[CONST_TIMES_REPORT].Value := (
        "跳过任务结算：" TIMES.MISSION " 次`n"
        "跳过奖励确认：" TIMES.BACK " 次`n"
        "自动继续挑战：" TIMES.CHECK " 次`n"
    )
}

OnFound(path, callback) {
    if Search(path) == 0 {
        return
    }
    callback()
}

Search(path) {
    _ := 0
    return ImageSearch(&_, &_, 0, 0, GAME_WINDOW.W, GAME_WINDOW.H, "*128 *TransBlack *w" GAME_WINDOW.W " *h-1 " path)
}


WrappedClick(key, len := 50) {
    SendEvent "{" key " Down}"
    Sleep len
    SendEvent "{" key " up}"
}

End(_) {
    ExitApp
}