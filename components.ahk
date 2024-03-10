#Requires AutoHotkey v2.0

#Include matcher.ahk
#Include gui/panel.ahk

; const

GAME_NAME := "Granblue Fantasy: Relink"

PATH := {
    ; main match cond
    CHECK: "./assets/CHECK.png",
    BACK: "./assets/BACK.png",
    BACK2: "./assets/BACK2.png",
    MISSION: "./assets/MISSION.png",
    AUTOKILL: "./assets/autokill.png",
    ; misc
    LotteryLV3: "./assets/LotteryLV3.png",
    LotteryFinish: "./assets/LotteryFinish.png",
    TicketWithSigil: "./assets/TicketWithSigil.png",
    NoAvailableSigil: "./assets/NoAvailableSigil.png"
}

; dynamic global vars

M := Matcher(GAME_NAME)
NG := Panel(GAME_NAME)

DATA := {
    times: {
        check: 0,
        back: 0,
        mission: 0,
        autokill: 0,
    }
}