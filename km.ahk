#Requires AutoHotkey v2.0

#Include const.ahk
#Include utils.ahk
#Include matcher.ahk
#Include panel.ahk

; always an emergency exit
[:: OnClose

; auto selling
]:: AutoSellAndLottery(M, G)(0)

GAP := 200
SLOW_GAP := 1000
GUARD := (len := 500) => (Sleep(len))


OnClose(_ := 0) {
    EventClick("LButton")
    EventClick("RButton")
    EventClick("MButton")
    EventClick("w")
    ExitApp
}

AutoSellAndLottery(M, G) {
    dec(hot_key_name) {
        FilterToMain()
        i := 0
        while (G.v.sell_rounds == 0 || i < G.v.sell_rounds)
        {
            MainToSigil(M)
            ret := SellSigils()
            if ret == 1 {
                return
            }
            SellToMain()
            MainToLottery()
            LotteryToLV3(M)
            DoLottery(M)
            LotteryToMain()
            i++
        }
    }
    return dec
}

FilterToMain() {
    GUARD()
    EventClick("RButton", , , GAP)
    EventClick("RButton", , , GAP)
    GUARD()
}

MainToSigil(M) {
    GUARD()
    GuardLoop(() => (M.Search(PATH.TicketWithSigil)),
    () => (EventClick("s", , , SLOW_GAP)), GUARD)
    GUARD()
}

SellSigils() {
    GUARD()
    EventClick("LButton", , , GAP)
    EventClick("Tab", , , GAP)
    ret := M.Search(PATH.NoAvailableSigil, 32)
    if ret == 1 {
        return 1
    }
    EventClick("3", , , GAP)
    EventClick("w", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("s", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("LButton", , , GAP)
    GUARD()
    return 0
}

SellToMain() {
    GUARD()
    EventClick("RButton", , , GAP)
    GUARD()
}

MainToLottery() {
    GUARD()
    EventClick("RButton", , , GAP)
    GUARD(1000) ; slow main menu
    EventClick("s", , , GAP)
    EventClick("LButton", , , GAP)
    GUARD()
}

LotteryToLV3(M) {
    GUARD()
    GuardLoop(() => (M.Search(PATH.LotteryLV3)),
    () => (EventClick("s", , , SLOW_GAP)), GUARD)
    GUARD()
}

DoLottery(M) {
    GUARD()

    loop 400 {
        EventClick("LButton", 20, , 20)
    }
    GUARD()

    GuardLoop(() => (M.Search(PATH.LotteryLV3)),
    () => (EventClick("RButton", , , SLOW_GAP)), GUARD)

    GUARD()
}

LotteryToMain() {
    GUARD()
    EventClick("RButton", , , GAP)
    GUARD(1000) ; slow main menu
    EventClick("w", , , GAP)
    EventClick("LButton", , , GAP)
    GUARD()
}