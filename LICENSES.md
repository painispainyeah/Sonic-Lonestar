# Upstream licenses and asset policy

This repository fetches upstream projects at setup time. Their source code and downloaded releases remain the property of their respective authors and are governed by the licenses and terms published by those projects.

- RSDK-GDT: https://github.com/Virtua-Studio/RSDK-GDT
- RSDK v5 Decompilation: https://github.com/RSDKModding/RSDKv5-Decompilation
- Sonic Mania Decompilation: https://github.com/RSDKModding/Sonic-Mania-Decompilation
- RetroED: https://github.com/RSDKModding/RetroED

Check the license file and README of each project before redistributing or modifying it. This repository does not bundle commercial game data, original game assets, or a generated Game.dll.

The setup workflow packages fetched tools into a GitHub Actions artifact for the repository owner to download. It does not commit third-party source trees or binaries into this repository.
