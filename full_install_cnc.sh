#!/usr/bin/env bash
# if download links are broken, see here: https://cncnz.com/features/freeware-classic-command-conquer-games/
set -e

# official remote sources
REMOTE_BASE_URL="https://www.openra.net/packages/"
BASE_GAME_FILES_LIST_NAME="cnc-mirrors.txt"
BASE_GAME_FILES_ARCHIVE="cnc-packages.zip"
BASE_GAME_MUSIC_LIST_NAME="cnc-music-mirrors.txt"
BASE_GAME_MUSIC_ARCHIVE="cnc-music.zip"

# base url for downloading local sources
LOCAL_BASE_URL="https://files.cncnz.com/cc1_tiberian_dawn/full_game/"

# properties of 'GDI Disk' download
GDI_SRC_FILE="GDI95.zip"
GDI_SRC_SIZE=609021742
GDI_ISO_FILE="GDI95.iso"
GDI_VIDEO_LIST="banner.vqa bcanyon.vqa bkground.vqa bombaway.vqa bombflee.vqa burdet1.vqa burdet2.vqa cc2tease.vqa consyard.vqa desolat.vqa dino.vqa flag.vqa flyy.vqa forestkl.vqa gameover.vqa gdi10.vqa gdi11.vqa gdi12.vqa gdi13.vqa gdi14.vqa gdi15.vqa gdi1.vqa gdi2.vqa gdi3lose.vqa gdi3.vqa gdi4a.vqa gdi4b.vqa gdi5.vqa gdi6.vqa gdi7.vqa gdi8a.vqa gdi8b.vqa gdi9.vqa gdiend1.vqa gdiend2.vqa gdifina.vqa gdifinb.vqa gdilose.vqa generic.vqa gunboat.vqa hellvaly.vqa intro2.vqa landing.vqa logo.vqa napalm.vqa nitejump.vqa nod1.vqa nodflees.vqa nodlose.vqa nodsweep.vqa paratrop.vqa pintle.vqa planecra.vqa podium.vqa retro.vqa sabotage.vqa samdie.vqa samsite.vqa seige.vqa tbrinfo1.vqa tbrinfo2.vqa tbrinfo3.vqa trailer.vqa turtkill.vqa visor.vqa"

# properties for 'NOD Disk' download
NOD_SRC_FILE="NOD95.zip"
NOD_SRC_SIZE=592510766
NOD_ISO_FILE="NOD95.iso"
NOD_VIDEO_LIST="airstrk.vqa akira.vqa banner.vqa bcanyon.vqa bombaway.vqa bombflee.vqa cc2tease.vqa consyard.vqa desflees.vqa deskill.vqa dessweep.vqa dino.vqa flag.vqa forestkl.vqa gameover.vqa gdi1.vqa generic.vqa insites.vqa intro2.vqa kanepre.vqa landing.vqa logo.vqa nod10a.vqa nod10b.vqa nod11.vqa nod12.vqa nod13.vqa nod1pre.vqa nod1.vqa nod2.vqa nod3.vqa nod4a.vqa nod4b.vqa nod5.vqa nod6.vqa nod7a.vqa nod7b.vqa nod8.vqa nod9.vqa nodend1.vqa nodend2.vqa nodend3.vqa nodend4.vqa nodfinal.vqa nodlose.vqa nuke.vqa obel.vqa refint.vqa retro.vqa samsite.vqa seige.vqa sethpre.vqa spycrash.vqa stealth.vqa sundial.vqa tankgo.vqa tankkill.vqa tiberfx.vqa trailer.vqa trtkil_d.vqa visor.vqa"

# properties for 'Covert Ops Disk' download
COPS_SRC_FILE="CovertOps_ISO.zip"
COPS_SRC_SIZE=250055735
COPS_ISO_FILE="covert.iso"
COPS_VIDEO_LIST="banr_nod.vqa blackout.vqa bodybags.vqa inferno.vqa iontest.vqa refinery.vqa"
COPS_AUDIO_ARCHIVE_FILE="SCORES.MIX"
COPS_AUDIO_DESTINATION_FILE="scores-covertops.mix"

AUDIO_ARCHIVE_FILE="SCORES.MIX"
VIDEO_ARCHIVE_FILE="MOVIES.MIX"

# internal stuff
OFFICIAL_MOD_NAME="Tiberian Dawn"
TOTAL_SIZE=950607189
UTILS="$(dirname "$(readlink -f "$0")")/utilities/"
source "${UTILS}helper.sh" # import helper functions
DEST="$(get_destination_root)/Content/cnc/"
DEST_VIDEO="${DEST}movies"
TEMP="/tmp/"

# make sure all necessary tools are available and display detailed install information if not
check_prerequisites

# display info text
show_infotext ${TEMP} ${BASE_GAME_FILES_ARCHIVE} ${BASE_GAME_MUSIC_ARCHIVE} ${GDI_SRC_FILE} ${NOD_SRC_FILE} ${COPS_SRC_FILE}

echo -e "\nInstalling content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} ($((${TOTAL_SIZE}/1024/1024)) MiB)..."

# official remote content
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Base Game Files" "${REMOTE_BASE_URL}" "${BASE_GAME_FILES_LIST_NAME}" "${BASE_GAME_FILES_ARCHIVE}" "${DEST}" "${TEMP}"
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Base Game Music" "${REMOTE_BASE_URL}" "${BASE_GAME_MUSIC_LIST_NAME}" "${BASE_GAME_MUSIC_ARCHIVE}" "${DEST}" "${TEMP}"

# local disk content
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "GDI Campaign Briefings"  "${LOCAL_BASE_URL}" "${GDI_SRC_FILE}"  "${GDI_SRC_SIZE}"  "${GDI_ISO_FILE}"  "${VIDEO_ARCHIVE_FILE}" "" "${GDI_VIDEO_LIST}"  "${DEST_VIDEO}" "${TEMP}"
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Nod Campaign Briefings"  "${LOCAL_BASE_URL}" "${NOD_SRC_FILE}"  "${NOD_SRC_SIZE}"  "${NOD_ISO_FILE}"  "${VIDEO_ARCHIVE_FILE}" "" "${NOD_VIDEO_LIST}"  "${DEST_VIDEO}" "${TEMP}"
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Covert Operations Music" "${LOCAL_BASE_URL}" "${COPS_SRC_FILE}" "${COPS_SRC_SIZE}" "${COPS_ISO_FILE}" "${VIDEO_ARCHIVE_FILE}" "" "${COPS_VIDEO_LIST}" "${DEST_VIDEO}" "${TEMP}" "${AUDIO_ARCHIVE_FILE}" "${DEST}${COPS_AUDIO_DESTINATION_FILE}"

echo -e "...installing content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} finished successfully!\n"
