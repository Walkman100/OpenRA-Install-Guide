#!/usr/bin/env bash
# if download links are broken, see here: https://cncnz.com/features/freeware-classic-command-conquer-games/
set -e

# official remote sources
REMOTE_BASE_URL="https://www.openra.net/packages/"
BASE_GAME_FILES_LIST_NAME="ra-base-mirrors.txt"
BASE_GAME_FILES_ARCHIVE="ra-base.zip"
AFTERMATH_EXPANSION_FILES_LIST_NAME="ra-aftermath-mirrors.txt"
AFTERMATH_EXPANSION_FILES_ARCHIVE="ra-aftermath.zip"
CNC_DESERT_TILESET_LIST_NAME="ra-cncdesert-mirrors.txt"
CNC_DESERT_TILESET_ARCHIVE="ra-cncdesert.zip"
BASE_GAME_MUSIC_LIST_NAME="ra-music-mirrors.txt"
BASE_GAME_MUSIC_ARCHIVE="ra-music.zip"

# base url for downloading local sources
LOCAL_BASE_URL="https://files.cncnz.com/red_alert/full_game/"

# properties of 'Allied Disk' download
ALLIED_SRC_FILE="RedAlert1_AlliedDisc.rar"
ALLIED_SRC_SIZE=524014608
ALLIED_ISO_FILE="CD1_ALLIED_DISC.ISO"
ALLIED_VIDEO_ARCHIVE_FILE="movies1.mix"
ALLIED_VIDEO_LIST="aagun.vqa aftrmath.vqa ally10b.vqa ally10.vqa ally11.vqa ally12.vqa ally14.vqa ally1.vqa ally2.vqa ally4.vqa ally5.vqa ally6.vqa ally8.vqa ally9.vqa allyend.vqa allymorf.vqa apcescpe.vqa assess.vqa battle.vqa binoc.vqa bmap.vqa brdgtilt.vqa cronfail.vqa crontest.vqa destroyr.vqa dud.vqa elevator.vqa flare.vqa frozen.vqa grvestne.vqa landing.vqa masasslt.vqa mcv_land.vqa mcv.vqa montpass.vqa oildrum.vqa overrun.vqa prolog.vqa redintro.vqa shipsink.vqa shorbom1.vqa shorbom2.vqa shorbomb.vqa snowbomb.vqa soviet1.vqa sovtstar.vqa spy.vqa tanya1.vqa tanya2.vqa toofar.vqa trinity.vqa"

# properties of 'Soviet Disk' download
SOVIET_SRC_FILE="RedAlert1_SovietDisc.rar"
SOVIET_SRC_SIZE=526433084
SOVIET_ISO_FILE="CD2_SOVIET_DISC.ISO"
SOVIET_VIDEO_ARCHIVE_FILE="movies2.mix"
SOVIET_VIDEO_LIST="aagun.vqa airfield.vqa ally1.vqa allymorf.vqa averted.vqa beachead.vqa bmap.vqa bombrun.vqa countdwn.vqa cronfail.vqa double.vqa dpthchrg.vqa execute.vqa flare.vqa landing.vqa mcvbrdge.vqa mig.vqa movingin.vqa mtnkfact.vqa nukestok.vqa onthprwl.vqa periscop.vqa prolog.vqa radrraid.vqa redintro.vqa search.vqa sfrozen.vqa sitduck.vqa slntsrvc.vqa snowbomb.vqa snstrafe.vqa sovbatl.vqa sovcemet.vqa sovfinal.vqa soviet10.vqa soviet11.vqa soviet12.vqa soviet13.vqa soviet14.vqa soviet1.vqa soviet2.vqa soviet3.vqa soviet4.vqa soviet5.vqa soviet6.vqa soviet7.vqa soviet8.vqa soviet9.vqa sovmcv.vqa sovtstar.vqa spotter.vqa strafe.vqa take_off.vqa tesla.vqa v2rocket.vqa"

# properties of 'Counterstrike Disk' download
COUNTERSTRIKE_SRC_FILE="RACounterstrike.zip"
COUNTERSTRIKE_SRC_SIZE=271469934
COUNTERSTRIKE_ISO_FILE="RACounterstrike.iso"
COUNTERSTRIKE_AUDIO_ARCHIVE_FILE="scores.mix"
COUNTERSTRIKE_AUDIO_LIST="2nd_hand.aud araziod.aud backstab.aud chaos2.aud shut_it.aud twinmix1.aud under3.aud vr2.aud"

