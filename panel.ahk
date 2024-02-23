#Requires AutoHotkey v2.0

class GBFRPanel {
    ; internal GUI
    g := 0

    v := { ; Value, for those data flows out only
        check: 1,
        back: 1,
        mission: 1,
        autokill: 0,
    }

    __New(game_name, on_change_name, on_close) {
        this.g := Gui("", "GBFR Auto")
        g := this.g

        g.SetFont("s10")
        g.OnEvent("Close", on_close)

        g.Add("Text", , "游戏窗口名：(一般不改 PS才用)")
        g.Add("Edit", , game_name).OnEvent("Change", on_change_name)
        g.Add("Text", "w200 vWINDOW_INFO")
        g.Add("Text", "w200 vTIMES_REPORT", "`n`r`n`r")

        v := this.v

        CB_NEED_MISSION(cb, info) {
            v.mission := cb.Value
        }
        g.Add("CheckBox", "vCB_NEED_MISSION Checked", "跳过任务结算").OnEvent("Click", CB_NEED_MISSION)

        CB_NEED_BACK(cb, info) {
            v.back := cb.Value
        }
        g.Add("CheckBox", "vCB_NEED_BACK Checked", "跳过奖励确认").OnEvent("Click", CB_NEED_BACK)

        CB_NEED_CHECK(cb, info) {
            v.check := cb.Value
        }
        g.Add("CheckBox", "vCB_NEED_CHECK Checked", "自动继续挑战").OnEvent("Click", CB_NEED_CHECK)

        CB_NEED_AUTOKILL(cb, info) {
            v.autokill := cb.Value
        }
        g.Add("CheckBox", "vCB_NEED_AUTOKILL", "自动连发平A（限史莱姆+拉卡姆）").OnEvent("Click", CB_NEED_AUTOKILL)
    }

    Show() {
        this.G.Show()
    }

    UpdateWindowInfo(w, h) {
        this.g.__Item["WINDOW_INFO"].Value := "游戏窗口大小：" w " x " h
    }

    UpdateTimesReport(mission, back, check) {
        this.g.__Item["TIMES_REPORT"].Value := (
            "跳过任务结算：" mission " 次`n"
            "跳过奖励确认：" back " 次`n"
            "自动继续挑战：" check " 次`n"
        )
    }
}