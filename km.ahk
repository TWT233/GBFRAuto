#Requires AutoHotkey v2.0

#Include utils.ahk
#Include components.ahk

GAP := 200
SLOW_GAP := 1000
GUARD := (len := 500) => (Sleep(len))

AutoSellAndLottery(*) {
    FilterToMain()
    i := 0
    while (NG.sell.rounds == 0 || i < NG.sell.rounds)
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

FilterToMain() {
    GUARD()
    EventClick("RButton", , , GAP)
    EventClick("RButton", , , GAP)
    GUARD()
}

MainToSigil(M) {
    GUARD()
    GuardLoop(() => (M.Match(CONS.TicketWithSigil)),
    () => (EventClick("s", , , SLOW_GAP)), GUARD)
    GUARD()
}

SellSigils() {
    GUARD()
    EventClick("LButton", , , GAP)
    EventClick("Tab", , , GAP)
    ret := M.Match(CONS.NoAvailableSigil)
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
    GuardLoop(() => (M.Match(CONS.LotteryLV3)),
    () => (EventClick("s", , , SLOW_GAP)), GUARD)
    GUARD()
}

DoLottery(M) {
    GUARD()

    loop 1200 {
        EventClick("LButton", 20, , 20)
    }
    GUARD()

    while (!M.Match(CONS.LotteryLV3)) {
        EventClick("RButton", , , SLOW_GAP)
    }

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