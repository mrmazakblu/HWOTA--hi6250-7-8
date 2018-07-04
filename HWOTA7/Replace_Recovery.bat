@echo off
title 		Recovery Replace Nougat
echo Waiting For device to be recognized by ADB
adb wait-for-device
adb shell getprop ro.build.version.emui > %~dp0\version-info.txt
for /f %%i in ('FINDSTR "EmotionUI_" %~dp0\version-info.txt') do set emui=%%i
echo %emui%
set str=%emui:~10%
echo.%str%
pause
if %str% gtr 5.2 (goto oreo
)else (
echo ok to continue)
echo Next will reboot to Fastboot Mode (bootloader)
pause
adb reboot bootloader
echo Wait Here untill fastboot mode Loads On Phone
pause
fastboot oem get-build-number 2> %~dp0\build-info.txt
for /f "tokens=2" %%i in ('findstr "^(bootloader)" "%~dp0\build-info.txt"') do set Device=%%i
for /f "tokens=3" %%i in ('findstr "^(bootloader)" "%~dp0\build-info.txt"') do set Build=%%i
echo Your Current Device is = %Device% %Build%
echo next will flash NOUGAT twrp 
pause
fastboot flash recovery HWOTA7\twrp-honor.img
echo RECOVERY SHOULD NOW BE FLASHED
echo GET READY TO PULL USB PLUG OUT AND HOLD VOLUME UP
echo RIGHT AFTER YOU PRESS BUTTON TO CONTINUE
pause
fastboot reboot
exit
:oreo
echo You are On OREO DO NOT USE THIS
pause
exit