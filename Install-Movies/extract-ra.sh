#!/usr/bin/env bash
if [ ! -e RedAlert1_AlliedDisc.rar ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7587"
fi
if [ ! -e RedAlert1_SovietDisc.rar ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7588"
fi

unrar e RedAlert1_AlliedDisc.rar RedAlert1_AlliedDisc/RedAlert1_AlliedDisc/CD1_ALLIED_DISC.ISO
unrar e RedAlert1_SovietDisc.rar RedAlert1_SovietDisc/RedAlert1_SovietDisc/CD2_SOVIET_DISC.ISO

read -n1 -r -p "Possibly download, then extract extra music files? [Y/n]: " CONDITION;
echo
if [ "$CONDITION" == "n" ]; then
    exit
fi


if [ ! -e RACounterstrike.zip ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7589"
fi
if [ ! -e RATheAftermath.zip ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7591"
fi

unzip RACounterstrike.zip
unzip RATheAftermath.zip

