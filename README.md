# Sonic Lonestar

Workspace and tool bootstrap for a Sonic fan-game project using **RSDK v5 Ultimate** and **RSDK-GDT**.

## Get the tools

1. Open **Actions** in this repository.
2. Select **Build tool bundle**.
3. Click **Run workflow**.
4. When it finishes, open the run and download the **Sonic-Lonestar-toolkit** artifact.
5. Extract it. It contains upstream source checkouts, a Windows RetroED release when one is available, and empty workspace folders.

The workflow fetches current upstream versions when run. The exact RetroED asset depends on what the upstream project publishes as its latest release.

## Local setup (Windows)

Install Git for Windows, then run PowerShell from the folder where you want the project:

    git clone https://github.com/painispainyeah/Sonic-Lonestar.git
    cd Sonic-Lonestar
    Set-ExecutionPolicy -Scope Process Bypass
    .\scripts\setup.ps1

The script clones RSDK-GDT, RSDK v5 decompilation, and Sonic Mania decompilation into vendor/, and attempts to download a Windows RetroED release into tools/RetroED/.

## Important: game logic and assets

This repository does **not** generate a compatible Game.dll. RetroED features that depend on game logic need a compatible editor-enabled DLL for the exact RSDK/game build. A random DLL is not a substitute.

No commercial game data, copyrighted game assets, or proprietary binaries are included. Supply files you are legally entitled to use and follow each upstream project's instructions and license.

## Layout

- .github/workflows/build-tool-bundle.yml: manually run a cloud setup and package the result as a downloadable artifact.
- scripts/setup.ps1: local Windows setup equivalent.
- workspace/levels/: place level work here.
- workspace/palettes/: place palette work here.
- workspace/game-data/: place legally obtained game data here; it is ignored by Git.
- vendor/: downloaded upstream repositories; ignored by Git.
- tools/: downloaded editor releases; ignored by Git.

## Upstream projects

- https://github.com/Virtua-Studio/RSDK-GDT
- https://github.com/RSDKModding/RSDKv5-Decompilation
- https://github.com/RSDKModding/Sonic-Mania-Decompilation
- https://github.com/RSDKModding/RetroED

Respect the licenses and attribution requirements of each upstream project.