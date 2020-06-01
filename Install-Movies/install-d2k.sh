#!/usr/bin/env bash
# if download links are broken, see here: https://gruntmods.com/cutscenes-and-extra-content/
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  DEST="$HOME/.config/openra"
else
  DEST="$HOME/.openra"
fi
DEST="${DEST}/Content/d2k/v2/Movies"
echo "copying to $DEST..."

mkdir -p $DEST

if [ ! -e Dune_2000_Gruntmods_Edition_Cutscenes.exe ]; then
    wget "https://gruntmods.com/download/909/"
fi

7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o$DEST
pushd $DEST
    rm *.dll *.ini *.bmp
popd
