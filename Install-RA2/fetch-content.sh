#!/usr/bin/env bash
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST_ROOT="$HOME/.config/openra"
else
  DEST_ROOT="$HOME/.openra"
fi
DEST="/Content/ra2/"
echo "copying to $DEST_ROOT$DEST..."

mkdir -p "$DEST_ROOT$DEST"
pushd "$DEST_ROOT$DEST"
    wget http://xwis.net/downloads/Red-Alert-2-Multiplayer.exe
    7z e Red-Alert-2-Multiplayer.exe
    rm *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
