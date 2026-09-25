@echo off
cd /d "%~dp0"
title Xray Setup

echo ========================================
echo    Initial Setup - Run Once
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run as Administrator.
    timeout /t 3 >nul
    exit
)

echo [1/3] Checking Windows Defender exclusions...
powershell -Command "$existing = (Get-MpPreference).ExclusionPath; if ($existing -notcontains '%~dp0') { Add-MpPreference -ExclusionPath '%~dp0'; Write-Host '  Folder added.' } else { Write-Host '  Folder already excluded.' }"

echo [2/3] Checking xray.exe whitelist...
powershell -Command "$existing = (Get-MpPreference).ExclusionProcess; if ($existing -notcontains 'xray.exe') { Add-MpPreference -ExclusionProcess 'xray.exe'; Write-Host '  xray.exe added.' } else { Write-Host '  xray.exe already whitelisted.' }"

echo [3/3] Creating desktop shortcuts...

:: Connect shortcut (green network icon)
powershell -Command "$ws = New-Object -ComObject WScript.Shell; $sc = $ws.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Connect v2ray.lnk'); $sc.TargetPath = '%~dp0scripts\connect.bat'; $sc.WorkingDirectory = '%~dp0'; $sc.IconLocation = '%SystemRoot%\System32\shell32.dll,17'; $sc.Save()" >nul 2>&1

:: Disconnect shortcut (red lock icon)
powershell -Command "$ws = New-Object -ComObject WScript.Shell; $sc = $ws.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Disconnect v2ray.lnk'); $sc.TargetPath = '%~dp0scripts\disconnect.bat'; $sc.WorkingDirectory = '%~dp0'; $sc.IconLocation = '%SystemRoot%\System32\shell32.dll,131'; $sc.Save()" >nul 2>&1

echo.
echo ========================================
echo    Setup completed successfully!
echo ========================================
echo.
echo    Two shortcuts have been created on your Desktop:
echo      - Connect v2ray (green icon)
echo      - Disconnect v2ray (red icon)
echo.

timeout /t 3 >nul
exit