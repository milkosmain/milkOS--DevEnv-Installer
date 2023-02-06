#!/bin/sh
clear

DEBUG=0
CLEANUP=0

MILKOS_DOWNLOAD_HOST_URL_ROOT="https://raw.githubusercontent.com/milkosmain/milkOS--DevEnv-Installer/main/"
THIS_SCRIPT_FILENAME="milkOS--DevEnv-Installer-DownloadTool.sh"
MILKOS_DOWNLOAD_STORAGE_PATH="./.milkOS--DevEnv-Installer.d/"
PACKAGE_LIST=""


function milkOSDevEnvInstallerDownloadTool__header() {
  milkOSDevEnvInstallerDownloadTool__header__terminal_width=$(stty size | awk '{print $2}')
  milkOSDevEnvInstallerDownloadTool__header__terminal_width=$((${milkOSDevEnvInstallerDownloadTool__header__terminal_width} - 2))
  milkOSDevEnvInstallerDownloadTool__header_border_character_topleft="╭"
  milkOSDevEnvInstallerDownloadTool__header_border_character_topright="╮"
  milkOSDevEnvInstallerDownloadTool__header_border_character_bottomleft="╰"
  milkOSDevEnvInstallerDownloadTool__header_border_character_bottomright="╯"
  milkOSDevEnvInstallerDownloadTool__header_border_character_verticaledge="│"
  milkOSDevEnvInstallerDownloadTool__header_border_character_horizontaledge="─"

  milkOSDevEnvInstallerDownloadTool__header_border_horizontaledge=$(printf "%0.s${milkOSDevEnvInstallerDownloadTool__header_border_character_horizontaledge}" $(seq 1 ${milkOSDevEnvInstallerDownloadTool__header__terminal_width}))
  milkOSDevEnvInstallerDownloadTool__header_border_top=$(printf "%s%s%s" "${milkOSDevEnvInstallerDownloadTool__header_border_character_topleft}" "${milkOSDevEnvInstallerDownloadTool__header_border_horizontaledge}" "${milkOSDevEnvInstallerDownloadTool__header_border_character_topright}")

    milkOSDevEnvInstallerDownloadTool__header_messages=""
  for argument_message in "$@"; do
    milkOSDevEnvInstallerDownloadTool__header_message_width=${#argument_message}
    milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_width=$(( $(( ${milkOSDevEnvInstallerDownloadTool__header__terminal_width} - ${milkOSDevEnvInstallerDownloadTool__header_message_width} )) / 2 ))
    milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding=$(printf "%0.s " $(seq 1 $(( $(( ${milkOSDevEnvInstallerDownloadTool__header__terminal_width} - ${milkOSDevEnvInstallerDownloadTool__header_message_width} )) / 2 )) ))
    milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_right=${milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding}
    milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_left=${milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding}
    if [ $(( $(( ${milkOSDevEnvInstallerDownloadTool__header__terminal_width} - ${milkOSDevEnvInstallerDownloadTool__header_message_width} )) % 2 )) -eq 1 ]; then
      milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_right="${milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_right} "
    fi
    milkOSDevEnvInstallerDownloadTool__header_border_middle=$(printf "%s%s%s" "${milkOSDevEnvInstallerDownloadTool__header_border_character_verticaledge}" "${milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_left}" "${argument_message}" "${milkOSDevEnvInstallerDownloadTool__header_border_middle_message_padding_right}" "${milkOSDevEnvInstallerDownloadTool__header_border_character_verticaledge}")
    milkOSDevEnvInstallerDownloadTool__header_messages="${milkOSDevEnvInstallerDownloadTool__header_messages}${milkOSDevEnvInstallerDownloadTool__header_border_middle}\n"
  done

  milkOSDevEnvInstallerDownloadTool__header_border_bottom=$(printf "%s%s%s" "${milkOSDevEnvInstallerDownloadTool__header_border_character_bottomleft}" "${milkOSDevEnvInstallerDownloadTool__header_border_horizontaledge}" "${milkOSDevEnvInstallerDownloadTool__header_border_character_bottomright}")

  echo -en "${milkOSDevEnvInstallerDownloadTool__header_border_top}\n"
  echo -en "${milkOSDevEnvInstallerDownloadTool__header_messages}"
  echo -en "${milkOSDevEnvInstallerDownloadTool__header_border_bottom}\n"
}

function milkOSDevEnvInstallerDownloadTool__createDownloadStorageDir() {
  echo -en "Creating download storage...\n\n"
  if [ -d "$MILKOS_DOWNLOAD_STORAGE_PATH" ]; then
    echo -en "Download storage already exists!\n"
    echo -en "Skipping creation.\n"
  else
    mkdir "$MILKOS_DOWNLOAD_STORAGE_PATH"
    if [ ! -d "$MILKOS_DOWNLOAD_STORAGE_PATH" ]; then
      echo -en "Unable to create download storage!\n"
      echo -en "Try running this script as root.\n"
      exit 1
    else
      echo -en "Created download storage\n"
    fi
  fi
  echo -en "\n\n"

}

function milkOSDevEnvInstallerDownloadTool__downloadResource() {
  local resourceName="$1"
  echo -en "Downloading '${resourceName}'...\n\n"
  echo -en "From: ${MILKOS_DOWNLOAD_HOST_URL_ROOT}/milkosmain/milkOS--DevEnv-Installer/${resourceName}\n\n"
  
  echo -en "${MILKOS_DOWNLOAD_STORAGE_PATH}${resourceName}\n\n"
  
  downloadResult=$(wget -q "${MILKOS_DOWNLOAD_HOST_URL_ROOT}/milkosmain/milkOS--DevEnv-Installer/main/${resourceName}" -P "${MILKOS_DOWNLOAD_STORAGE_PATH}" -O "${MILKOS_DOWNLOAD_STORAGE_PATH}${resourceName}" )

  echo -en "${downloadResult}"

  MILKOS_DOWNLOAD_STORAGE_CONTENTS=$(ls "./${MILKOS_DOWNLOAD_STORAGE_PATH}")

  echo -en "${MILKOS_DOWNLOAD_STORAGE_CONTENTS}\n"

  echo -en "\n${MILKOS_DOWNLOAD_STORAGE_PATH}${resourceName}\n"


  if [ ! -f "${MILKOS_DOWNLOAD_STORAGE_PATH}${resourceName}" ]; then
    echo -en "Unable to download resource ${resourceName}!\n"
    echo -en "Exiting.\n"
    exit 1
  else
    echo -en "Downloaded '${resourceName}'\n"
  fi
}

function milkOSDevEnvInstallerDownloadTool__main() {
  milkOSDevEnvInstallerDownloadTool__command=$(cat ~/.ash_history | grep '/bin/sh' | tail -1)
  milkOSDevEnvInstallerDownloadTool__command__URLRoot=$(echo "$milkOSDevEnvInstallerDownloadTool__command" | sed -n -e "s/^.*-O- //p; s/\/milkosmain.*//p" | tail -1)
  MILKOS_DOWNLOAD_HOST_URL_ROOT=$milkOSDevEnvInstallerDownloadTool__command__URLRoot

  if [ "$0" = "-debug" ]; then
    DEBUG="1"
  fi

  if [ "$1" = "-cleanup" ]; then
    CLEANUP="1"
  fi

  echo -en "\e[48;2;51;102;255m"
  milkOSDevEnvInstallerDownloadTool__header "milkOS--DevEnv-Installer" "" "Download Tool" "" "v0.2.3"
  echo -en "\e[0m"

  if [[ "$DEBUG" = "1" ]]; then
    echo -en "\e[48;2;254;154;18m"
    echo -en "\e[38;2;0;0;0m"
    milkOSDevEnvInstallerDownloadTool__header "DEBUG MODE"
    echo -en "\e[0m"
  fi

  milkOSDevEnvInstallerDownloadTool__createDownloadStorageDir

  if [[ "$CLEANUP" = "1" ]]; then
    echo -en "Cleaning up...\n"
    rm -rf "${MILKOS_DOWNLOAD_STORAGE_PATH}"
    if [ -d "$MILKOS_DOWNLOAD_STORAGE_PATH" ]; then
      echo -en "Could not clean download storage!\n"
    else
      echo -en "Cleaned download storage!\n"
    fi
    rm -rf "./${THIS_SCRIPT_FILENAME}"
    if [ -f "./${THIS_SCRIPT_FILENAME}" ]; then
      echo -en "Could not clean script file!\n"
    else
      echo -en "Cleaned script file!\n"
    fi

  fi

  milkOSDevEnvInstallerDownloadTool__downloadResource "milkOS--DevEnv-Installer.sh"
}

milkOSDevEnvInstallerDownloadTool__main $@