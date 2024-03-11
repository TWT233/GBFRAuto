#Requires AutoHotkey v2.0


class PanelHotkey {
    reset := {
        g: unset,
        cb: unset,
        current: unset,
    }

    exit := {
        g: unset,
        cb: unset,
        current: unset,
    }

    sell_sigils := {
        g: unset,
        cb: unset,
        current: unset,
    }

    sell_charms := {
        g: unset,
        cb: unset,
        current: unset,
    }

    Attach(g, x, y) {
        g.Add("GroupBox", "Section w120 h150 x" x " y" y, "键位编辑")

        this.reset.g := g.Add("Hotkey", "xs9 ys25 w40")
        g.Add("Text", "xs55 ys30", "重置脚本")

        this.exit.g := g.Add("Hotkey", "xs9 ys55 w40")
        g.Add("Text", "xs55 ys60", "强退脚本")

        this.sell_sigils.g := g.Add("Hotkey", "xs9 ys85 w40")
        g.Add("Text", "xs55 ys90", "卖因子")

        this.sell_charms.g := g.Add("Hotkey", "xs9 ys115 w40")
        g.Add("Text", "xs55 ys120", "卖祝福")
    }

    BindReset(cb, initial) {
        this._RawBind(this.reset, cb, initial)
    }

    BindExit(cb, initial) {
        this._RawBind(this.exit, cb, initial)
    }

    BindSellSigils(cb, initial) {
        this._RawBind(this.sell_sigils, cb, initial)
    }

    BindSellCharms(cb, initial) {
        this._RawBind(this.sell_charms, cb, initial)
    }

    _RawBind(i, cb, initial) {
        i.cb := cb
        i.current := initial
        i.g.Value := initial
        Hotkey(i.current, i.cb)

        wrappedCB(ctrl, *) {
            try {
                Hotkey(ctrl.Value, i.cb)
            } catch Error {
                ctrl.Value := i.current
                return
            }
            Hotkey(i.current, "Off")
            i.current := ctrl.Value
        }

        i.g.OnEvent("Change", wrappedCB)
    }

}