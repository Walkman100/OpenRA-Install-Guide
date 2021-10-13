#!/usr/bin/env bash
# if download links are broken, see here: http://xwis.net/forums/index.php/topic/177134-downloads/
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    OpenRAContent="$HOME/.config/openra/Content"
else
    OpenRAContent="$XDG_CONFIG_HOME/.openra/Content"
fi
DEST="${OpenRAContent}/d2k/v2"
echo "copying to $DEST..."

mkdir -p "$DEST"
pushd "$DEST"
    if [ ! -e Red-Alert-2-Multiplayer.exe ]; then
        wget http://xwis.net/Dl/Red-Alert-2-Multiplayer.exe
    fi
    7z e Red-Alert-2-Multiplayer.exe
    rm *.exe *.dll *.DLL *.wav *.mmp *.CFG *.WAR *.cache
popd
