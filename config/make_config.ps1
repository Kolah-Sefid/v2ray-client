# make_config.ps1 - Convert vless:// to config.json
# Supports: tcp, ws, grpc, http, reality, tls
# Version: 2.0

param(
    [string]$InputFile  = "$PSScriptRoot\..\config.txt",
    [string]$OutputFile = "$PSScriptRoot\config.json"
)

# --- بررسی وجود فایل ورودی ---
if (-not (Test-Path $InputFile)) {
    Write-Host "[ERROR] config.txt not found!" -ForegroundColor Red
    exit 1
}

# --- خواندن همه‌ی خطوط و پیدا کردن لینک‌های vless ---
$allLines = Get-Content $InputFile
$vlessLinks = @()

foreach ($line in $allLines) {
    $trimmed = $line.Trim()
    if ($trimmed.StartsWith("vless://")) {
        $vlessLinks += $trimmed
    }
}

if ($vlessLinks.Count -eq 0) {
    Write-Host "[ERROR] No valid vless:// link found in config.txt!" -ForegroundColor Red
    exit 1
}

if ($vlessLinks.Count -gt 1) {
    Write-Host "[WARNING] Multiple links found ($($vlessLinks.Count)). Using the first one." -ForegroundColor Yellow
    Write-Host "          Please keep only one link in config.txt" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Using link #1..." -ForegroundColor Cyan

# --- انتخاب اولین لینک ---
$link = $vlessLinks[0]

# --- حذف بخش fragment (#...) ---
$withoutScheme = $link.Substring(8)
$hashIndex = $withoutScheme.IndexOf('#')
if ($hashIndex -ge 0) {
    $withoutScheme = $withoutScheme.Substring(0, $hashIndex)
}

# --- جدا کردن UUID از host:port ---
$atIndex = $withoutScheme.IndexOf('@')
$uuid = $withoutScheme.Substring(0, $atIndex)
$rest = $withoutScheme.Substring($atIndex + 1)

# --- جدا کردن host:port از query string ---
$questionIndex = $rest.IndexOf('?')
if ($questionIndex -ge 0) {
    $hostPort = $rest.Substring(0, $questionIndex)
    $queryString = $rest.Substring($questionIndex + 1)
} else {
    $hostPort = $rest
    $queryString = ""
}

# --- پارس host و port ---
$hostPortParts = $hostPort.Split(':')
$address = $hostPortParts[0]
$port = [int]$hostPortParts[1]

# --- پارس query string ---
$params = @{}
foreach ($pair in $queryString.Split('&')) {
    $kv = $pair.Split('=', 2)
    if ($kv.Length -eq 2) {
        $params[$kv[0]] = [System.Uri]::UnescapeDataString($kv[1])
    }
}

# --- استخراج پارامترها ---
$encryption = if ($params['encryption']) { $params['encryption'] } else { "none" }
$security   = if ($params['security'])   { $params['security'] }   else { "none" }
$type       = if ($params['type'])       { $params['type'] }       else { "tcp" }
$headerType = if ($params['headerType']) { $params['headerType'] } else { "none" }
$path       = if ($params['path'])       { $params['path'] }       else { "/" }
$hostHeader = if ($params['host'])       { $params['host'] }       else { $address }
$flow       = if ($params['flow'])       { $params['flow'] }       else { "" }
$sni        = if ($params['sni'])        { $params['sni'] }        else { "" }
$fp         = if ($params['fp'])         { $params['fp'] }         else { "" }
$pbk        = if ($params['pbk'])        { $params['pbk'] }        else { "" }
$sid        = if ($params['sid'])        { $params['sid'] }        else { "" }
$spx        = if ($params['spx'])        { $params['spx'] }        else { "" }
$serviceName = if ($params['serviceName']) { $params['serviceName'] } else { "" }
$alpn       = if ($params['alpn'])       { $params['alpn'] }       else { "" }

# --- نمایش اطلاعات ---
Write-Host "  Address: $address" -ForegroundColor Gray
Write-Host "  Port: $port" -ForegroundColor Gray
Write-Host "  UUID: $uuid" -ForegroundColor Gray
Write-Host "  Encryption: $encryption" -ForegroundColor Gray
Write-Host "  Security: $security" -ForegroundColor Gray
Write-Host "  Type: $type" -ForegroundColor Gray
if ($headerType -ne "none") { Write-Host "  Header: $headerType" -ForegroundColor Gray }
if ($sni)        { Write-Host "  SNI: $sni" -ForegroundColor Gray }
if ($fp)         { Write-Host "  Fingerprint: $fp" -ForegroundColor Gray }
if ($pbk)        { Write-Host "  PublicKey: $pbk" -ForegroundColor Gray }
if ($sid)        { Write-Host "  ShortId: $sid" -ForegroundColor Gray }
if ($alpn)       { Write-Host "  ALPN: $alpn" -ForegroundColor Gray }

# --- ساخت streamSettings ---
$streamSettings = @{
    network = $type
    security = $security
}

# --- تنظیمات TLS ---
if ($security -eq "tls") {
    $tlsSettings = @{}
    if ($sni)        { $tlsSettings.serverName = $sni }
    if ($fp)         { $tlsSettings.fingerprint = $fp }
    if ($alpn)       { $tlsSettings.alpn = @($alpn.Split(',')) }
    if ($tlsSettings.Count -gt 0) {
        $streamSettings.tlsSettings = $tlsSettings
    }
}

# --- تنظیمات REALITY ---
if ($security -eq "reality") {
    $realitySettings = @{}
    if ($sni)        { $realitySettings.serverName = $sni }
    if ($fp)         { $realitySettings.fingerprint = $fp }
    if ($pbk)        { $realitySettings.publicKey = $pbk }
    if ($sid)        { $realitySettings.shortId = $sid }
    if ($spx)        { $realitySettings.spiderX = $spx }
    $streamSettings.realitySettings = $realitySettings
}

# --- تنظیمات TCP + HTTP header ---
if ($type -eq "tcp" -and $headerType -eq "http") {
    $streamSettings.tcpSettings = @{
        header = @{
            type = "http"
            request = @{
                path = @($path)
                headers = @{
                    Host = @($hostHeader)
                }
            }
        }
    }
}
# --- تنظیمات TCP خالی ---
elseif ($type -eq "tcp") {
    # بدون تنظیمات اضافی
}

# --- تنظیمات WebSocket ---
elseif ($type -eq "ws") {
    $wsSettings = @{
        path = $path
    }
    if ($hostHeader) {
        $wsSettings.headers = @{
            Host = $hostHeader
        }
    }
    $streamSettings.wsSettings = $wsSettings
}

# --- تنظیمات gRPC ---
elseif ($type -eq "grpc") {
    $grpcSettings = @{}
    if ($serviceName) { $grpcSettings.serviceName = $serviceName }
    $streamSettings.grpcSettings = $grpcSettings
}

# --- تنظیمات HTTP/2 ---
elseif ($type -eq "h2" -or $type -eq "http") {
    $httpSettings = @{
        path = $path
    }
    if ($hostHeader) { $httpSettings.host = @($hostHeader) }
    $streamSettings.httpSettings = $httpSettings
}

# --- تنظیمات XHTTP ---
elseif ($type -eq "xhttp") {
    $xhttpSettings = @{
        path = $path
    }
    if ($hostHeader) { $xhttpSettings.host = $hostHeader }
    $streamSettings.xhttpSettings = $xhttpSettings
}

# --- ساخت outbound ---
$outbound = @{
    protocol = "vless"
    settings = @{
        vnext = @(
            @{
                address = $address
                port = $port
                users = @(
                    @{
                        id = $uuid
                        encryption = $encryption
                        flow = $flow
                    }
                )
            }
        )
    }
    streamSettings = $streamSettings
}

# --- ساخت کانفیگ نهایی ---
$config = @{
    log = @{
        loglevel = "warning"
    }
    inbounds = @(
        @{
            port = 10808
            listen = "127.0.0.1"
            protocol = "socks"
            settings = @{ udp = $true }
        },
        @{
            port = 10809
            listen = "127.0.0.1"
            protocol = "http"
            settings = @{}
        }
    )
    outbounds = @($outbound)
}

$json = $config | ConvertTo-Json -Depth 20

# --- نوشتن بدون BOM ---
[System.IO.File]::WriteAllText($OutputFile, $json, (New-Object System.Text.UTF8Encoding $false))

Write-Host ""
Write-Host "config.json created successfully!" -ForegroundColor Green