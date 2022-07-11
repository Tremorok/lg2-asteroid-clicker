#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 4

started := False
scrWorkType := ""

defAsteroids := ["bigRock0.png","bigRock1.png","bigRock2.png","smallRock0.png","smallRock1.png","smallRock2.png"]
imgsList := [] ;array with all imgs from folder
imgsListWithNoDefRocks := [] ;array with only special asteroids
Loop, %A_ScriptDir%\imgs\*.png, , 0
{
    imgsList.Push(A_LoopFileName)
	if A_LoopFileName not contains bigRock,smallRock
		imgsListWithNoDefRocks.Push(A_LoopFileName)
}

searchImg(arr) {
	Loop % arr.MaxIndex()
	{
		img := arr[A_index]
		ImageSearch,imgFMPosX,imgFMPosY,140,242,1800,440, %A_ScriptDir%\imgs\%img%
		if (ErrorLevel = 0) {
			MouseMove, %imgFMPosX%, %imgFMPosY%, 0
			Loop, 5 {
				Click
				sleep, 20
			}
		}
	}
}

checkActive(started) {	
	if (!started) {
		ToolTip, Script disabled!, 100, 100, 1
		sleep, 4000
		ToolTip
		return "stop1"
	} else if (!WinActive("ahk_exe LazyGalaxy2.exe")) {
		ToolTip
		started := False
		MsgBox, You removed the mouse from the game window, script stoped!
		return "stop2"
	} else {
		return "run"
	}
}

return

#IfWinActive ahk_exe LazyGalaxy2.exe

F1:: ;search all asteroids
#MaxThreadsPerHotkey 4
if (started && scrWorkType == "F1") {
	started := False
	scrWorkType := ""
	return
} else if (scrWorkType != "F1" && scrWorkType != "") {
	MsgBox, You tryed to start 2 scripts in one time, stop another before start new.
	return
}
started := True
scrWorkType := "F1"
ToolTip, Script F1 runned!, 100, 100, 1
Loop, {
	if (checkActive(started) == "run") {
		if (Mod(A_index,20) == 0) {
			searchImg(imgsListWithNoDefRocks)
		} else {
			searchImg(defAsteroids)
		}
	} else {
		Break
	}
}
return

F2:: ;search only special asteroids
#MaxThreadsPerHotkey 4
if (started && scrWorkType == "F2") {
	started := False
	scrWorkType := ""
	return
} else if (scrWorkType != "F2" && scrWorkType != "") {
	MsgBox, You tryed to start 2 scripts in one time, stop another before start new.
	return
}
started := True
scrWorkType := "F2"
ToolTip, Script F2 runned!, 100, 100, 1
Loop, {
	if (checkActive(started) == "run") {
		if (Mod(A_index,20) == 0) {
			searchImg(imgsListWithNoDefRocks)
		} else {
			Loop, 20 {
				send, w
				sleep, 10
			}
		}
	} else {
		Break
	}
}
return

#IfWinNotActive
F1::
MsgBox, You tried start script, not in the game!
return
F2::
MsgBox, You tried start script, not in the game!
return