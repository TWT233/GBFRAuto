#Requires AutoHotkey v2.0

class PanelSkip {

    mission := 1
    back := 1
    check := 1

    Attach(g, x, y) {
        g.Add("GroupBox", "Section w120 h85 x" x " y" y, "跳过结算相关")

        g.Add("CheckBox", "Checked xs9 ys20", "跳过任务结算")
            .OnEvent("Click", (cb, *) => (this.mission := cb.Value))

        g.Add("CheckBox", "Checked", "跳过奖励确认")
            .OnEvent("Click", (cb, *) => (this.back := cb.Value))

        g.Add("CheckBox", "Checked", "自动继续挑战")
            .OnEvent("Click", (cb, *) => (this.check := cb.Value))
    }
}