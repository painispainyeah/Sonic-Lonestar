# Upstream sources and downloads

- **RSDK-GDT source:** https://github.com/Virtua-Studio/RSDK-GDT
- **RSDK v5 Ultimate decompilation:** https://github.com/RSDKModding/RSDKv5-Decompilation
- **Sonic Mania decompilation:** https://github.com/RSDKModding/Sonic-Mania-Decompilation
- **RetroED source and releases:** https://github.com/RSDKModding/RetroED
- **RetroED latest Windows release:** https://github.com/RSDKModding/RetroED/releases/latest

The first three source repositories are Git submodules. Clone this repository with \`--recurse-submodules\` to populate \`vendor/\`.

The setup script downloads the official \`RetroED.exe\` release directly into \`tools/RetroED/\`. The GitHub Actions workflow can package that executable with the setup guide as a short-lived downloadable artifact.

Do not add commercial game data or a Sonic Mania \`Data.rsdk\` to this repository.
