#!/usr/bin/env bash
# if download links are broken, see here: https://cncnz.com/features/freeware-classic-command-conquer-games/
if [ ! -e GDI95.zip ]; then
    wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/GDI95.zip"
fi
if [ ! -e NOD95.zip ]; then
    wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/NOD95.zip"
fi

unzip GDI95.zip GDI95.iso
unzip NOD95.zip NOD95.iso

read -n1 -r -p "Possibly download, then extract extra music files? [Y/n]: " CONDITION;
echo
if [ "$CONDITION" == "n" ]; then
    exit
fi


if [ ! -e CovertOps_ISO.zip ]; then
    wget "https://files.cncnz.com/cc1_tiberian_dawn/full_game/CovertOps_ISO.zip"
fi

unzip CovertOps_ISO.zip

