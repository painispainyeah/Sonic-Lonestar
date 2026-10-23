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
        throw "Required command '$Name' was not found. Install Git for Windows and ensure it is on PATH."
    }
}

Require-Command "git"
$Root = [System.IO.Path]::GetFullPath($Root)
$Vendor = Join-Path $Root "vendor"
$Tools = Join-Path $Root "tools"
$Workspace = Join-Path $Root "workspace"
$GitModules = Join-Path $Root ".gitmodules"
$RootGit = Join-Path $Root ".git"

New-Item -ItemType Directory -Force -Path $Vendor, $Tools, (Join-Path $Tools "RetroED"), (Join-Path $Workspace "levels"), (Join-Path $Workspace "palettes"), (Join-Path $Workspace "game-data") | Out-Null

# Prefer the pinned submodules when this is a Git checkout. ZIP downloads do not
# contain submodule contents, so fall back to ordinary shallow clones in that case.
$HasGitMetadata = (Test-Path $RootGit) -or (Test-Path (Join-Path $Root ".git"))
if ($HasGitMetadata -and (Test-Path $GitModules)) {
    Write-Step "Initialising source submodules"
    git -C $Root submodule update --init --recursive
    if ($LASTEXITCODE -ne 0) { throw "Could not initialise Git submodules." }
}

$Repos = @(
    @{ Name = "RSDK-GDT"; Url = "https://github.com/Virtua-Studio/RSDK-GDT.git" },
    @{ Name = "RSDKv5-Decompilation"; Url = "https://github.com/RSDKModding/RSDKv5-Decompilation.git" },
    @{ Name = "Sonic-Mania-Decompilation"; Url = "https://github.com/RSDKModding/Sonic-Mania-Decompilation.git" }
)

foreach ($Repo in $Repos) {
    $Destination = Join-Path $Vendor $Repo.Name
    if (Test-Path (Join-Path $Destination ".git")) {
        Write-Step "$($Repo.Name) is already available"
        continue
    }

    if (Test-Path $Destination) {
        $Items = @(Get-ChildItem -Force -Path $Destination -ErrorAction SilentlyContinue)
        if ($Items.Count -gt 0) {
            Write-Warning "$Destination exists but is not a Git checkout; leaving it untouched."
            continue
        }
        Remove-Item -Force -Path $Destination
    }

    Write-Step "Cloning $($Repo.Name)"
    git clone --depth 1 --recurse-submodules --shallow-submodules $Repo.Url $Destination
    if ($LASTEXITCODE -ne 0) { throw "Could not clone $($Repo.Name)." }
}

Write-Step "Finding the latest RetroED Windows release"
$ReleaseApi = "https://api.github.com/repos/RSDKModding/RetroED/releases/latest"
try {
    $Release = Invoke-RestMethod -Uri $ReleaseApi -Headers @{ "User-Agent" = "Sonic-Lonestar-setup" }
} catch {
    throw "Could not query the RetroED release API: $($_.Exception.Message)"
}

$Asset = @($Release.assets) | Where-Object { $_.name -ieq "RetroED.exe" } | Select-Object -First 1
if (-not $Asset) {
    throw "The latest RetroED release did not contain RetroED.exe. Check $($Release.html_url) and update the setup script if the asset name changed."
}

$RetroEDDir = Join-Path $Tools "RetroED"
$Destination = Join-Path $RetroEDDir $Asset.name
Write-Host "Downloading $($Asset.name) from RetroED $($Release.tag_name)"
Invoke-WebRequest -Uri $Asset.browser_download_url -OutFile $Destination -Headers @{ "User-Agent" = "Sonic-Lonestar-setup" }

Write-Step "Setup complete"
Write-Host "GDT data folder: $(Join-Path $Vendor 'RSDK-GDT\Data')"
Write-Host "RetroED executable: $Destination"
Write-Host "Level/palette guide: $(Join-Path $Root 'docs\EDITOR_SETUP.md')"
Write-Host "Note: Game.dll is not required just to edit palettes; game-logic linking is a separate step."
