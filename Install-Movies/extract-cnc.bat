@echo off
REM if download links are broken, see here: https://cncnz.com/features/freeware-classic-command-conquer-games/
IF NOT EXIST GDI95.zip (
..\utilities\wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/GDI95.zip"
)
IF NOT EXIST NOD95.zip (
..\utilities\wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/NOD95.zip"
)

..\utilities\unzip GDI95.zip GDI95.iso
..\utilities\unzip NOD95.zip NOD95.iso

echo Press enter to possibly download, then extract extra music files, Ctrl+C to exit...
pause

IF NOT EXIST CovertOps_ISO.zip (
..\utilities\wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/CovertOps_ISO.zip"
)

..\utilities\unzip CovertOps_ISO.zip
