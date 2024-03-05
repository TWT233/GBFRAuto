#Requires AutoHotkey v2.0

#Include const.ahk
#Include matcher.ahk
#Include panel/panel.ahk

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