#Requires AutoHotkey v2.0
#SingleInstance

; Forest Shade Macro
; By 0xS0ra (https://github.com/S0raWasTaken)
;
; Requirements:
; - Set your spawn point at Forest Shade
; - Have enough HP to not just die instantly to forest shade (1000-1300 should be enough ig)
; - Do not use shiftlock
; - Set your Void Slice hotkey to "r" or change the variable below.
;
; Press F1 to start/stop the macro. It will automatically reset every hour to prevent desync.
;

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

toggle := false
skill_hotkey := "r"

F1:: {
    global toggle
    toggle := !toggle
    if toggle {
        SetTimer(Setup, -100)
    }
    else {
        ReleaseMovementKeys()
        SetTimer(DoWalkCycle, 0)
        SetTimer(HourlyReset, 0)
        SetTimer(Click, 0)
    }
}

Setup() {
    Suicide()
    Sleep(5000)

    if !HoldKey("s", 500)
        return
    if !HoldKey("a", 12900)
        return
    if !HoldKey("s", 5000)
        return

    SetTimer(HourlyReset, 3600000)
    SetTimer(Click, 200)
    SetTimer(DoWalkCycle, -100)
}

HourlyReset() {
    global toggle
    if !toggle
        return
    SetTimer(DoWalkCycle, 0)
    ReleaseMovementKeys()
    Suicide()
    SetTimer(Setup, -100)
}

Suicide() {
    Send("{Esc}")
    Sleep(500)
    Send("r")
    Sleep(500)
    Send("{Enter}")
}

HoldKey(key, ms) {
    global toggle
    local elapsed := 0
    local interval := 50
    Send("{" key " down}")
    while (elapsed < ms) {
        if !toggle {
            Send("{" key " up}")
            return false
        }
        Sleep(interval)
        elapsed += interval
    }
    Send("{" key " up}")
    return true
}

PauseCheck(ms) {
    global toggle
    local elapsed := 0
    local interval := 50
    while (elapsed < ms) {
        if !toggle
            return false
        Sleep(interval)
        elapsed += interval
    }
    return true
}

DoWalkCycle() {
    global toggle
    if !toggle
        return

    if !HoldKey("w", 8000)
        return
    Send(skill_hotkey)
    if !HoldKey("s", 1000)
        return
    if !PauseCheck(10000)
        return
    if !HoldKey("w", 1000)
        return

    if !HoldKey("d", 6000)
        return
    Send(skill_hotkey)
    if !HoldKey("a", 1000)
        return
    if !PauseCheck(10000)
        return
    if !HoldKey("d", 1000)
        return

    if !HoldKey("s", 8000)
        return
    Send(skill_hotkey)
    if !HoldKey("w", 1000)
        return
    if !PauseCheck(10000)
        return
    if !HoldKey("s", 1000)
        return

    if !HoldKey("a", 6000)
        return
    Send(skill_hotkey)
    if !HoldKey("d", 1000)
        return
    if !PauseCheck(10000)
        return
    if !HoldKey("a", 1000)
        return

    SetTimer(DoWalkCycle, -100)
}

ReleaseMovementKeys() {
    Send("{w up}{a up}{s up}{d up}")
}
