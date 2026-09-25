@echo off
cd /d "%~dp0.."
title v2ray - Monitor
color 0A
set LINE_COUNT=0

echo ========================================
echo    v2ray Connection Monitor
echo ========================================
echo.
echo    ************************************
echo    *                                  *
echo    *      Powered by Kolah Sefid      *
echo    *                                  *
echo    *      Site: kolah-sefid.ir       *
echo    *                                  *
echo    ************************************
echo.
echo ========================================
echo.

:loop
for /f "tokens=1-2 delims=." %%a in ("%TIME%") do set NOW=%%a

tasklist /FI "IMAGENAME eq xray.exe" 2>nul | find /I "xray.exe" >nul
if %errorLevel% equ 0 (
    set XRAY_STATUS=RUNNING
) else (
    set XRAY_STATUS=NOT RUNNING
)

for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do set PROXY=%%a
if "%PROXY%"=="0x1" (
    set PROXY_STATUS=ENABLED
) else (
    set PROXY_STATUS=DISABLED
)

curl -s -x http://127.0.0.1:10809 -m 5 https://api.ipify.org > "%TEMP%\ip.txt" 2>nul
if %errorLevel% equ 0 (
    set /p IP=<"%TEMP%\ip.txt"
    set NET_STATUS=CONNECTED
) else (
    set IP=---
    set NET_STATUS=NOT CONNECTED
)

echo [%NOW%] Xray: %XRAY_STATUS% ^| Proxy: %PROXY_STATUS% ^| Net: %NET_STATUS% ^| IP: %IP%

if "%XRAY_STATUS%"=="NOT RUNNING" (
    echo.
    echo [ACTION] Xray died! Disabling proxy...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
    RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters >nul 2>&1
    echo [ACTION] Proxy disabled.
    echo.
)

set /a LINE_COUNT+=1
if %LINE_COUNT% geq 50 (
    cls
    echo ========================================
    echo    v2ray Connection Monitor
    echo ========================================
    echo.
    echo    ************************************
    echo    *                                  *
    echo    *      Powered by Hamid Shool      *
    echo    *                                  *
    echo    *      Telegram: @HamidShool       *
    echo    *                                  *
    echo    ************************************
    echo.
    echo ========================================
    echo.
    set LINE_COUNT=0
)

timeout /t 2 /nobreak >nul
goto loop
