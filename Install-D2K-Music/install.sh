#!/usr/bin/env bash
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    OpenRAContent="$HOME/.config/openra/Content"
else
    OpenRAContent="$XDG_CONFIG_HOME/.openra/Content"
fi
DEST="${OpenRAContent}/d2k/v2"
echo "copying to $DEST..."

mkdir -p "$DEST"
unzip "../d2k-music.zip" -d "$DEST"
