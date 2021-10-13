#!/usr/bin/env bash
# if download links are broken, see here: https://cncnz.com/features/freeware-classic-command-conquer-games/
if [ ! -e RedAlert1_AlliedDisc.rar ]; then
    wget "https://files.cncnz.com/red_alert/full_game/RedAlert1_AlliedDisc.rar"
fi
if [ ! -e RedAlert1_SovietDisc.rar ]; then
    wget "https://files.cncnz.com/red_alert/full_game/RedAlert1_SovietDisc.rar"
fi

unrar e RedAlert1_AlliedDisc.rar RedAlert1_AlliedDisc/RedAlert1_AlliedDisc/CD1_ALLIED_DISC.ISO
unrar e RedAlert1_SovietDisc.rar RedAlert1_SovietDisc/RedAlert1_SovietDisc/CD2_SOVIET_DISC.ISO

read -n1 -r -p "Possibly download, then extract extra music files? [Y/n]: " CONDITION;
echo
if [ "$CONDITION" == "n" ]; then
    exit
fi

if [ ! -e RACounterstrike.zip ]; then
    wget "https://files.cncnz.com/red_alert/full_game/RACounterstrike.zip"
fi
if [ ! -e RATheAftermath.zip ]; then
    wget "https://files.cncnz.com/red_alert/full_game/RATheAftermath.zip"
fi

unzip RACounterstrike.zip
unzip RATheAftermath.zip
