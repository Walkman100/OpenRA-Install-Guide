#!/bin/bash
# download & build OpenRA
    git clone https://github.com/OpenRA/OpenRA
    cd OpenRA
    
    #  git checkout master
    # master branch crashes as the mod is loading
    git checkout 9f8261514a9717b0c26ca474d6acce0e20a01e9a
    # checkout latest commit at time of writing so future builds use the same version
    
    make dependencies
    make all
    #  make version
    # since the mod doesn't have a make version command
    cd ..

# download & build RA2
    git clone https://github.com/OpenRA/ra2
    cd ra2
    
    git checkout 549eec75f9a6d862fe150431c98abfc78f73c265
    # checkout latest commit at time of writing so future builds use the same version

    OpenRADir=$(dirname $(pwd))/OpenRA
    # Following https://github.com/OpenRA/ra2/wiki/Step-by-Step#unix
    ln -s ../ra2/OpenRA.Mods.RA2 $OpenRADir/OpenRA.Mods.RA2
    ln -s $OpenRADir/Eluant.dll $OpenRADir/OpenRA.Mods.RA2/dependencies/Eluant.dll
    ln -s $OpenRADir/OpenRA.Game.exe $OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Game.exe
    ln -s $OpenRADir/mods/common/OpenRA.Mods.Common.dll $OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.Common.dll
    ln -s $OpenRADir/mods/ra/OpenRA.Mods.RA.dll $OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.RA.dll
    ln -s $OpenRADir/mods/ts/OpenRA.Mods.TS.dll $OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.TS.dll

    cd OpenRA.Mods.RA2
    xbuild
    cd ..

# build done, now copy files
    OutDir=$OpenRADir/mods/ra2
#     cp audio $OutDir/audio /Y /E /I
#     cp bits $OutDir/bits /Y /E /I
#     cp chrome $OutDir/chrome /Y /E /I
#     cp languages $OutDir/languages /Y /E /I
#     cp maps $OutDir/maps /Y /E /I
#     cp rules $OutDir/rules /Y /E /I
#     cp sequences $OutDir/sequences /Y /E /I
#     cp tilesets $OutDir/tilesets /Y /E /I
#     cp uibits $OutDir/uibits /Y /E /I
#     cp weapons $OutDir/weapons /Y /E /I
#     cp chrome.yaml $OutDir /Y
#     cp cursors.yaml $OutDir /Y
#     cp logo.png $OutDir /Y
#     cp metrics.yaml $OutDir /Y
#     cp mod.yaml $OutDir /Y
#     cp preview.png $OutDir /Y
#     cp weapons.yaml $OutDir /Y
#     cp OpenRA.Mods.RA2.dll $OutDir /Y

# rm -r "../OpenRA/mods/cnc"

# echo "To play with the RA2 mod, use: $(dirname $(pwd))/OpenRA/OpenRA.exe"
# xdg-open $(dirname $(pwd))/OpenRA
