set RA2Dir=%UserProfile%\Documents\OpenRA\Content\ra2
mkdir "%RA2Dir%"
pushd "%RA2Dir%"
    ..\utilities\wget http://xwis.net/downloads/Red-Alert-2-Multiplayer.exe
    ..\utilities\7z e Red-Alert-2-Multiplayer.exe
    del *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
