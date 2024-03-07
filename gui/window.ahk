#Requires AutoHotkey v2.0

class PanelWindow {
    g := {
        e_game_name: unset,
        window_info: unset,
    }

    Attach(g, x, y, game_name) {
        g.Add("GroupBox", "Section w250 h75 x" x " y" y, "游戏窗口设置")
        g.Add("Text", "xs9 ys25", "窗口名：")

        this.g.e_game_name := g.Add("Edit", "w180 xs60 ys20", game_name)

        this.g.window_info := g.Add("Text", "xs9 ys50", "游戏窗口大小：             ")
    }

    OnChange(cb) {
        this.g.e_game_name.OnEvent("Change", cb)
    }

    UpdateWindowInfo(w, h) {
        this.g.window_info.Value := "游戏窗口大小：" w " x " h
    }
}