set RA2Dir=%UserProfile%\Documents\OpenRA\Content\ra2
mkdir "%RA2Dir%"
..\utilities\wget http://xwis.net/downloads/Red-Alert-2-Multiplayer.exe -O "%RA2Dir%\Red-Alert-2-Multiplayer.exe"
..\utilities\7z e "%RA2Dir%\Red-Alert-2-Multiplayer.exe" -o"%RA2Dir%"
del %RA2Dir%\*.exe %RA2Dir%\*.dll %RA2Dir%\*.DLL %RA2Dir%\*.wav %RA2Dir%\*.mmp %RA2Dir%\*.CFG %RA2Dir%\*.WAR %RA2Dir%\*.cache
