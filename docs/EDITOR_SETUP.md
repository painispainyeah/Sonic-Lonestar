# Editing RSDK-GDT levels and palettes with RetroED v2

This guide assumes the RSDK-GDT source is available in \`vendor/RSDK-GDT\` and RetroED is downloaded to \`tools/RetroED/RetroED.exe\`.

## 1. Configure RetroED's data folder

1. Run \`tools/RetroED/RetroED.exe\`.
2. Open **Options → Game Manager**.
3. Select the **RSDK v5** entry/tab.
4. Set **Base Data Folder Location** to the \`Data\` directory inside the GDT checkout:

   \`vendor/RSDK-GDT/Data\`

   Select the \`Data\` folder itself, not the parent \`RSDK-GDT\` folder.

## 2. Open an existing stage

GDT's source uses stage files named \`Act1.bin\`, not \`Scene1.bin\`.

1. Open **Tools → Scene Editor → v5**.
2. Use **File → Open**.
3. Browse to \`vendor/RSDK-GDT/Data/Stages/Test/Act1.bin\`.
4. If prompted to load a GameConfig, choose \`vendor/RSDK-GDT/Data/Game/GameConfig.bin\`.
5. Save a backup copy of the stage before making edits.

The GDT source contains other stage folders under \`Data/Stages\`; each stage generally has its own \`Act1.bin\` and \`StageConfig.bin\`.

## 3. Edit the stage palette

1. Open **Tools → Palette Editor**.
2. Choose **File → Open**.
3. Select the stage's \`StageConfig.bin\`, for example:

   \`vendor/RSDK-GDT/Data/Stages/Test/StageConfig.bin\`

4. Edit a color with the palette grid/color picker and save the file.
5. Launch the compatible GDT engine build to verify the result.

You can also use the Scene Editor's **Edit Palette** command after a stage and its StageConfig have been loaded. Keep a backup because StageConfig stores more than just colors.

## 4. Paint tiles and place objects

In the v5 Scene Editor, use the tile/chunk selectors and layer controls to edit the scene layout. Object placement and object names depend on the loaded GameConfig and any compatible game-logic link. Save to a copy first, then test it in the GDT engine.

## About Game.dll

**A Game.dll is not required just to open/edit a palette.** RetroED's optional game-logic link can expose richer object names and variables, but the DLL must be built with editor support and match the target engine/game logic. The GDT README says its source code should be installed into a compatible decompilation and that its releases are outdated. A stock Sonic Mania Game.dll is not guaranteed to describe GDT's custom objects.

This repository intentionally does not invent or bundle a supposedly compatible Game.dll. Use the GDT setup instructions and the matching decompilation before trying to link game logic.
