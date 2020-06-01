export SUB="\033[1;30m"
export RED="\033[1;91m"
export GREEN="\033[1;92m"
export BLUE="\033[1;94m"
export ON_BLACK="\033[40m"
export NORM="\033[0m"
export CLEANUP_ANSWER
export DOWNLOAD_ANSWER

get_destination_root() {
	# Returns the correct destination path for the current system depending on XDG_CONFIG_HOME.
	if [[ -z "${XDG_CONFIG_HOME}" ]]; then
		echo "$HOME/.config/openra"
	else
		echo "$HOME/.openra"
	fi
}

check_prerequisites() {
	for TOOL in wget 7z wine; do
		if ! which $TOOL >/dev/null; then
			if [ "${TOOL}" == "7z" ]; then
				PACKAGES="p7zip p7zip-full p7zip-rar"
			else
				PACKAGES=${TOOL}
			fi

			echo -e "Necessary tool '${TOOL}' not found. Install using the following command:\n\n\t${GREEN}sudo apt update && sudo apt install ${PACKAGES}${NORM}"
			exit 1
		fi
	done
}

show_infotext() {
	if [[ -z "${1}" ]] ; then
		echo -e "ERROR: Parameters missing!\n\nUseage: show_infotext(TEMP_DIR  [ FILE1  FILE2 ... FILEn ] )" >&2
		exit 1
	fi

	local DEST="${1}"
	shift
	local MISSING=0
	local DUMMY=""
	local COUNT=$#
	local TEXT="${RED}${ON_BLACK}ATTENTION${NORM}: You might want to provide the files "

	while [[ "$#" -gt 0 ]]; do
		if [[ "$#" -eq 1 ]]; then
			if [[ ${MISSING} -ge 1 ]]; then
				DUMMY=" and "
			else
				DUMMY=""
			fi
		elif [[ "$COUNT" != "$#" ]]; then
			if [[ ${MISSING} -ge 1 ]]; then
				DUMMY=", "
			else
				DUMMY=""
			fi
		fi

		if [[ ! -e "${DEST}${1}" ]]; then
			TEXT="${TEXT}${DUMMY}'${BLUE}${ON_BLACK}${1}${NORM}'"
			MISSING=$((MISSING+1))
		fi
		shift
	done

	# only display text if one or more files are missing
	if [[ ${MISSING} -gt 0 ]]; then
		echo -e -n "${TEXT} - or at least some of them - at '${BLUE}${ON_BLACK}${DEST}${NORM}' NOW. This would speedup the installation process. Press any key to continue."
		read -n1
		echo
	fi
}

