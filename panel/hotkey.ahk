#Requires AutoHotkey v2.0


class PanelHotkey {
    g := {
        reset: unset,
        exit: unset,
        sell: unset,
    }

    Attach(g, x, y) {
        g.Add("GroupBox", "Section w120 h120 x" x " y" y, "键位编辑")

        this.g.reset := g.Add("Hotkey", "xs9 ys25 w40")
        g.Add("Text", "xs55 ys30", "重置脚本")

        this.g.exit := g.Add("Hotkey", "xs9 ys55 w40")
        g.Add("Text", "xs55 ys60", "强退脚本")

        this.g.sell := g.Add("Hotkey", "xs9 ys85 w40")
        g.Add("Text", "xs55 ys90", "卖因子")

    }
}