#!/usr/bin/env bash
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST_ROOT="$HOME/.config/openra"
else
  DEST_ROOT="$HOME/.openra"
fi
DEST="/Content/d2k/v2/Movies"
echo "copying to $DEST_ROOT$DEST..."

mkdir -p $DEST_ROOT$DEST
7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o$DEST_ROOT$DEST
pushd $DEST_ROOT$DEST
    rm *.dll *.ini *.bmp
popd
