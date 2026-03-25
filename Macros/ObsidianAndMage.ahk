#Requires AutoHotkey v2.0
#SingleInstance

; Obsidian Guardian & Flame Battlemage Macro
; By 0xS0ra (https://github.com/S0raWasTaken)
;
; Requirements:
; - Have void slice
; - Set your spawn point at the Obsidian Guardian's entrance
; - Have enough HP to tank Flame Battlemage easily
; - Do not use shiftlock
; - Set your Void Slice hotkey to "r" or change the variable below.
; - Make sure you do enough damage to insta-kill Obsidian Guardian with Void Slice
; - Set the variable `mage_void_spam_count` to how many void slice casts it takes to kill Flame Battlemage
;
; Press F1 to start/stop the macro.
;

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

toggle := false ; DO NOT CHANGE

skill_hotkey := "r" ; Possible values: ["e", "r", "f", "t"] as per Swordflare version 1340
mage_void_spam_count := 1 ; Value must be higher than 0

F1:: {
    global toggle := !toggle

    if toggle {
        SetTimer(Main, -100)
    } else {
        ReleaseMovementKeys()
    }
}

Main() {
    Suicide(6000)
    if !HoldKey("a", 1000)
        return
    if !HoldKeys(["w", "Space"], 9000)
        return
    if !HoldKey("a", 30)
        return
    Send(skill_hotkey)
    if !AsyncSleep(1000)
        return

    if !HoldKey("w", 1000)
        return

    if !HoldKeys(["w", "d"], 35000)
        return

    if !HoldKey("d", 2000)
        return

    if !AsyncSleep(14000)
        return

    while A_Index <= mage_void_spam_count {
        Send(skill_hotkey)
        AsyncSleep(1000)
        if A_Index < mage_void_spam_count
            AsyncSleep(7000)
    }
    SetTimer(Main, -100)
}

ReleaseMovementKeys() {
    Send("{w up}{a up}{s up}{d up}{Space up}")
}

; ─── Utility functions ────────────────────────────────────────
Suicide(sleep_time) {
    Send("{Esc}")
    Sleep(100)
    Send("r")
    Sleep(100)
    Send("{Enter}")
    Sleep(sleep_time)
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

HoldKeys(keys, ms) {
    local elapsed := 0
    local interval := 50

    for key in keys {
        Send("{" . key . " down}")
    }

    while (elapsed < ms) {
        if !toggle {
            for key in keys {
                Send("{" . key . " up}")
            }
            return false
        }
        Sleep(interval)
        elapsed += interval
    }

    for key in keys {
        Send("{" . key . " up}")
    }
    return true
}

AsyncSleep(ms) {
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