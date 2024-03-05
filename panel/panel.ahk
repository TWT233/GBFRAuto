#Requires AutoHotkey v2.0

#Include window.ahk
#Include skip.ahk
#Include autokill.ahk
#Include sell.ahk

class Panel {

    root := GUI(, "GBFRAuto")

    window := PanelWindow()
    skip := PanelSkip()
    autokill := PanelAutoKill()
    sell := PanelSell()

    bar := unset

    __New(game_name) {
        this.root.SetFont("s10")
        this.window.Attach(this.root, 10, 9, game_name)
        this.skip.Attach(this.root, 10, 90)
        this.autokill.Attach(this.root, 140, 90)
        this.sell.Attach(this.root,10, 180)

        this.bar := this.root.Add("StatusBar", , "继续挑战 0 | 奖励确认 0 | 任务结算 0")
    }

    Show() {
        this.root.Show()
    }

    OnClose(on_close) {
        this.root.OnEvent("Close", on_close)
    }

    OnGameNameChange(cb) {
        this.window.OnChange(cb)
    }

    UpdateWindowInfo(w, h) {
        this.window.UpdateWindowInfo(w, h)
    }

    UpdateReport(check := 0, back := 0, mission := 0) {
        this.UpdateBar("继续挑战 " check " | 奖励确认 " back " | 任务结算 " mission)
    }

    UpdateBar(info){
        this.bar.SetText(info)
    }
}