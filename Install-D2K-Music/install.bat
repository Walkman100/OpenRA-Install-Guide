@echo off
set OpenRAContent=%APPDATA%\OpenRA\Content
set DEST=%OpenRAContent%\d2k\v2
echo copying to %DEST%...

mkdir "%DEST%"
..\utilities\unzip ..\d2k-music.zip -d "%DEST%"
