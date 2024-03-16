#Requires AutoHotkey v2.0

class PanelAutoKill {

    all := 0
    aaa := 0
    seya := 0
    guard := 0
    aim := 0
    forward := 0
    skills := 0
    r := 0
    g := 0
    chain := 0

    Attach(g, x, y) {
        g.Add("GroupBox", "Section w120 h220 x" x " y" y, "自动战斗相关")

        g.Add("CheckBox", "xs9 ys20", "总开关")
            .OnEvent("Click", (cb, *) => (this.all := cb.Value))

        g.Add("CheckBox", , "连发平A")
            .OnEvent("Click", (cb, *) => (this.aaa := cb.Value))

        g.Add("CheckBox", , "连发seya")
            .OnEvent("Click", (cb, *) => (this.seya := cb.Value))

        g.Add("CheckBox", , "按住格挡")
            .OnEvent("Click", (cb, *) => (this.guard := cb.Value))

        g.Add("CheckBox", , "按住索敌")
            .OnEvent("Click", (cb, *) => (this.aim := cb.Value))

        g.Add("CheckBox", , "按住前进")
            .OnEvent("Click", (cb, *) => (this.forward := cb.Value))

        g.Add("CheckBox", , "自动使用技能")
            .OnEvent("Click", (cb, *) => (this.skills := cb.Value))

        g.Add("CheckBox", , "自动连锁")
            .OnEvent("Click", (cb, *) => (this.r := cb.Value))

        g.Add("CheckBox", , "有奥义就开")
            .OnEvent("Click", (cb, *) => (this.g := cb.Value))

        g.Add("CheckBox", , "有奥义等接")
            .OnEvent("Click", (cb, *) => (this.chain := cb.Value))
    }
}