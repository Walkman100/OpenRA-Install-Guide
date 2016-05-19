#!/bin/bash
mkdir -p ~/.openra/Content/ra2/
pushd ~/.openra/Content/ra2/
wget http://xwis.net/downloads/Red-Alert-2-Multiplayer.exe
7z e Red-Alert-2-Multiplayer.exe
rm *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
