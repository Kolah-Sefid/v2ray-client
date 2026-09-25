@echo off
cd /d "%~dp0.."
title v2ray - Disconnect

echo ========================================
echo    Disconnecting...
echo ========================================
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters >nul 2>&1

taskkill /F /IM xray.exe >nul 2>&1

powershell -Command "Get-Process -Name cmd -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*v2ray - Monitor*' -or $_.MainWindowTitle -like '*v2ray - Connecting*' } | Stop-Process -Force" >nul 2>&1

powershell -Command "Get-Process -Name powershell -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like '*watchdog*' } | Stop-Process -Force" >nul 2>&1

if exist "scripts\watchdog.lock" del "scripts\watchdog.lock"

echo.
echo ========================================
echo    Disconnected successfully!
echo ========================================
echo.
echo    All windows have been closed.
echo.

timeout /t 1 >nul
exit