@echo off
title Preparing...
color 06
Mode 130,45
setlocal EnableDelayedExpansion

::Ordner erstellen
mkdir C:\Sweaty >nul 2>&1
mkdir C:\Sweaty\Resources >nul 2>&1
mkdir C:\Sweaty\Launcher >nul 2>&1
mkdir C:\Sweaty\Drivers >nul 2>&1
cd C:\Sweaty

::Als Admin
::Reg.exe add HKLM /F >nul 2>&1
::if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

::Show Detailed BSoD 
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

::Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

::Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: legendary launcher
if exist "C:\Sweaty\Launcher\legendary.exe" goto CheckForUpdates
curl -g -L -# -o "C:\Sweaty\Launcher\legendary-update.ps1" "https://raw.githubusercontent.com/Quicki/SweatyLauncher/main/Data/legendary-update.ps1" >nul 2>&1
powershell "C:\Sweaty\Launcher\legendary-update.ps1"

:: Update Check
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
echo                                           %COL%[33m[%COL%[37m 1 %COL%[33m]%COL%[37m Fortnite Starten        %COL%[33m[%COL%[37m 2 %COL%[33m]%COL%[37m Fortnite Settings
echo.
echo.						%COL%[33m[%COL%[37m 3 %COL%[33m]%COL%[37m Fortnite Updaten
echo.																
echo.
echo.
echo.
echo.                                                     %COL%[33m[%COL%[37m 4 %COL%[33m]%COL%[37m Launcher Update      %COL%[33m[%COL%[37m 5 %COL%[33m]%COL%[37m Launcher Settings
echo.
echo.
echo.
echo.                                                           %COL%[31m[ X to close ]%COL%[37m  
echo.
choice /c:1234567X /n /m "%DEL%                                                               option > "
set choice=%errorlevel%
if "%choice%"=="1" call:FortniteStarten
if "%choice%"=="2" call:FortniteS
if "%choice%"=="3" call:FortniteUpdate
if "%choice%"=="4" call:LegendaryUpdate
if "%choice%"=="5" call:Comingsoon
if "%choice%"=="6" call:Comingsoon
if "%choice%"=="X" call:exit
if "%choice%"=="8" call:exit
goto MainMenu


:: Fortnite Legendary start&update
:FortniteStarten
cd C:\Sweaty\Launcher\
legendary.exe update Fornite
legendary.exe launch Fortnite
cls
goto MainMenu

:FortniteUpdate
cd C:\Sweaty\Launcher\
legendary.exe update Fortnite
pause
cls
goto MainMenu
:: Legendary Auth
:EpicLogin
cd C:\Sweaty\Launcher\
legendary.exe auth
cls
goto FortniteS

:FortniteInstall
cd C:\Sweaty\Launcher\
legendary.exe install Fortnite
cls
goto FortniteS

:FortniteVerify
cd C:\Sweaty\Launcher\
legendary.exe verify Fortnite
cls
goto FortniteS

:FortniteRepair
cd C:\Sweaty\Launcher\
legendary.exe repair Fortnite
cls
goto FortniteS

:LegendaryUpdate
powershell "C:\Sweaty\Launcher\legendary-update.ps1"
goto MainMenu

:ForniteConfigReset
rmdir /s /q "C:\Users\%username%\AppData\Local\FortniteGame"
pause
goto FortniteS


:Cleaner
cls
rmdir /S /Q "C:\Sweaty\Resources\DeviceCleanupCmd\"
del /F /Q "C:\Sweaty\Resources\AdwCleaner.exe"
del /F /Q "C:\Sweaty\Resources\EmptyStandbyList.exe"
curl -g -L -# -o "C:\Sweaty\Resources\EmptyStandbyList.exe" "https://wj32.org/wp/download/1455/"
curl -g -L -# -o "C:\Sweaty\Resources\DeviceCleanupCmd.zip" "https://www.uwe-sieber.de/files/DeviceCleanupCmd.zip"
curl -g -L -# -o "C:\Sweaty\Resources\AdwCleaner.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"
powershell -NoProfile Expand-Archive 'C:\Sweaty\Resources\DeviceCleanupCmd.zip' -DestinationPath 'C:\Sweaty\Resources\DeviceCleanupCmd\'
del /F /Q "C:\Sweaty\Resources\DeviceCleanupCmd.zip"
del /Q C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
del /Q C:\Windows\Downloaded Program Files\*.*
rd /s /q %SYSTEMDRIVE%\$Recycle.bin
del /Q C:\Users\%username%\AppData\Local\Temp\*.*
del /Q C:\Windows\Temp\*.*
del /Q C:\Windows\Prefetch\*.*
cd C:\Sweaty\Resources
AdwCleaner.exe /eula /clean /noreboot
for %%g in (workingsets modifiedpagelist standbylist priority0standbylist) do EmptyStandbyList.exe %%g
cd "C:\Sweaty\Resources\DeviceCleanupCmd\x64"
DeviceCleanupCmd.exe *
goto MainMenu



:CheckForUpdates
set local=1.05
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
	echo               		      Deine Version: %localtwo%
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
goto MainMenu


:FortniteS
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
echo                                           %COL%[33m[%COL%[37m 1 %COL%[33m]%COL%[37m Epic Login       %COL%[33m[%COL%[37m 2 %COL%[33m]%COL%[37m Fortnite reparieren
echo.
echo.
echo.					%COL%[33m[%COL%[37m 3 %COL%[33m]%COL%[37m Fortnite config reset
echo.
echo.
echo.
echo.                                                     %COL%[33m[%COL%[37m 4 %COL%[33m]%COL%[37m Fortnite installieren     %COL%[33m[%COL%[37m 5 %COL%[33m]%COL%[37m Fortnite verify
echo.
echo.
echo.
echo.                                                           %COL%[31m[ X to close ]%COL%[37m  
echo.
choice /c:1234567X /n /m "%DEL%                                                               option > "
set choice=%errorlevel%
if "%choice%"=="1" call:EpicLogin
if "%choice%"=="2" call:FortniteRepair
if "%choice%"=="3" call:ForniteConfigReset
if "%choice%"=="4" call:FortniteInstall
if "%choice%"=="5" call:FortniteVerify
goto MainMenu



:exit
cls 
exit