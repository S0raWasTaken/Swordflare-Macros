#Requires AutoHotkey v2.0
#SingleInstance

; Veiled Singularity Macro
; By 0xS0ra (https://github.com/S0raWasTaken)
;
; Requirements:
; - Set your spawn point close to Crystal Shade.
; - Have at least 1800 HP.
; - Set your Void Slice hotkey to "r" or change the variable below.
; - Keep the game focused, Roblox can't deal with window events, only raw input.
; - Be on a server version 1340.
;
; Press F1 to start/stop the macro. It will automatically reset every hour to prevent desync.
;

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

toggle := false
skill_hotkey := "r"
pixel_colour := 0x757CEE

F1:: {
    global toggle
    toggle := !toggle
    if toggle {
        StartFarming()
        SetTimer(WatchPixel, 50)
        SetTimer(Suicide, 3600000) ; reset every hour
    } else {
        PauseFarming()
        SetTimer(WatchPixel, 0)
        SetTimer(Suicide, 0)
    }
}

; ─── Pixel Watcher ───────────────────────────────────────
WatchPixel() {
    global toggle
    if !toggle
        return

    x2 := A_ScreenWidth // 2
    y1 := A_ScreenHeight // 2

    if PixelSearch(&foundX, &foundY, 0, y1, x2, A_ScreenHeight, pixel_colour, 0) {
        PauseFarming()
        SetTimer(WatchPixel, 0)
        WalkToSingularity()
    }
}

PauseFarming() {
    Send("{a up}")
    SetTimer(MoveMouse, 0)
    SetTimer(SendClick, 0)
    SetTimer(VoidSlice, 0)
}

StartFarming() {
    Send("{a down}")
    SetTimer(MoveMouse, 9)
    SetTimer(SendClick, 200)
    SetTimer(VoidSlice, 10000)
}

; ─── Setup Macro ─────────────────────────────────────────
WalkToSingularity() {
    Suicide()

    Sleep(9000)

    HoldKey("w", 35000)
    HoldKey("d", 4000)
    HoldKey("s", 1300)
    HoldKey("a", 400)
    HoldKey("e", 1800)

    Send("q")
    Sleep(800)
    Send("q")

    SetTimer(WatchPixel, 50)
    StartFarming()
}

ClickHideHint() {
    Send("{Shift}")
    Sleep(100)
    Click(1800, 370)
    Sleep(100)
    Send("{Shift}")
}

Suicide() {
    Send("{Esc}")
    Sleep(100)
    Send("r")
    Sleep(100)
    Send("{Enter}")
}

HoldKey(key, delay) {
    Send("{" key " down}")
    Sleep(delay)
    Send("{" key " up}")
}

; ─── Farming Timers ──────────────────────────────────────
SendClick() {
    global toggle
    if toggle
        Click
}

VoidSlice() {
    global toggle
    if toggle
        Send(skill_hotkey)
}

MoveMouse() {
    global toggle
    if !toggle
        return
    RawMouseMove(15, 0)
}

RawMouseMove(x, y) {
    DllCall("mouse_event", "UInt", 0x0001, "Int", x, "Int", y, "UInt", 0, "UPtr", 0)
}