#!/usr/bin/env bash
if [ ! -e RedAlert1_AlliedDisc.rar ]; then
    wget "https://cncnz.com/_files/RedAlert1_AlliedDisc.rar"
fi
if [ ! -e RedAlert1_SovietDisc.rar ]; then
    wget "https://cncnz.com/_files/RedAlert1_SovietDisc.rar"
fi

unrar e RedAlert1_AlliedDisc.rar RedAlert1_AlliedDisc/RedAlert1_AlliedDisc/CD1_ALLIED_DISC.ISO
unrar e RedAlert1_SovietDisc.rar RedAlert1_SovietDisc/RedAlert1_SovietDisc/CD2_SOVIET_DISC.ISO

read -n1 -r -p "Possibly download, then extract extra music files? [Y/n]: " CONDITION;
echo
if [ "$CONDITION" == "n" ]; then
    exit
fi


if [ ! -e RACounterstrike.zip ]; then
    wget "https://cncnz.com/_files/RACounterstrike.zip"
fi
if [ ! -e RATheAftermath.zip ]; then
    wget "https://cncnz.com/_files/RATheAftermath.zip"
fi

unzip RACounterstrike.zip
unzip RATheAftermath.zip

