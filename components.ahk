#Requires AutoHotkey v2.0

#Include matcher/matcher.ahk
#Include gui/panel.ahk

; const

GAME_NAME := "Granblue Fantasy: Relink"

CONS := {
    ; main match cond
    CHECK: Cond().Imgs(, "./assets/CHECK.png"),
    BACK: Cond().Imgs(, "./assets/BACK.png", "./assets/BACK2.png"),
    MISSION: Cond().Imgs(, "./assets/MISSION.png"),
    AUTOKILL: Cond().Pixels(,
        WhitePixel2K(510, 1325),
        WhitePixel2K(630, 1189),
        WhitePixel2K(377, 1197),
        WhitePixel2K(510, 1060),
    ),
    ; misc
    LotteryLV3: Cond().Imgs(, "./assets/LotteryLV3.png"),
    LotteryFinish: Cond().Imgs(, "./assets/LotteryFinish.png"),
    TicketWithSigil: Cond().Imgs(, "./assets/TicketWithSigil.png"),
    NoAvailableSigil: Cond().Imgs(, "./assets/NoAvailableSigil.png"),
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