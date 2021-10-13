#!/usr/bin/env bash
# if download links are broken, see here: https://gruntmods.com/cutscenes-and-extra-content/
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
    OpenRAContent="$HOME/.config/openra/Content"
else
    OpenRAContent="$XDG_CONFIG_HOME/.openra/Content"
fi
DEST="${OpenRAContent}/d2k/v2/Movies"
echo "copying to $DEST..."

mkdir -p $DEST

#  currently cannot direct-download...
# if [ ! -e Dune_2000_Gruntmods_Edition_Cutscenes.exe ]; then
#     wget "https://gruntmods.com/download/909/"
# fi

7z e Dune_2000_Gruntmods_Edition_Cutscenes.exe -o$DEST
pushd $DEST
    rm *.dll *.ini *.bmp
popd
