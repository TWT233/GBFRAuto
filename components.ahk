#Requires AutoHotkey v2.0

#Include matcher/matcher.ahk
#Include gui/panel.ahk
#Include utils.ahk

; const

GAME_NAME := "Granblue Fantasy: Relink"

CONS := {
    ; main match cond
    CHECK: Cond().Imgs(, "./assets/CHECK.png"),
    BACK: Cond().Imgs(, "./assets/BACK.png", "./assets/BACK2.png"),
    MISSION: Cond().Imgs(, "./assets/MISSION.png"),
    AUTOKILL: Cond().Pixels(,
        WhitePixel2K(510, 1325),
        WhitePixel2K(377, 1197),
        WhitePixel2K(510, 1060),
    ),
    CHAIN: Cond().Pixels(40,
        CHAINPixel(1274, 110),
        CHAINPixel(1156, 866),
        CHAINPixel(1599, 892),
    ),
    ; misc
    LotteryLV3: Cond().Pixels(10,
        Pixel(Color(113, 98, 78), 600, 380, 1440),
        Pixel(Color(113, 98, 78), 600, 525, 1440),
    ),
    SieroTop: Cond().Imgs(, "./assets/SieroTop.png"),
}

; dynamic global vars

M := Matcher(GAME_NAME)
P := Panel(GAME_NAME)

DATA := {
    times: {
        check: 0,
        back: 0,
        mission: 0,
        autokill: 0,
    }
}