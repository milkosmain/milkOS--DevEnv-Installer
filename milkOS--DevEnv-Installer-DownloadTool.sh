#!/bin/sh
clear

DEBUG=0
CLEANUP=0

DOWNLOAD_HOST_URL_ROOT="https://raw.githubusercontent.com/milkosmain/milkOS--DevEnv-Installer/main/"
DOWNLOAD_STORAGE_PATH="./.milkOS--DevEnv-Installer.d/"
PACKAGE_LIST=""


function milkOSDevEnvInstallerDownloadTool__header() {
  milkOSDevEnvInstallDownloader__header__terminal_width=$(stty size | awk '{print $2}')
  milkOSDevEnvInstallDownloader__header__terminal_width=$((${milkOSDevEnvInstallDownloader__header__terminal_width} - 2))
  milkOSDevEnvInstallDownloader__header_border_character_topleft="╭"
  milkOSDevEnvInstallDownloader__header_border_character_topright="╮"
  milkOSDevEnvInstallDownloader__header_border_character_bottomleft="╰"
  milkOSDevEnvInstallDownloader__header_border_character_bottomright="╯"
  milkOSDevEnvInstallDownloader__header_border_character_verticaledge="│"
  milkOSDevEnvInstallDownloader__header_border_character_horizontaledge="─"

  milkOSDevEnvInstallDownloader__header_border_horizontaledge=$(printf "%0.s${milkOSDevEnvInstallDownloader__header_border_character_horizontaledge}" $(seq 1 ${milkOSDevEnvInstallDownloader__header__terminal_width}))
  milkOSDevEnvInstallDownloader__header_border_top=$(printf "%s%s%s" "${milkOSDevEnvInstallDownloader__header_border_character_topleft}" "${milkOSDevEnvInstallDownloader__header_border_horizontaledge}" "${milkOSDevEnvInstallDownloader__header_border_character_topright}")

    milkOSDevEnvInstallDownloader__header_messages=""
  for argument_message in "$@"; do
    milkOSDevEnvInstallDownloader__header_message_width=${#argument_message}
    milkOSDevEnvInstallDownloader__header_border_middle_message_padding_width=$(( $(( ${milkOSDevEnvInstallDownloader__header__terminal_width} - ${milkOSDevEnvInstallDownloader__header_message_width} )) / 2 ))
    milkOSDevEnvInstallDownloader__header_border_middle_message_padding=$(printf "%0.s " $(seq 1 $(( $(( ${milkOSDevEnvInstallDownloader__header__terminal_width} - ${milkOSDevEnvInstallDownloader__header_message_width} )) / 2 )) ))
    milkOSDevEnvInstallDownloader__header_border_middle_message_padding_right=${milkOSDevEnvInstallDownloader__header_border_middle_message_padding}
    milkOSDevEnvInstallDownloader__header_border_middle_message_padding_left=${milkOSDevEnvInstallDownloader__header_border_middle_message_padding}
    if [ $(( $(( ${milkOSDevEnvInstallDownloader__header__terminal_width} - ${milkOSDevEnvInstallDownloader__header_message_width} )) % 2 )) -eq 1 ]; then
      milkOSDevEnvInstallDownloader__header_border_middle_message_padding_right="${milkOSDevEnvInstallDownloader__header_border_middle_message_padding_right} "
    fi
    milkOSDevEnvInstallDownloader__header_border_middle=$(printf "%s%s%s" "${milkOSDevEnvInstallDownloader__header_border_character_verticaledge}" "${milkOSDevEnvInstallDownloader__header_border_middle_message_padding_left}" "${argument_message}" "${milkOSDevEnvInstallDownloader__header_border_middle_message_padding_right}" "${milkOSDevEnvInstallDownloader__header_border_character_verticaledge}")
    milkOSDevEnvInstallDownloader__header_messages="${milkOSDevEnvInstallDownloader__header_messages}${milkOSDevEnvInstallDownloader__header_border_middle}\n"
  done

  milkOSDevEnvInstallDownloader__header_border_bottom=$(printf "%s%s%s" "${milkOSDevEnvInstallDownloader__header_border_character_bottomleft}" "${milkOSDevEnvInstallDownloader__header_border_horizontaledge}" "${milkOSDevEnvInstallDownloader__header_border_character_bottomright}")

  echo -en "${milkOSDevEnvInstallDownloader__header_border_top}\n"
  echo -en "${milkOSDevEnvInstallDownloader__header_messages}"
  echo -en "${milkOSDevEnvInstallDownloader__header_border_bottom}\n"
}

function milkOSDevEnvInstallerDownloadTool__createDownloadStorageDir() {
  echo -en "Creating download storage...\n\n"
  if [ -d "$DOWNLOAD_STORAGE_PATH" ]; then
    echo -en "Download storage already exists!\n"
    echo -en "Skipping creation.\n"
  else
    mkdir "$DOWNLOAD_STORAGE_PATH"
    if [ ! -d "$DOWNLOAD_STORAGE_PATH" ]; then
      echo -en "Unable to create download storage!\n"
      echo -en "Try running this script as root.\n"
      exit 1
    else
      echo -en "Created download storage\n"
    fi
  fi
  echo -en "\n\n"

}

function milkOSDevEnvInstallerDownloadTool__download_milkOSDevEnvInstaller() {
  echo -en "Downloading 'milkOS--DevEnv-Installer'...\n\n"

}

function milkOSDevEnvInstallerDownloadTool__main() {
  DEV_ENV_INSTALL_DOWNLOADER__COMMAND=$(cat ~/.ash_history | grep '/bin/sh' | tail -1)
  DEV_ENV_INSTALL_DOWNLOADER__URL_ROOT=$(echo "$DEV_ENV_INSTALL_DOWNLOADER__COMMAND" | sed -n -e "s/^.*-O- //p; s/\/milkosmain.*//p" | tail -1)

  if [ "$0" = "-dev" ]; then
    DEBUG="1"
    DOWNLOAD_HOST_URL_ROOT=$DEV_ENV_INSTALL_DOWNLOADER__URL_ROOT
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
    rm -rf "${DOWNLOAD_STORAGE_PATH}"
    rm -rf ./milkOS--DevEnv-Installer-Download.sh
  fi
}

milkOSDevEnvInstallerDownloadTool__main $@
