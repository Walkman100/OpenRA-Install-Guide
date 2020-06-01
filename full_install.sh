#!/usr/bin/env bash
set -e

DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}/full_install_d2k.sh"
source "${DIR}/full_install_cnc.sh"
source "${DIR}/full_install_ra.sh"
