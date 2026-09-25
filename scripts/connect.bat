@echo off
cd /d "%~dp0.."
title v2ray - Connecting

echo ========================================
echo    Connecting...
echo ========================================
echo.

:: تشخیص معماری ویندوز
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set "CORE_DIR=core-64"
    set "ARCH=64-bit"
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set "CORE_DIR=core-32"
    set "ARCH=32-bit"
) else (
    set "CORE_DIR=core-64"
    set "ARCH=Unknown (defaulting to 64-bit)"
)

echo    Architecture: %ARCH%
echo    Core folder:  %CORE_DIR%
echo.

if not exist "%CORE_DIR%\xray.exe" (
    echo [ERROR] %CORE_DIR%\xray.exe not found!
    pause
    exit /b
)

if not exist "config.txt" (
    echo [ERROR] config.txt not found!
    pause
    exit /b
)

echo [1/2] Building config.json from link...
powershell -ExecutionPolicy Bypass -File "config\make_config.ps1"
if %errorLevel% neq 0 (
    echo [ERROR] Failed to build config.json!
    pause
    exit /b
)

:: ==== پاک‌سازی قبلی ====
echo.
echo Cleaning previous instances...

powershell -Command "Get-Process -Name cmd -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*v2ray - Monitor*' } | Stop-Process -Force" >nul 2>&1
powershell -Command "Get-Process -Name powershell -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like '*watchdog*' } | Stop-Process -Force" >nul 2>&1
if exist "scripts\watchdog.lock" del "scripts\watchdog.lock"
taskkill /F /IM xray.exe >nul 2>&1
timeout /t 2 /nobreak >nul

:: ==== اتصال جدید ====
echo.
echo [2/2] Starting Xray...
start "" /B "%CORE_DIR%\xray.exe" run -c "config\config.json"
timeout /t 3 /nobreak >nul

start "" /B powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "scripts\watchdog.ps1"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:10809" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "localhost;127.*;10.*;172.16.*;192.168.*" /f >nul

RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters >nul 2>&1

echo.
echo ========================================
echo    Connected successfully!
echo ========================================
echo.
echo    Keep this window open while using the internet.
echo    Closing this window will disconnect.
echo.
echo    Press any key to DISCONNECT and close...
echo.

start "v2ray - Monitor" cmd /k "scripts\monitor.bat"

pause >nul

echo.
echo Disconnecting...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
taskkill /F /IM xray.exe >nul 2>&1
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters >nul 2>&1
echo Disconnected.
timeout /t 1 >nul
exit