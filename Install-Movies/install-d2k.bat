@echo off
REM if download links are broken, see here: https://gruntmods.com/cutscenes-and-extra-content/
set OpenRAContent=%UserProfile%\AppData\Roaming\OpenRA\Content
set DEST=%OpenRAContent%\d2k\v2\Movies
echo copying to %DEST%...

mkdir "%DEST%"

REM Currently cannot direct-download...
REM IF NOT EXIST Dune_2000_Gruntmods_Edition_Cutscenes.exe (
REM     ..\utilities\wget "https://gruntmods.com/download/909/"
REM )

..\utilities\7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o"%DEST%"
del "%DEST%\*.dll" "%DEST%\*.ini" "%DEST%\*.bmp"
