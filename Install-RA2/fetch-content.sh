#!/usr/bin/env bash
# if download links are broken, see here: http://xwis.net/forums/index.php/topic/177134-downloads/
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST="$HOME/.config/openra"
else
  DEST="$HOME/.openra"
fi
DEST="${DEST}/Content/ra2/"
echo "copying to $DEST..."

mkdir -p "$DEST"
pushd "$DEST"
    if [ ! -e Red-Alert-2-Multiplayer.exe ]; then
        wget http://xwis.net/dl/Red-Alert-2-Multiplayer.exe
    fi
    7z e Red-Alert-2-Multiplayer.exe
    rm *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
