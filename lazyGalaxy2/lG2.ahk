#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 4

started := False
imgsList := ["bigRock0","bigRock1","bigRock2","smallRock0","smallRock1","smallRock2","redRock0","redRock1","redRock2","upgradeRock0","upgradeRock1","upgradeRock2","ironRock0","ironRock1","ironRock2","greenRock0","greenRock1","greenRock2","green2Rock0","green2Rock0","green2Rock0","red2Rock0","red2Rock1","red2Rock2"]
return

#IfWinActive ahk_exe LazyGalaxy2.exe
F1::
#MaxThreadsPerHotkey 4
if (started) {
	started := False
	return
}
started := True
ToolTip, Script runned!, 100, 100, 1
Loop, {
	if (!started) {
		ToolTip, Script disabled!, 100, 100, 1
		sleep, 4000
		ToolTip
		return
	} else if (!WinActive("ahk_exe LazyGalaxy2.exe")) {
		ToolTip
		started := False
		MsgBox, You removed the mouse from the game window, script stoped!
		return
	}
	Loop % imgsList.MaxIndex()
	{
		img := imgsList[A_index]
		ImageSearch,imgFMPosX,imgFMPosY,140,242,1800,440, %A_ScriptDir%\imgs\%img%.png ;
		if (ErrorLevel = 0) {
			MouseMove, %imgFMPosX%, %imgFMPosY%, 0
			sleep, 20
			Click
			Click
			Click
			Click
		}
	}
}
return

#IfWinNotActive
F1::
MsgBox, You tried start script, not in the game!