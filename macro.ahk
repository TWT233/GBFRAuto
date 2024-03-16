#Requires AutoHotkey v2.0

#Include utils.ahk
#Include components.ahk

GAP := 200
SLOW_GAP := 1000
GUARD := (len := 500) => (Sleep(len))

SellCharmAndLottery(*) {
    FilterToMain()
    i := 0
    while (P.sell.rounds == 0 || i < P.sell.rounds)
    {
        MainToSell()
        SellCharms()
        SellToLottery()
        LotteryToLV3(M)
        DoLottery(M)
        LotteryToMain()
        i++
    }
}

SellCharms() {
    loop 30 {
        EventClick("LButton", , , GAP)
        EventClick("s", , , GAP)
    }
    Sell()
    GUARD()
}

SellSigilsAndLottery(*) {
    FilterToMain()
    i := 0
    while (P.sell.rounds == 0 || i < P.sell.rounds)
    {
        MainToSell()
        SellSigils()
        SellToLottery()
        LotteryToLV3(M)
        DoLottery(M)
        LotteryToMain()
        i++
    }
}

SellSigils() {
    EventClick("Tab", , , GAP)
    Sell()
    GUARD()
}

FilterToMain() {
    EventClick("RButton", , , GAP)
    EventClick("RButton", , , GAP)
    GUARD()
}

MainToSell() {
    EventClick("LButton", , , GAP)
}

Sell() {
    EventClick("3", , , GAP)
    EventClick("w", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("s", , , GAP)
    EventClick("LButton", , , GAP)
    EventClick("LButton", , , GAP)
}

SellToLottery() {
    EventClick("RButton", , , SLOW_GAP)
    EventClick("RButton", , , GAP)
    GUARD(1000) ; slow main menu
    EventClick("s", , , GAP)
    EventClick("LButton", , , GAP)
    GUARD()
}

LotteryToLV3(M) {
    GuardLoop(() => (M.Match(CONS.LotteryLV3)),
    () => (EventClick("s", , , SLOW_GAP)), GUARD)
    GUARD()
}

DoLottery(M) {
    loop 1200 {
        EventClick("LButton", 20, , 20)
    }
    GUARD()
}

LotteryToMain() {
    while (!M.Match(CONS.SieroTop)) {
        EventClick("RButton", , , SLOW_GAP)
    }
    EventClick("w", , , GAP)
    EventClick("LButton", , , GAP)
    GUARD()
}