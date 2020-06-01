#!/usr/bin/env bash
# if download links are broken, see here: https://gruntmods.com/cutscenes-and-extra-content/
set -e

# official remote sources
REMOTE_BASE_URL="https://www.openra.net/packages/"
BASE_GAME_FILES_LIST_NAME="d2k-base-mirrors.txt"
BASE_GAME_FILES_ARCHIVE="d2k-base.zip"
PATCH_FILES_LIST_NAME="d2k-patch106-mirrors.txt"
PATCH_FILES_ARCHIVE="d2k-patch106.zip"

# local archive source
AUDIO_ARCHIVE_BASE_URL="https://github.com/Walkman100/OpenRA-Install-Guide/raw/master/"
AUDIO_ARCHIVE_FILE="d2k-music.zip"
AUDIO_ARCHIVE_SIZE="40737522"
AUDIO_ARCHIVE_DIR="$(dirname "$(readlink -f "$0")")/"

# base url for downloading local sources
GRUNTMOD_BASE_URL="https://gruntmods.com/download/909/"
GRUNTMOD_SRC_FILE="Dune_2000_Gruntmods_Edition_Cutscenes.exe"
GRUNTMOD_SRC_SIZE=429501866
GRUNTMOD_MASK="Dune 2000/movies"

# internal stuff
OFFICIAL_MOD_NAME="Dune 2000"
TOTAL_SIZE=584853637
UTILS="$(dirname "$(readlink -f "$0")")/utilities/"
source "${UTILS}helper.sh" # import helper functions
DEST="$(get_destination_root)/Content/d2k/"
DEST_AUDIO="${DEST}v2"
DEST_VIDEO="${DEST}v2/Movies"
TEMP="/tmp/"

# make sure all necessary tools are available and display detailed install information if not
check_prerequisites

# display info text
show_infotext ${TEMP} ${BASE_GAME_FILES_ARCHIVE} ${PATCH_FILES_ARCHIVE} ${GRUNTMOD_SRC_FILE}

echo -e "\nInstalling content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} ($((${TOTAL_SIZE}/1024/1024)) MiB)..."

# official remote content
import_content_from_remote "${OFFICIAL_MOD_NAME}" "Base Game Files"    "${REMOTE_BASE_URL}" "${BASE_GAME_FILES_LIST_NAME}" "${BASE_GAME_FILES_ARCHIVE}" "${DEST}" "${TEMP}"
import_content_from_remote "${OFFICIAL_MOD_NAME}" "1.06 Patch Content" "${REMOTE_BASE_URL}" "${PATCH_FILES_LIST_NAME}"     "${PATCH_FILES_ARCHIVE}"     "${DEST}" "${TEMP}"

# local archive content
import_content_from_local_archive "${OFFICIAL_MOD_NAME}" "Game Music"         "${AUDIO_ARCHIVE_BASE_URL}" "${AUDIO_ARCHIVE_DIR}" "${AUDIO_ARCHIVE_FILE}" "${AUDIO_ARCHIVE_SIZE}" true  "${DEST_AUDIO}"
import_content_from_local_archive "${OFFICIAL_MOD_NAME}" "Campaign Briefings" "${GRUNTMOD_BASE_URL}"      "${TEMP}"              "${GRUNTMOD_SRC_FILE}"  "${GRUNTMOD_SRC_SIZE}"  false "${DEST_VIDEO}" "${GRUNTMOD_MASK}"

echo -e "...installing content for ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} finished successfully!\n"
