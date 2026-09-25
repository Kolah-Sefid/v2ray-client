$lockFile = "$PSScriptRoot\watchdog.lock"
$logFile = "$PSScriptRoot\watchdog.log"

# چک کن که watchdog دیگه‌ای اجرا نشده
if (Test-Path $lockFile) {
    $existingPid = Get-Content $lockFile
    $existingProc = Get-Process -Id $existingPid -ErrorAction SilentlyContinue
    if ($existingProc) {
        exit
    }
}

# قفل رو بساز
$PID | Out-File $lockFile
"=== Watchdog started at $(Get-Date) PID=$PID ===" | Out-File $logFile -Append

while ($true) {
    Start-Sleep -Seconds 1
    
    # فقط Xray رو چک کن
    $xrayProc = Get-Process -Name "xray" -ErrorAction SilentlyContinue
    if (-not $xrayProc) {
        "Xray died at $(Get-Date). Disabling proxy..." | Out-File $logFile -Append
        
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0
        & "$env:SystemRoot\System32\RUNDLL32.EXE" user32.dll,UpdatePerUserSystemParameters
        
        "Proxy disabled at $(Get-Date)" | Out-File $logFile -Append
        Remove-Item $lockFile -ErrorAction SilentlyContinue
        break
    }
}