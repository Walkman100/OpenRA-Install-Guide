#!/usr/bin/env bash
die() {
    echo
    echo "$* Failed!"
    exit 1
}

# download & build OpenRA
    git clone https://github.com/OpenRA/OpenRA
    cd OpenRA
    
    git checkout 31d822bcd2cbae0908b0d730d3a54486fb625a61 || die "git checkout"
    # checkout tested working code so future builds use the same version
    
    make dependencies || die "make dependencies"
    make all || die "make all"
    #  make version
    # since the mod doesn't have a make version command
    cd ..

# download & build RA2
    git clone https://github.com/OpenRA/ra2
    cd ra2
    
    git checkout 48d1ee0200316aac56f8be7ec0d73fe1e895cef2 || die "git checkout"
    # checkout tested working code so future builds use the same version

    OpenRADir=$(dirname "$(pwd)")/OpenRA
    # Following https://github.com/OpenRA/ra2/wiki/Step-by-Step#unix
    ln -s ../ra2/OpenRA.Mods.RA2 "$OpenRADir/OpenRA.Mods.RA2"
    ln -s "$OpenRADir/Eluant.dll" "$OpenRADir/OpenRA.Mods.RA2/dependencies/Eluant.dll"
    ln -s "$OpenRADir/OpenRA.Game.exe" "$OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Game.exe"
    ln -s "$OpenRADir/mods/common/OpenRA.Mods.Common.dll" "$OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.Common.dll"
    ln -s "$OpenRADir/mods/ra/OpenRA.Mods.RA.dll" "$OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.RA.dll"
    ln -s "$OpenRADir/mods/ts/OpenRA.Mods.TS.dll" "$OpenRADir/OpenRA.Mods.RA2/dependencies/OpenRA.Mods.TS.dll"

    cd OpenRA.Mods.RA2
    xbuild || die "xbuild"
    cd ..

# build done, now copy files
    OutDir=$OpenRADir/mods/ra2
    mkdir -p "$OutDir"
    cp -r audio "$OutDir/audio"
    cp -r bits "$OutDir/bits"
    cp -r chrome "$OutDir/chrome"
    cp -r languages "$OutDir/languages"
    cp -r maps "$OutDir/maps"
    cp -r rules "$OutDir/rules"
    cp -r sequences "$OutDir/sequences"
    cp -r tilesets "$OutDir/tilesets"
    cp -r uibits "$OutDir/uibits"
    cp -r weapons "$OutDir/weapons"
    cp chrome.yaml cursors.yaml logo.png metrics.yaml mod.yaml preview.png weapons.yaml OpenRA.Mods.RA2/bin/Debug/OpenRA.Mods.RA2.dll "$OutDir"

# rm -r "$OpenRADir/mods/cnc"

echo "To play with the RA2 mod, use: \"./launch-game.sh\" from: \"$OpenRADir\""

read -p "Launch game now(g), or open folder(f), or both(b)? [g/f/b/n]: "

if [ -z "$REPLY" ]; then
    exit
elif [ $REPLY = f ]; then
    xdg-open $OpenRADir
elif [ $REPLY = g ]; then
    cd $OpenRADir
    ./launch-game.sh
elif [ $REPLY = b ]; then
    xdg-open $OpenRADir
    cd $OpenRADir
    ./launch-game.sh
fi
