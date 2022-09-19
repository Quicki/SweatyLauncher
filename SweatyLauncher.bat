@echo off
title Preparing...
color 06
Mode 130,45
setlocal EnableDelayedExpansion

::Make Directories
mkdir C:\Sweaty >nul 2>&1
mkdir C:\Sweaty\Resources >nul 2>&1
mkdir C:\Sweaty\Launcher >nul 2>&1
mkdir C:\Sweaty\Drivers >nul 2>&1
cd C:\Sweaty

::Run as Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

::Show Detailed BSoD 
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

::Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

::Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

goto CheckForUpdates 
:MainMenu
Mode 130,45
TITLE Sweaty Launcher %localtwo%
set "choice="
cls
echo.	
echo.		      ::::::::     :::       :::       ::::::::::           :::    :::::::::::    :::   ::: 
echo.		    :+:    :+:    :+:       :+:       :+:                :+: :+:      :+:        :+:   :+:  
echo.		   +:+           +:+       +:+       +:+               +:+   +:+     +:+         +:+ +:+    
echo.		  +#++:++#++    +#+  +:+  +#+       +#++:++#         +#++:++#++:    +#+          +#++:      
echo.		        +#+    +#+ +#+#+ +#+       +#+              +#+     +#+    +#+           +#+        
echo.		#+#    #+#     #+#+# #+#+#        #+#              #+#     #+#    #+#           #+#         
echo.		########       ###   ###         ##########       ###     ###    ###           ###                                                                                                     
echo.		
echo. 
echo.
echo.
echo.
echo.
echo.
echo                                           %COL%[33m[%COL%[37m 1 %COL%[33m]%COL%[37m Fortnite Starten        %COL%[33m[%COL%[37m 2 %COL%[33m]%COL%[37m Game Settings
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                                     %COL%[33m[%COL%[37m 3 %COL%[33m]%COL%[37m Launcher Update      %COL%[33m[%COL%[37m 4 %COL%[33m]%COL%[37m Game Settings
echo.
echo.
echo.
echo.                                                           %COL%[31m[ X to close ]%COL%[37m  
echo.
choice /c:1234567X /n /m "%DEL%                                                               option > "
set choice=%errorlevel%
if "%choice%"=="1" call:Comingsoon
if "%choice%"=="2" call:Comingsoon
if "%choice%"=="3" call:Comingsoon
if "%choice%"=="4" call:LegendaryUpdate
if "%choice%"=="5" call:Comingsoon
if "%choice%"=="6" call:Comingsoon
if "%choice%"=="7" call:Comingsoon
if "%choice%"=="8" call:Comingsoon
if "%choice%"=="9" call:Comingsoon
goto MainMenu

:LegendaryUpdate
powershell
cd C:\Sweaty\Resources


goto MainMenu

:CheckForUpdates
set local=1
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/Quicki/SweatyLauncher/main/Data/version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
	cls
	Mode 65,16
	echo.
	echo  --------------------------------------------------------------
	echo                          	 Update
	echo  --------------------------------------------------------------
	echo.
	echo                   Deine Version: %localtwo%
	echo.
	echo                          Neue Version: %local%
	echo.
	echo.
	echo.
	echo      [J] Ja, Update
	echo      [N] Nein
	echo.
	choice /c:JN /n /m "%DEL%                                >:"
	set choice=!errorlevel!
	if !choice! equ 1 (
		curl -L -o %0 "https://github.com/Quicki/SweatyLauncher/releases/latest/download/SweatyLauncher.bat" >nul 2>&1
		call %0
		exit /b
	)
	Mode 130,45
)