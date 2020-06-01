#!/usr/bin/env bash
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST="$HOME/.config/openra"
else
  DEST="$HOME/.openra"
fi
DEST="${DEST}/Content/d2k/v2"
echo "copying to $DEST..."

mkdir -p "$DEST"
unzip "../d2k-music.zip" -d "$DEST"
