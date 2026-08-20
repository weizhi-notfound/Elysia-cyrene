# Deploy the Elysia-Cryene boot template + assets into a DSH web dist.
# Usage:
#   powershell -ExecutionPolicy Bypass -File scripts\install.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\install.ps1 -DshDist "C:\path\to\dsh-web-frontend\dist"
param(
  [string]$DshDist = "C:\Users\韦之\AppData\Roaming\npm\node_modules\@deepseek-ai\dsh\node_modules\@deepseek-ai\dsh-web-frontend\dist"
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

if (-not (Test-Path "$root\splash-template.html")) { throw "splash-template.html not found next to this script" }
if (-not (Test-Path "$root\assets\book.jpg"))      { throw "assets\book.jpg missing" }
if (-not (Test-Path "$root\assets\background.png")){ throw "assets\background.png missing" }
if (-not (Test-Path "$root\assets\刻印1.png"))     { throw "assets\刻印1.png missing" }
if (-not (Test-Path $DshDist))                     { throw "DshDist not found: $DshDist" }

# 1. inject the template: replace __BOOK_B64__ with the base64 book image
$tpl   = Get-Content "$root\splash-template.html" -Raw -Encoding UTF8
$bytes = [System.IO.File]::ReadAllBytes("$root\assets\book.jpg")
$b64   = [Convert]::ToBase64String($bytes)
if (-not $tpl.Contains('__BOOK_B64__')) { throw "template has no __BOOK_B64__ placeholder" }
$out   = $tpl.Replace('__BOOK_B64__', $b64)
[System.IO.File]::WriteAllText("$DshDist\index.html", $out, (New-Object System.Text.UTF8Encoding($false)))

# 2. background picture + sidebar mark into dist assets
Copy-Item "$root\assets\background.png" "$DshDist\assets\boot-bg.png" -Force
Copy-Item "$root\assets\刻印1.png"       "$DshDist\assets\boot-mark1.png" -Force

Write-Host "Deployed to $DshDist"
Write-Host "Restart the DSH web server, then hard-refresh the page."
