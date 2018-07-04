@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title 		Lazy Recovery Auto Launcher
echo Waiting For device to be recognized by ADB
adb wait-for-device
adb shell getprop ro.build.version.emui > %~dp0\version-info.txt
for /f %%i in ('FINDSTR "EmotionUI_" %~dp0\version-info.txt') do set emui=%%i
echo %emui%
set str=%emui:~10,1%
echo.%str%
pause
if %str% equ 8 call HwOTA8\Replace_Recovery.bat
if %str% equ 5 call HWOTA7\Replace_Recovery.bat
echo THIS SCRIPT SHOULD BE FINISHED
pause
exit
