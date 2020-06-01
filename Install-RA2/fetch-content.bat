@echo off
rem if download links are broken, see here: http://xwis.net/forums/index.php/topic/177134-downloads/
set DEST=%UserProfile%\Documents\OpenRA\Content\ra2
echo copying to %DEST%...

mkdir "%DEST%"
pushd "%DEST%"
    IF NOT EXIST RedAlert1_SovietDisc.rar (
    ..\utilities\wget "http://xwis.net/dl/Red-Alert-2-Multiplayer.exe"
    )
    ..\utilities\7z e Red-Alert-2-Multiplayer.exe
    del *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
