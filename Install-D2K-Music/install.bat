@echo off
set DEST=%UserProfile%\Documents\OpenRA\Content\d2k\v2

echo copying to %DEST%...

mkdir "%DEST%"
..\utilities\unzip ..\d2k-music.zip -d "%DEST%"
