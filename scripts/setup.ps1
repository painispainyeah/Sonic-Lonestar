[CmdletBinding()]
param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

function Write-Step([string]$Message) {
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Require-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found. Install Git for Windows and ensure git.exe is on PATH."
    }
}

Require-Command "git"
$Root = [System.IO.Path]::GetFullPath($Root)
$Vendor = Join-Path $Root "vendor"
$Tools = Join-Path $Root "tools"
$Workspace = Join-Path $Root "workspace"

@(
    $Vendor,
    $Tools,
    (Join-Path $Tools "RetroED"),
    (Join-Path $Workspace "levels"),
    (Join-Path $Workspace "palettes"),
    (Join-Path $Workspace "game-data")
) | ForEach-Object {
    New-Item -ItemType Directory -Force -Path $_ | Out-Null
}

$Repos = @(
    @{ Name = "RSDK-GDT"; Url = "https://github.com/Virtua-Studio/RSDK-GDT.git" },
    @{ Name = "RSDKv5-Decompilation"; Url = "https://github.com/RSDKModding/RSDKv5-Decompilation.git" },
    @{ Name = "Sonic-Mania-Decompilation"; Url = "https://github.com/RSDKModding/Sonic-Mania-Decompilation.git" }
)

foreach ($Repo in $Repos) {
    $Destination = Join-Path $Vendor $Repo.Name
    if (Test-Path (Join-Path $Destination ".git")) {
        Write-Step "Updating $($Repo.Name)"
        git -C $Destination pull --ff-only
        if ($LASTEXITCODE -ne 0) { throw "Could not update $($Repo.Name)." }
    } elseif (Test-Path $Destination) {
        throw "$Destination exists but is not a Git checkout. Move it aside and rerun."
    } else {
        Write-Step "Cloning $($Repo.Name)"
        git clone --depth 1 $Repo.Url $Destination
        if ($LASTEXITCODE -ne 0) { throw "Could not clone $($Repo.Name)." }
    }
}

Write-Step "Finding the latest RetroED Windows release"
$ReleaseApi = "https://api.github.com/repos/RSDKModding/RetroED/releases/latest"
try {
    $Release = Invoke-RestMethod -Uri $ReleaseApi -Headers @{ "User-Agent" = "Sonic-Lonestar-setup" }
} catch {
    throw "Could not query the RetroED release API: $($_.Exception.Message)"
}

$Assets = @($Release.assets)
$Asset = $Assets | Where-Object {
    $_.name -match '(?i)(windows|win64|win-x64|win_x64|x64)' -and
    $_.name -match '(?i)\.(zip|7z|exe)$'
} | Select-Object -First 1

if (-not $Asset) {
    Write-Warning "No obvious Windows archive/installer was found in the latest RetroED release."
    Write-Host "Choose the Windows asset manually: $($Release.html_url)"
} else {
    $Destination = Join-Path (Join-Path $Tools "RetroED") $Asset.name
    Write-Host "Downloading $($Asset.name)"
    Invoke-WebRequest -Uri $Asset.browser_download_url -OutFile $Destination
    Write-Host "Saved to $Destination"
}

Write-Step "Setup complete"
Write-Host "Project root: $Root"
Write-Host "Upstream source: $(Join-Path $Root 'vendor')"
Write-Host "RetroED download: $(Join-Path $Root 'tools\RetroED')"
Write-Host "Workspace: $Workspace"
Write-Host "Note: this does not create Game.dll or provide commercial game data."
