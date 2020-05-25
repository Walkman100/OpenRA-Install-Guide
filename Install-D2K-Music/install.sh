#!/usr/bin/env bash
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST_ROOT="$HOME/.config/openra"
else
  DEST_ROOT="$HOME/.openra"
fi
DEST="/Content/d2k/v2"
echo "copying to $DEST_ROOT$DEST..."

mkdir -p "$DEST_ROOT$DEST"
unzip "../d2k-music.zip" -d "$DEST_ROOT$DEST"
