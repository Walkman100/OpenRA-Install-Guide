#!/usr/bin/env bash
if [ ! -e GDI95.zip ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7585"
fi
if [ ! -e NOD95.zip ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7586"
fi

unzip GDI95.zip GDI95.iso
unzip NOD95.zip NOD95.iso

read -n1 -r -p "Possibly download, then extract extra music files? [Y/n]: " CONDITION;
echo
if [ "$CONDITION" == "n" ]; then
    exit
fi


if [ ! -e CovertOps_ISO.zip ]; then
    wget "http://cncnz.com/?smd_process_download=1&download_id=7711"
fi

unzip CovertOps_ISO.zip