download() {
	# Downloads a resource from url ${1} using 'wget' and stores it as file ${2}.
	if [[ -z "${1}" ]] || [[ -z "${2}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: download(SOURCE_URL, DESTINATION_FILE)" >&2
		exit 1
	fi

	echo -e "downloading files to '${2}'...${SUB}"
	wget -q "${1}" -O "${2}"
	local RETVAL=$?
	echo -n -e "${NORM}"
	if [ $RETVAL -eq 0 ]; then
		echo -e "...download successfully finished.\n"
	fi

	return $RETVAL
}

wait_for_file_or_download() {
	# Waits until file ${2} exists (i.e. is provided manually) or lets choose to download from ${1} using pre defined size ${3} to verify.
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: wait_for_file_or_download(SOURCE_URL, DESTINATION_FILE, EXPECTED_SIZE  [ ANSWER={d|l} ])" >&2
		exit 1
	fi

	while [ ! -e "${2}" ] || [ $(du -b "${2}" | cut -f 1) -lt ${3} ]; do
		# check if answer is provided by parameter or global variable
		if [[ ! -z "${4}" ]]; then
			local CHOICE="${4}"
		else
			local CHOICE="${DOWNLOAD_ANSWER}"
		fi

		# if no pre defined answer is found, ask user
		if [[ -z "${CHOICE}" ]]; then
			read -n1 -r -p "Required source file '${2}' NOT FOUND or DAMAGED! You may copy it there yourself and retry or let this script download it ($((${3}/1024/1024)) MiB) for you. Press any key to quit. [R]etry / [D]ownload / Download al[l]: " CHOICE;
			echo
		fi

		if [ "${CHOICE,,}" == "r" ]; then
			echo "retrying..."
			continue
		fi

		if [ "${CHOICE,,}" == "d" ] || [ "${CHOICE,,}" == "l" ]; then
			download ${1} ${2}
		fi

		if [ "${CHOICE,,}" == "l" ]; then
			DOWNLOAD_ANSWER="d"
		fi

		echo "exiting..."
		exit 2
	done
}

extract_using_7zip() {
	# Extracts a source file ${2} to destination ${3} using optional file mask ${4} to select a desired subset of files utilizing 7zip. This skips files that are already present at destination. ${1} = true preserves directory structure, else not
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: extract_using_7zip(PRESERVE_STRUCTURE  SOURCE_FILE  DESTINATION_DIR  FILE_MASK)" >&2
		exit 1
	fi

	mkdir -p "${3}"

	echo -e "unzipping '${4}' from '${2}' to '${3}'...${SUB}"
	# x = extract with directory structure; e = extract without directory structure; -r = recurse all subdirectories; -aos = skip files that already exist on destination; -y = assume 'yes' on all questions; -o = output directory
	if [[ "${1}" == true ]]; then
		7z x -r -aos -y "${2}" -o"${3}" "${4}" > /dev/null
	else
		7z e -r -aos -y "${2}" -o"${3}" "${4}" > /dev/null
	fi
	echo -e "${NORM}...unzipping successfully finished.\n"
}

cleanup() {
	# Asks to clean up temporarily downloaded, but not longer used file ${1}.
	if [[ -z "${1}" ]] || [[ ( ! -z "${2}" && "${2,,}" != "y" && "${2,,}" != "n" && "${2,,}" != "s" && "${2,,}" != "o") ]]; then
		echo -e "ERROR: Parameters missing or invalid!\n\nUseage: cleanup(DIR  [ ANSWER={Y|n|s|o} ])" >&2
		exit 1
	fi

	# check if answer is provided by parameter or global variable
	if [[ ! -z "${2}" ]]; then
		local CHOICE="${2}"
	else
		local CHOICE="${CLEANUP_ANSWER}"
	fi

	# if no answer is found, ask user
	if [[ -z "${CHOICE}" ]]; then
		read -n1 -r -p "Cleanup unnecessary source files? [Y]es / [N]o / Ye[s] to all / N[o] to all: " CHOICE;
		echo
	fi

	if [ "${CHOICE,,}" == "y" ] || [ "${CHOICE,,}" == "s" ]; then
		echo -e "cleaning up '${1}'...${SUB}"
		rm -f "${1}"
		echo -e "${NORM}...cleanup finished.\n"
	fi

	if [ "${CHOICE,,}" == "s" ]; then
		CLEANUP_ANSWER="y"
	elif [ "${CHOICE,,}" == "o" ]; then
		CLEANUP_ANSWER="n"
	fi
}

expand_mix_archive() {
	# Unpacks single resource files (*.vqa, *.aud) listed in ${2} from compressed resource archive (*.mix) ${1} to destination ${3}.
	local MAXRETRIES=3

	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: expand_mix_archive(SOURCE_FILE, FILELIST, DESTINATION_DIR)" >&2
		exit 1
	fi

	echo "expanding resources from '${1}' to '${3}'..."

	mkdir -p "${3}"
	for FILE in ${2}; do

		echo -e -n "\tprocessing $FILE..."
		if [ -e "${3}/${FILE}" ]; then
			echo "already exists, skipping."
		else
			local RETRIES=0
			while [ ! -e "${3}/${FILE}" ] && [ ${RETRIES} -lt ${MAXRETRIES} ]; do
				RETRIES=$((RETRIES + 1))
				# TODO: try to find a non-wine solution, i.e. using    dd <file> bs=1 skip=x count=n    and offsets to copy partial content from *.mix
				wine start /min /d "${3}" /unix ${UTILS}/xcc_mix_clt.exe "${1}" "$FILE" /nogui > /dev/null

				# wine has some weird kind of timing problem leading to (mostly large?) files not been copied (clipboard?) to destination in time, so sleep and retry: 0022:err:clipboard:convert_selection Timed out waiting for SelectionNotify event
				sleep 2
			done

			if [ ! -e "${3}/${FILE}" ] && [ ${RETRIES} -eq ${MAXRETRIES} ]; then
				echo "FAILED after ${RETRIES} retries! Try to start script again."
				exit 3
			else
				echo "done."
			fi
		fi
	done

	echo -e "...expanding resources finished.\n"
}

extract_media() {
	# Extracts media ${2} from main archive ${1} using temporary dir ${3} to destination ${4} as filename ${5}. Omitting optional parameter ${5} skips audio extraction at all.
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]] || [[ -z "${4}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: extract_media(MAIN_ARCHIVE  FILE_MASK  TEMP_DIR  DESTINATION_FILE )" >&2
		exit 1
	fi

	# check if file is missing at destination
	if [ ! -e "${4}" ]; then
		echo "extracting media '${2}' to '${4}'..."
		rm -f "${3}${2}" # make sure no temporary file is left from previous installations
		extract_using_7zip false "${1}" "${3}" "${2}"

		# lowercase file names!!!
		mkdir -p $(dirname "${4}")
		echo "...moving '${3}${2}' to '${4}...'"
		mv -f "${3}${2}" "${4}"
		echo "...extracting media finished."
	fi
}

download_from_official_mirror() {
	# Downloads official game content from a random official server using the mirror list at ${1} dumping to ${2} and finally download to ${3}.
	local RETRIES=0
	local MAXRETRIES=10

	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: download_from_official_mirror(MIRROR_LIST_URL  MIRROR_LIST_DESTINATION_FILE  RESOURCE_ARCHIVE_FILE)" >&2
		exit 1
	fi

	# exit if resource file is already there
	if [ -e "${3}" ]; then
		return 0
	fi

	download "${1}" "${2}"

	while [ -e "${2}" ] && [ ! -e "${3}" ] && [ ${RETRIES} -lt ${MAXRETRIES} ]; do
		RETRIES=$((RETRIES + 1))

		# pick a mirror randomly
		MIRROR=$(sort -R "${2}" | head -n 1)

		echo "#${RETRIES}: trying official mirror '$MIRROR'..."
		set +e
		download "$MIRROR" "${3}"
		local RESULT=$?
		set -e

		if [ $RESULT -ne 0 ]; then
			echo -e "...failed with error ${RESULT}.\n" >&2
			rm -f "${3}"
		fi
	done

	rm -f "${2}"

	if [ ! -e "${3}" ] && [ ${RETRIES} -eq ${MAXRETRIES} ]; then
		echo "Downloading FAILED! No official mirror available! Check your network connection!" >&2
		exit 4
	fi
}

import_content_from_remote() {
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]] || [[ -z "${4}" ]] || [[ -z "${5}" ]] || [[ -z "${6}" ]] || [[ -z "${7}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: import_content_from_remote(MOD_NAME  CONTENT_NAME  REMOTE_BASE_URL  MIRROR_LIST_FILE  RESOURCE_ARCHIVE_FILE  DESTINATION_DIR  TEMP_DIR)" >&2
		exit 1
	fi

	echo -e "\n====== processing ${GREEN}${ON_BLACK} ${1} ${NORM} remote content: ${RED}${ON_BLACK} ${2} ${NORM} ======\n"

	# download source from official random mirror
	download_from_official_mirror "${3}${4}" "${7}${4}" "${7}${5}"

	# extract audio archive from source
	extract_using_7zip true "${7}${5}" "${6}"

	cleanup "${7}${5}"
}

import_content_from_local_disk() {
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]] || [[ -z "${4}" ]] || [[ -z "${5}" ]] || [[ -z "${6}" ]] || [[ -z "${7}" ]] || [[ -z "${9}" ]] || [[ -z "${10}" ]] || [[ -z "${11}" ]] || [[ ( -z "${12}" && ! -z "${13}" ) || ( ! -z "${12}" && -z "${13}" ) ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: import_content_from_local_disk(MOD_NAME  CONTENT_NAME  LOCAL_BASE_URL  DESTINATION_FILE  EXPECTED_SIZE  ISO_FILE_NAME  MAIN_ARCHIVE_FILE  [ SUB_ARCHIVE_FILE ]  MEDIA_LIST MEDIA_DESTINATION_DIR  TEMP_DIR  [ AUDIO_ARCHIVE_FILE  AUDIO_DESTINATION_FILE ] )" >&2
		exit 1
	fi

	echo -e "\n====== processing ${GREEN}${ON_BLACK} ${1} ${NORM} local content: ${RED}${ON_BLACK} ${2} ${NORM} ======\n"

	wait_for_file_or_download "${3}${4}" "${11}${4}" "${5}"

	# extract desired file(s) from download (*.zip, *.rar, *.exe)
	extract_using_7zip false "${11}${4}" "${11}" "${6}"

	# extract master archive (*.mix) from iso
	rm -f "${11}${7}" # make sure no temporary file is left from previous installations
	extract_using_7zip false "${11}${6}" "${11}" "${7}"
	if [ -z "${12}" ] || [ -z "${13}" ]; then # will iso not be required later
		rm -f "${11}${6}" # delete previous iso
	fi

	local MEDIA_ARCHIVE="${7}" # if no sub archive exists, this is the media archive

	# if sub archives (*.mix) exists in master archive (*.mix)
	if [[ ! -z "${8}" ]]; then
		# extract sub archive from main archive
		rm -f "${11}${8}" # make sure no temporary file is left from previous installations
		expand_mix_archive "${11}${7}" "${8}" "${11}"
		rm -f "${11}${7}" # delete main archive
		MEDIA_ARCHIVE="${8}" # the sub archive is the media archive
	fi

	# extract media from media archive
	expand_mix_archive "${11}${MEDIA_ARCHIVE}" "${9,,}" "${10}"
	rm -f "${11}${MEDIA_ARCHIVE}"

	# extract audio archive from iso if required
	if [ ! -z "${12}" ] && [ ! -z "${13}" ]; then
		extract_media "${11}${6}" "${12}" "${11}" "${13}"
	fi
	rm -f "${11}${6}"

	cleanup "${11}${4}"
}

import_content_from_local_archive() {
	if [[ -z "${1}" ]] || [[ -z "${2}" ]] || [[ -z "${3}" ]] || [[ -z "${4}" ]] || [[ -z "${5}" ]] || [[ -z "${6}" ]] || [[ -z "${7}" ]] || [[ -z "${8}" ]]; then
		echo -e "ERROR: Parameters missing!\n\nUseage: import_content_from_local_archive(MOD_NAME  CONTENT_NAME  LOCAL_BASE_URL  SOURCE_DIR  SOURCE_FILE  EXPECTED_SIZE  PRESERVE_STRUCTURE  DESTINATION_DIR [ FILE_MASK ])" >&2
		exit 1
	fi

	echo -e "\n====== processing ${GREEN}${ON_BLACK} ${OFFICIAL_MOD_NAME} ${NORM} local archive content: ${RED}${ON_BLACK} ${2} ${NORM} ======\n"

	# download file, if not present
	if [ ! -e "${4}${5}" ]; then
		wait_for_file_or_download "${3}${5}" "${4}${5}" "${6}"
	fi

	# extract local archive
	extract_using_7zip ${7} "${4}${5}" "${8}" "${9}"

	cleanup "${4}${5}"
}
