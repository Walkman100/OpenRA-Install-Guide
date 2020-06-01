@echo off
rem if download links are broken, see here: https://gruntmods.com/cutscenes-and-extra-content/
set DEST=%UserProfile%\Documents\OpenRA\Content\d2k\v2\Movies
echo copying to %DEST%...

mkdir "%DEST%"

IF NOT EXIST Dune_2000_Gruntmods_Edition_Cutscenes.exe (
..\utilities\wget "https://gruntmods.com/download/909/"
)

..\utilities\7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o"%DEST%"
del "%DEST%\*.dll" "%DEST%\*.ini" "%DEST%\*.bmp"
