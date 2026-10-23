# Upstream projects and licensing

This repository uses Git submodules instead of copying upstream source trees into this repository. Each project remains hosted by its original maintainer:

- RSDK-GDT: https://github.com/Virtua-Studio/RSDK-GDT
- RSDK v5 Decompilation: https://github.com/RSDKModding/RSDKv5-Decompilation
- Sonic Mania Decompilation: https://github.com/RSDKModding/Sonic-Mania-Decompilation
- RetroED: https://github.com/RSDKModding/RetroED

Review the license and README in each upstream repository before modifying or redistributing its contents. RetroED is released under GPL-3.0; see its upstream repository for the license text.

This repository does not commit RetroED binaries, commercial game data, a Sonic Mania datapack, or a generated Game.dll. The setup script downloads the official RetroED Windows release directly from its upstream GitHub release.