# properties of 'Aftermath Disk' download
AFTERMATH_SRC_FILE="RATheAftermath.zip"
AFTERMATH_SRC_SIZE=316590873
AFTERMATH_ISO_FILE="RATheAftermath.iso"
AFTERMATH_AUDIO_ARCHIVE_FILE="scores.mix"
AFTERMATH_AUDIO_LIST="await.aud bog.aud float_v2.aud gloom.aud grndwire.aud rpt.aud search.aud traction.aud wastelnd.aud"

MASTER_ARCHIVE_FILE="MAIN.MIX"

# internal stuff
OFFICIAL_MOD_NAME="Red Alert"
TOTAL_SIZE=844952320
UTILS="$(dirname "$(readlink -f "$0")")/utilities/"
source "${UTILS}helper.sh" # import helper functions
DEST="$(get_destination_root)/Content/ra/v2/"
DEST_VIDEO="${DEST}movies"
DEST_AUDIO="${DEST}expand"
TEMP="/tmp/"

# make sure all necessary tools are available and display detailed install information if not
check_prerequisites

# display info text
show_infotext ${TEMP} ${BASE_GAME_FILES_ARCHIVE} ${AFTERMATH_EXPANSION_FILES_ARCHIVE} ${CNC_DESERT_TILESET_ARCHIVE} ${BASE_GAME_MUSIC_ARCHIVE} ${ALLIED_SRC_FILE} ${SOVIET_SRC_FILE} ${COUNTERSTRIKE_SRC_FILE} ${AFTERMATH_SRC_FILE}

echo -e "\nInstalling content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} ($((${TOTAL_SIZE}/1024/1024)) MiB)..."

# official remote content
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Base Game Files"           "${REMOTE_BASE_URL}" "${BASE_GAME_FILES_LIST_NAME}"           "${BASE_GAME_FILES_ARCHIVE}"           "${DEST}" "${TEMP}"
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Aftermath Expansion Files" "${REMOTE_BASE_URL}" "${AFTERMATH_EXPANSION_FILES_LIST_NAME}" "${AFTERMATH_EXPANSION_FILES_ARCHIVE}" "${DEST}" "${TEMP}"
import_content_from_remote "${OFFICIAL_MOD_NAME}" "C&C Desert Tileset"        "${REMOTE_BASE_URL}" "${CNC_DESERT_TILESET_LIST_NAME}"        "${CNC_DESERT_TILESET_ARCHIVE}"        "${DEST}" "${TEMP}"
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Base Game Music"           "${REMOTE_BASE_URL}" "${BASE_GAME_MUSIC_LIST_NAME}"           "${BASE_GAME_MUSIC_ARCHIVE}"           "${DEST}" "${TEMP}"

# local disk content
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Allied Campaign Briefings" "${LOCAL_BASE_URL}" "${ALLIED_SRC_FILE}"        "${ALLIED_SRC_SIZE}"        "${ALLIED_ISO_FILE}"        "${MASTER_ARCHIVE_FILE}" "${ALLIED_VIDEO_ARCHIVE_FILE}"        "${ALLIED_VIDEO_LIST}"        "${DEST_VIDEO}" "${TEMP}"
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Soviet Campaign Briefings" "${LOCAL_BASE_URL}" "${SOVIET_SRC_FILE}"        "${SOVIET_SRC_SIZE}"        "${SOVIET_ISO_FILE}"        "${MASTER_ARCHIVE_FILE}" "${SOVIET_VIDEO_ARCHIVE_FILE}"        "${SOVIET_VIDEO_LIST}"        "${DEST_VIDEO}" "${TEMP}" 
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Counterstrike Music"       "${LOCAL_BASE_URL}" "${COUNTERSTRIKE_SRC_FILE}" "${COUNTERSTRIKE_SRC_SIZE}" "${COUNTERSTRIKE_ISO_FILE}" "${MASTER_ARCHIVE_FILE}" "${COUNTERSTRIKE_AUDIO_ARCHIVE_FILE}" "${COUNTERSTRIKE_AUDIO_LIST}" "${DEST_AUDIO}" "${TEMP}"
import_content_from_local_disk "${OFFICIAL_MOD_NAME}" "Aftermath Music"           "${LOCAL_BASE_URL}" "${AFTERMATH_SRC_FILE}"     "${AFTERMATH_SRC_SIZE}"     "${AFTERMATH_ISO_FILE}"     "${MASTER_ARCHIVE_FILE}" "${AFTERMATH_AUDIO_ARCHIVE_FILE}"     "${AFTERMATH_AUDIO_LIST}"     "${DEST_AUDIO}" "${TEMP}"

echo -e "...installing content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} finished successfully!\n"
