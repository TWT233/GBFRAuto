#Requires AutoHotkey v2.0

CTRL_NAME := {
    game_name: "E_GAME_NAME",
    window_info: "WINDOW_INFO",
    times_report: "TIMES_REPORT",
}

class GBFRPanel {
    ; internal GUI
    g := 0

    v := { ; Value, for those data flows out only
        check: 1,
        back: 1,
        mission: 1,
        autokill: 0,
        step_for_slime: 0,
        sell_rounds: 0,
    }

    __New(on_close) {
        this.g := Gui("", "GBFR Auto")
        g := this.g
        v := this.v

        g.SetFont("s10")
        g.OnEvent("Close", on_close)

        g.Add("Text", , "游戏窗口名：(一般不改 PS才用)")
        g.Add("Edit", "v" CTRL_NAME.game_name, "")
        g.Add("Text", "w200 v" CTRL_NAME.window_info)

        g.Add("Text", , " ")

        g.Add("CheckBox", "vCB_NEED_MISSION Checked", "跳过任务结算")
            .OnEvent("Click", (cb, *) => (v.mission := cb.Value))

        g.Add("CheckBox", "vCB_NEED_BACK Checked", "跳过奖励确认")
            .OnEvent("Click", (cb, *) => (v.back := cb.Value))

        g.Add("CheckBox", "vCB_NEED_CHECK Checked", "自动继续挑战")
            .OnEvent("Click", (cb, *) => (v.check := cb.Value))

        g.Add("Text", "w200 v" CTRL_NAME.times_report, "`n`r`n`r")

        g.Add("Text", , " ")

        g.Add("CheckBox", "vCB_NEED_AUTOKILL", "自动连发平A")
            .OnEvent("Click", (cb, *) => (v.autokill := cb.Value))

        g.Add("CheckBox", "vCB_NEED_STEP_FOR_SLIME", "自动连发平A前先前滚五下`n（史莱姆大军特化）")
            .OnEvent("Click", (cb, *) => (v.step_for_slime := cb.Value))

        g.Add("Text", , " ")

        g.Add("Text", , "自动卖因子轮数：(0为卖到筛选空)")
        g.Add("Edit")
        g.Add("UpDown", "vUD_SELL_ROUNDS Range0-10", 0)
            .OnEvent("Change", (ud, *) => (v.sell_rounds := ud.Value))
    }

    Show() {
        this.G.Show()
    }

    BindGameName(on_change, initial) {
        item := this.g.__Item[CTRL_NAME.game_name]
        item.Value := initial
        item.OnEvent("Change", on_change)
    }

    UpdateWindowInfo(w, h) {
        this.g.__Item[CTRL_NAME.window_info].Value := "游戏窗口大小：" w " x " h
    }

    UpdateTimesReport(mission, back, check) {
        this.g.__Item[CTRL_NAME.times_report].Value := (
            "跳过任务结算：" mission " 次`n"
            "跳过奖励确认：" back " 次`n"
            "自动继续挑战：" check " 次`n"
        )
    }
}