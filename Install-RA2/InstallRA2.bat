@echo off
REM download & build OpenRA
git clone https://github.com/OpenRA/OpenRA
cd OpenRA
git checkout master
cmd /c make dependencies
cmd /c make all
cmd /c make version
cd ..

REM download & build RA2
git clone https://github.com/OpenRA/ra2
cd ra2
echo.
echo Copy and paste the following into the console prompt:
echo %~dp0OpenRA
echo.
cmd /c make dependencies
xcopy "OpenRA.Mods.RA2\dependencies\*" "..\OpenRA" /E /I /Y
cmd /c make all

REM build done, now copy files
mkdir "%USERPROFILE%\Documents\OpenRA\mods\ra2"
xcopy "audio" "bits" "chrome" "languages" "maps" "rules" "sequences" "tilesets" "uibits" "weapons" "%USERPROFILE%\Documents\OpenRA\mods\ra2" /E /I
xcopy "chrome.yaml" "cursors.yaml" "logo.png" "metrics.yaml" "mod.yaml" "preview.png" "weapons.yaml" "OpenRA.Mods.RA2.dll" "%USERPROFILE%\Documents\OpenRA\mods\ra2" /E /I
explorer /select, %~dp0OpenRA\OpenRA.exe
