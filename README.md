# Sonic Lonestar

A personal workspace for a Sonic fan-game using **RSDK-GDT** on **RSDK v5 Ultimate**, with **RetroED v2** for scene and palette editing.

## Get the source projects

Clone this repository with its submodules:

\`\`\`powershell
git clone --recurse-submodules https://github.com/painispainyeah/Sonic-Lonestar.git
cd Sonic-Lonestar
.\scripts\setup.ps1
\`\`\`

If you already cloned without submodules, run:

\`\`\`powershell
git submodule update --init --recursive
.\scripts\setup.ps1
\`\`\`

The source projects are tracked as Git submodules, so their original repositories, histories, and licenses remain clear:

- \`vendor/RSDK-GDT\`: GDT template, scripts, stage data and object definitions.
- \`vendor/RSDKv5-Decompilation\`: RSDK v5 Ultimate engine decompilation.
- \`vendor/Sonic-Mania-Decompilation\`: optional reference for editor-enabled game logic/build configuration.

The setup script downloads the official Windows RetroED release to \`tools/RetroED/RetroED.exe\`.

## Download the editor toolkit artifact

1. Open the **Actions** tab in this repository.
2. Choose **Build tool bundle**.
3. Click **Run workflow**.
4. When it finishes, download the \`Sonic-Lonestar-toolkit\` artifact from that run.

The artifact contains RetroED, its upstream source checkout, and the setup documentation. The GDT and engine source checkouts are provided as submodules rather than duplicated into the artifact.

## Open a GDT level and edit its palette

See [docs/EDITOR_SETUP.md](docs/EDITOR_SETUP.md). In short, set RetroED's RSDK v5 base data folder to \`vendor/RSDK-GDT/Data\`, open a stage's \`Act1.bin\` in the v5 Scene Editor, and open that stage's \`StageConfig.bin\` in the Palette Editor.

**You do not need a Game.dll just to edit a stage palette.** Game logic linking is a separate, optional step for richer game-specific object metadata and must use a compatible editor-enabled DLL. Do not substitute a random DLL and assume GDT-specific objects will be understood.

## Important

- This repository does not contain commercial game data, a Sonic Mania data pack, or a generated \`Game.dll\`.
- RSDK-GDT's README says to use its source code rather than its outdated releases and to enable text scripts in the compatible engine setup.
- Follow each upstream project's README and license before building or redistributing anything.
