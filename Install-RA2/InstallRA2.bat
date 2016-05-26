@echo off
REM download & build OpenRA
    git clone https://github.com/OpenRA/OpenRA
    cd OpenRA
    
    REM  git checkout master
    REM master branch crashes as the mod is loading
    git checkout b6afc765b4be0b0289471c25c450d79eb948d3d3
    REM checkout latest commit at time of writing so future builds use the same version
    
    cmd /c make dependencies
    cmd /c make all
    REM  cmd /c make version
    REM since the mod doesn't have a make version command
    cd ..

REM download & build RA2
    git clone https://github.com/OpenRA/ra2
    cd ra2
    
    git checkout a1b6dd03109e00515cff9658a91dbe09d9fde0dd
    REM checkout latest commit at time of writing so future builds use the same version
    
    cmd /c make dependencies "%~dp0OpenRA"
    xcopy "OpenRA.Mods.RA2\dependencies\*" "..\OpenRA" /E /I /Y
    cmd /c make all

REM build done, now copy files
    set OutDir="%USERPROFILE%\Documents\OpenRA\mods\ra2"
    xcopy audio %OutDir%\audio /Y /E /I
    xcopy bits %OutDir%\bits /Y /E /I
    xcopy chrome %OutDir%\chrome /Y /E /I
    xcopy languages %OutDir%\languages /Y /E /I
    xcopy maps %OutDir%\maps /Y /E /I
    xcopy rules %OutDir%\rules /Y /E /I
    xcopy sequences %OutDir%\sequences /Y /E /I
    xcopy tilesets %OutDir%\tilesets /Y /E /I
    xcopy uibits %OutDir%\uibits /Y /E /I
    xcopy weapons %OutDir%\weapons /Y /E /I
    xcopy chrome.yaml %OutDir% /Y
    xcopy cursors.yaml %OutDir% /Y
    xcopy logo.png %OutDir% /Y
    xcopy metrics.yaml %OutDir% /Y
    xcopy mod.yaml %OutDir% /Y
    xcopy preview.png %OutDir% /Y
    xcopy weapons.yaml %OutDir% /Y
    xcopy OpenRA.Mods.RA2.dll %OutDir% /Y

explorer /select, %~dp0OpenRA\OpenRA.exe
timeout /t 2
echo msgbox "To play with the RA2 mod, use the executable selected", vbOk+vbInformation, "Instructions" > %temp%\msgbox.tmp.vbs
start wscript %temp%\msgbox.tmp.vbs //Nologo
