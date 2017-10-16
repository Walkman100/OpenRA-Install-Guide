@echo off
IF NOT EXIST RedAlert1_AlliedDisc.rar (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7587"
)
IF NOT EXIST RedAlert1_SovietDisc.rar (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7588"
)

..\utilities\7z e RedAlert1_AlliedDisc.rar RedAlert1_AlliedDisc/RedAlert1_AlliedDisc/CD1_ALLIED_DISC.ISO
..\utilities\7z e RedAlert1_SovietDisc.rar RedAlert1_SovietDisc/RedAlert1_SovietDisc/CD2_SOVIET_DISC.ISO

echo Press enter to possibly download, then extract extra music files...
pause

IF NOT EXIST RACounterstrike.zip (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7589"
)
IF NOT EXIST RATheAftermath.zip (
..\utilities\wget "http://cncnz.com/?smd_process_download=1&download_id=7591"
)

..\utilities\unzip RACounterstrike.zip
..\utilities\unzip RATheAftermath.zip
