#!/bin/sh

. ./resources/vars
# . ./resources/milkOSDevEnvInstaller/controllers/controller__packageManagement
. ./resources/milkOSDevEnvInstaller/controllers/controller__test


. ./resources/milkOSDevEnvInstaller/tools/devenvinstaller__printlog
. ./resources/milkOSSystem/printy




style_fg_flatRed="\e[38;2;225;0;40m"
style_fg_flatGreen="\e[38;2;50;200;50m"
style_fg_flatYellow="\e[38;2;225;225;0m"
style_fg_flatBlue="\e[38;2;70;100;230m"

style_italic="\e[3m"
style_bold="\e[1m"
style_underline="\e[4m"
style_reset="\e[0m"

function ruline() {
  local lineCount=0
  local rollupEscapeCode="\e[1A"
  local clearLineEscapeCode="\e[2K"
  local returnText=""

  if [[ $1 ]] && [[ -n $1 ]]; then
    lineCount="$1"
  fi

  for i in $(seq 1 $lineCount); do
    returnText=$(echo -en "${returnText}${clearLineEscapeCode}${rollupEscapeCode}" )
  done

  echo -en "$returnText"
}

warningIcon=""
warningIcon=$(cat << "EOF"

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠞⣋⣙⠳⢆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⢃⣾⣿⣿⣷⡌⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⢡⣾⣿⠃⠘⢿⣷⡌⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡞⢡⣿⡿⠃⠀⠀⠈⢿⣿⣆⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⣰⣿⡿⠁⠀⠀⠀⠀⠈⢻⣿⣆⠹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡏⣰⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⢿⣿⣇⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡏⣰⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣆⠹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⣰⣿⡟⠁⠀⠀⠀⣠⣤⣤⣄⡀⠀⠀⠀⢻⣿⣧⠙⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃⣼⣿⡟⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⡆⠀⠀⠀⠹⣿⣧⡘⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⢃⣼⣿⠏⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠹⣿⣷⡌⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⢡⣾⣿⠃⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠘⣿⣷⡌⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡞⢡⣿⡿⠃⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⢿⣿⡄⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⢰⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣆⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⣰⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣧⠹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⣼⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣧⡙⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢃⣼⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣷⡘⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡼⢃⣾⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣷⡌⢷⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⡞⢡⣾⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⡌⢳⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⡞⣠⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣆⢻⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢠⠏⣰⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣆⠹⣆⠀⠀⠀⠀
⠀⠀⠀⢰⡏⢸⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣇⠹⡆⠀⠀⠀
⠀⠀⣰⠏⣰⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣆⠹⣆⠀⠀
⠀⣰⠏⣰⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣧⡙⣆⠀
⣸⢃⣼⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣧⡘⣧
⣿⠸⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⠇⣸
⠘⠷⣌⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣉⣩⡴⠀
⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀

EOF
)

isCorrectDistro=0
isVirtualMachine=0
virtualizationEngineName="unknown"
machineUID=""
proceedInstallDevEnvSystemPackages=0





function checkDistro() {
  local currentDistro=""
  local expectedDistro="Alpine Linux"
  local currentDistroMatch
  local statusMessage=""

  printy @style bg@flatblue fg@bold fg@flatyellow @continue
  echo -en "\n\nChecking if distro is $expectedDistro...\n\n"
  printy @reset
  sleep 1s

  local style_error="${style_reset}${style_bold}${style_fg_flatRed}"
  local style_success="${style_reset}${style_bold}${style_fg_flatGreen}"
  local style_info="${style_italic}${style_fg_flatBlue}"
  if [ ! -f "/etc/os-release" ]; then
    statusMessage="${style_error}Error: checkDistro(): Failed to find /etc/os-release file, please ensure you are running ${style_info}${expectedDistro}${style_error}!"
  elif [ -f "/etc/os-release" ]; then
    currentDistro=$(cat "/etc/os-release" | grep "^NAME")
    if [[ -z "$currentDistro" ]]; then
      statusMessage="${style_error}Error: checkDistro(): Failed to find distro name in /etc/os-release, please ensure you are running ${style_info}${expectedDistro}${style_error}!"
    elif [[ ! -z "$currentDistro" ]]; then
      currentDistro=$(echo $currentDistro | cut -d= -f2 | tr -d '"')
      currentDistroMatch=$(echo $currentDistro | grep "$expectedDistro")
      if [[ -z "$currentDistroMatch" ]]; then
        statusMessage="${style_error}Error: checkDistro(): Running system distro, ${style_info}${currentDistro}${style_error}, does not match required distro, ${style_info}${expectedDistro}${style_error}\nYou must use ${style_info}${expectedDistro}${style_error}!"
      else
        statusMessage="${style_success}Success: Running system distro, ${style_info}${currentDistro}${style_success}, matches required distro, ${style_info}$expectedDistro${style_success}!"
      fi
    fi
  fi

  
  if [[ ! -z "$currentDistroMatch" ]]; then
    echo -en "\e[1m\e[38;2;42;210;0m"
    echo -en "\t$statusMessage"
    echo -en "\e[0m"
  elif [[ -z "$currentDistroMatch" ]]; then
    echo -en "${style_error}$warningIcon"
    echo -en "\n$statusMessage"
    echo -en "${style_reset}"
    exit 0
  fi
}

function prompt_isVirtualMachine() {
  if [[ $1 ]] && [[ $1 = "bad-option" ]]; then
    printy @style fg@flatred @continue
    echo -en "\n\nYou have entered an invalid option! Please try again.\n"
    printy @reset
  else
    echo -en "\n\n\n"
  fi

  printy @style bg@flatblue fg@bold fg@flatyellow @continue
  echo -en "Is this a Virtual Machine?\n"
  printy @reset
  echo -en "\n"
  echo -en "\tEnter option (Y/n):"
  read -r input_isVirtualMachine

  case $input_isVirtualMachine in
    y|Y) continue ;;
    n|N) continue ;;
    *)
      echo -en "$(ruline 6)"
      prompt_isVirtualMachine "bad-option" 
      return 0
    ;;
  esac

  echo -en "$(ruline 1)"
  echo -en "\tYou have entered "
  printy @style fg@flatyellow @continue
  echo -en "$input_isVirtualMachine"
  printy @reset
  echo -en ", is that correct?\n"
  echo -en "\n"
  echo -en "\tEnter option (y/N):"
  read -r input_verify_isVirtualMachine
  case $input_verify_isVirtualMachine in
    y|Y)
      is_virtualMachine=1 ;;
    n|N)
      echo -en "$(ruline 8)"
      prompt_isVirtualMachine 
      return 0
    ;;
    *)
      echo -en "$(ruline 8)"
      prompt_isVirtualMachine "bad-option"
      return 0
    ;;
  esac

  if [[ $is_virtualMachine != 1 ]]; then

    printy @style fg@orangered fg@bold @continue
    echo -en "It is recommended to use a VM to develop with, continue at your own risk.\n"
    printy @reset
    # ensure enter is pressed
    echo -en "Press [enter] to continue:"
    read -r _

  fi
}

function prompt_selectVirtualizationEngine() {
  local input_virtualizationEngineNumber=0
  local input_virtualizationEngineName="unknown"

  if [[ $1 ]] && [[ $1 = "bad-option" ]]; then
    printy @style fg@flatred @continue
    echo -en "\n\nYou have entered an invalid option! Please try again.\n"
    printy @reset
  else
    echo -en "\n\n"
  fi

  printy @style bg@flatblue @continue
  echo -en "Which virtualization engine is running this Virtual Machine?\n\n"
  printy @reset
  echo -en "\t1. VirtualBox\n"
  echo -en "\t2. VMware\n"
  echo -en "\t3. LibVirt\n"
  echo -en "\t4. None of the above\n"
  echo -en "\n"
  echo -en "\tEnter option (1-4):"
  read -r input_virtualizationEngineSelection

  case $input_virtualizationEngineSelection in
    1|2|3|4) continue ;;
    *)
      echo -en "$(ruline 11)"
      prompt_selectVirtualizationEngine "bad-option" 
      return 0
    ;;
  esac

  echo -en "$(ruline 7)"
  echo -en "\n\tYou have selected "
  printy @style fg@flatyellow @continue
  echo -en "$input_virtualizationEngineSelection: $(echo -en "$virtualizationEngineNameList" | cut -d',' -f$input_virtualizationEngineSelection)"
  printy @reset
  echo -en ", is that correct?\n\n"
  echo -en "\tEnter option (Y/n):"
  read -r input_verify_virtualizationEngine

  case $input_verify_virtualizationEngine in
    y|Y)  
      input_virtualizationEngineNumber=${input_virtualizationEngineSelection}
      virtualizationEngineName=$(echo -en "$virtualizationEngineNameList" | cut -d',' -f$input_virtualizationEngineNumber)
    ;;
    n|N)
      echo -en "$(ruline 7)"
      prompt_selectVirtualizationEngine
      return 0
    ;;
    *) 
      echo -en "$(ruline 7)"
      prompt_selectVirtualizationEngine "bad-option"
      return 0
    ;;
  esac


}

function generateMachineUID() {
  local machineUID=""
  local machineUIDPrefix="MO-DEV-"
  local machineUIDBody=""
  local machineUIDPostfix="-"

  machineUIDBody=$(tr -dc 'A-Z0-9' < /dev/urandom | head -c 12)
  machineUIDPostfix="-$(tr -dc 'a-z0-9' < /dev/urandom | head -c 3)"
  echo -en "${machineUIDPrefix}${machineUIDBody}${machineUIDPostfix}"

}

function prompt_installDevEnvSystemPackages() {
  if [[ $1 ]] && [[ $1 = "bad-option" ]]; then
    printy @style fg@flatred @continue
    echo -en "\n\nYou have entered an invalid option! Please try again.\n"
    printy @reset
  else
    echo -en "\n\n"
  fi

  printy @style bg@flatgreen fg@white @continue
  echo -en "Would you like to install the necessary milkOS Development Environment packages from the package manager?\n"
  printy @reset

  echo -en "\n"
  echo -en "\tEnter option (Y/n):"
  read -r input_installSystemPackages

  case $input_installSystemPackages in
    y|Y) continue ;;
    n|N) continue ;;
    *)
      echo -en "$(ruline 5)"
      prompt_installDevEnvSystemPackages "bad-option"
      return 0
    ;;
  esac

  echo -en "\tYou have entered "
  printy @style fg@flatyellow @continue
  echo -en "${input_installSystemPackages}"
  printy @reset
  echo -en ", is this correct?\n"
  echo -en "\n"
  echo -en "\tEnter option (y/n):"
  read -r input_verify_installSystemPackages

  case $input_verify_installSystemPackages in
    y|Y) 
      proceedInstallDevEnvSystemPackages=1 
    ;;
    n|N)
      echo -en "$(ruline 8)"
      prompt_installDevEnvSystemPackages
      return 0
    ;;
    *)
      echo -en "$(ruline 8)"
      prompt_installDevEnvSystemPackages "bad-option"
      return 0
    ;;
  esac
}

function verify_packageManagerConnectivity() {
  local packageManagerMainRepository=""
  local packageManagerCommunityRepository=""
  local packageManagerRepositoriesFile="/etc/apk/repositories"
  local generalConnectionStatus=0
  local packageManagerRepositoryConnectionStatus=0

  printy @style bg@flatgreen fg@white @continue
  echo -en "Testing connectivity with package repository...\n"
  printy @reset

  ping -q -c 1 -W 1 1.1.1.1 > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    printy @style fg@mint @continue
    echo -en "✓ Internet connection check passed.\n"
    printy @reset
    
    generalConnectionStatus=$((generalConnectionStatus+1))
  else
    printy @style fg@flatred @continue
    echo -en "✗ Internet connection check failed.\n"
    echo -en "Please check your internet connection.\n"
    echo -en "Saving current progress and exiting...\n"
    printy @reset
    
    generalConnectionStatus=$((generalConnectionStatus-1))
  fi

  packageManagerMainRepository=$(cat ${packageManagerRepositoriesFile} | grep -v \# | grep "main")
  packageManagerCommunityRepository=$(cat ${packageManagerRepositoriesFile} | grep -v \# | grep "community")
  
  wget --spider --quiet ${packageManagerMainRepository} 2>/dev/null
  if [[ $? -eq 0 ]]; then
    printy @style fg@mint @continue
    echo -en "✓ Connection to Main Repository passed.\n"
    echo -en "\t${packageManagerMainRepository}\n"
    printy @reset
    
    packageManagerRepositoryConnectionStatus=$((packageManagerRepositoryConnectionStatus+1))
  else
    printy @style fg@flatred @continue
    echo -en "✗ Connection to Main Repository failed.\n"
    echo -en "\t${packageManagerMainRepository}\n"
    echo -en "Please check your internet connection.\n"
    echo -en "Saving current progress and exiting...\n"
    printy @reset
    
    packageManagerRepositoryConnectionStatus=$((packageManagerRepositoryConnectionStatus-1))
    # TODO: Create function to save progress and exit gracefully.
  fi

  wget --spider --quiet ${packageManagerCommunityRepository} 2>/dev/null
  if [[ $? -eq 0 ]]; then
    printy @style fg@mint @continue
    echo -en "✓ Connection to Community Repository passed.\n"
    echo -en "\t${packageManagerCommunityRepository}\n"
    printy @reset
    
    packageManagerRepositoryConnectionStatus=$((packageManagerRepositoryConnectionStatus+1))
  else
    printy @style fg@flatred @continue
    echo -en "✗ Connection to Community Repository failed.\n"
    echo -en "\t${packageManagerCommunityRepository}\n"
    echo -en "Please check your internet connection.\n"
    echo -en "Saving current progress and exiting...\n"
    printy @reset
    
    packageManagerRepositoryConnectionStatus=$((packageManagerRepositoryConnectionStatus-1))
  fi

}

# function restore_packageManagerRepositories() {

# }

function backup_packageManagerRepositories() {
  local dateTimeBackupFolderName="$(date +"%Y%m%d_%H%m%S")"
  
  echo -en "\n\n"
  printy @style bg@flatgreen fg@white @continue
  echo -en "Backing up package repositories file: ${filePath__packageManagerRepositories}\n"
  printy @reset

  cp "${filePath__packageManagerRepositories}" "${folderPath__milkOSDevEnv_installer_backups}.backup/${dateTimeBackupFolderName}${filePath__packageManagerRepositories}"

  if [ -f ${folderPath__milkOSDevEnv_installer_backups}/${dateTimeBackupFolderName}${filePath__packageManagerRepositories} ]; then
    printy @style fg@mint @continue
    echo -en "✓ Successfully backed up file:\n"
    echo -en "\t${folderPath__milkOSDevEnv_installer_backups}/${dateTimeBackupFolderName}${filePath__packageManagerRepositories}\n"
    printy @reset
  else
    printy @style fg@flatred @continue
    echo -en "✗ There was an error backing up file.\n"
    echo -en "Please check your permissions in '${folderPath__milkOSDevEnv_installer_backups}' and retry.\n"
    printy @reset
  fi
}

function enable_packageManagerRepositories() {
  local communityEnabled=$(cat /etc/apk/repositories | grep 'community' | grep '\#' | wc -l)

  echo -en "\n\n"
  printy @style bg@flatgreen fg@white @continue
  echo -en "Checking if community repository is enabled...\n"
  printy @reset

  if [[ $communityEnabled = "0" ]]; then
    printy @style bg@flatgreen fg@white @continue
    echo -en "Community repository is not enabled in '${filePath__packageManagerRepositories}'! Please follow the prompts below.\n"
    printy @reset

    echo -en "Would you like to enable the community repository now?\nEnter (y/n):"
    read -r input_enableCommunityRepository

    local input_verify_enableCommunityRepository="0"
    case $input_enableCommunityRepository in
      y|Y)
        input_verify_enableCommunityRepository="1"
      ;;
      n|N)
        input_verify_enableCommunityRepository="0"
      ;;
      *)
        echo -en "$(ruline 5)"
        enable_packageManagerRepositories
        return 0
      ;;
    esac

    if [[ $input_verify_enableCommunityRepository = "1" ]]; then
      local etcApkResponsitoriesContents=$(cat ${filePath__packageManagerRepositories})
      ## remove '#' from line containing community and '#'
      etcApkResponsitoriesContents=$(echo "$etcApkResponsitoriesContents" | sed 's/#@community/@community/g')
      echo -en "${etcApkResponsitoriesContents}" > ${filePath__packageManagerRepositories}
    fi
  elif [[ $communityEnabled = "1" ]]; then
    printy @style fg@mint @continue
    echo -en "Community repository is enabled in '${filePath__packageManagerRepositories}'.\n"
    printy @reset
  fi
  echo -en "\n"
}

function run_installDevEnvSystemPackages() {
  printy @style bg@flatgreen fg@white @continue
  echo -en "Preparing to install system packages for milkOS Development Environment\n"
  printy @reset

  echo -en "\n"
  echo -en "Please confirm virtualization engine;\n"
  echo -en "$virtualizationEngineName\n"
  echo -en "Is this correct?\n"
  echo -en "\n"
  echo -en "Enter option (Y/n):"
  read -r input_confirmVirtualizationEngine_priorInstallSystemPackages

  case $input_confirmVirtualizationEngine_priorInstallSystemPackages in
    y|Y) continue ;;
    n|N) 
      prompt_selectVirtualizationEngine
      continue
    ;;
    *)
      echo -en "\n\n\n"
      echo -en "You have entered an invalid option! Please try again."
      echo -en "\n\n\n"
    ;;
  esac

  echo -en "${virtualizationEngineName}"
  echo -en "\n"
  echo -en "VMware"
  echo -en "\n"

  if [ "$virtualizationEngineName" = "VMware" ]; then
    # apk add $(echo -en "${milkOSDevEnv_virtualization_packages__vmware}")
    # auto run
    for package in $(echo -en "${milkOSDevEnv_virtualization_packages__vmware}" | tr ' ' ); do
      apk add $package
    done

  else
    #TODO add support for other virtualization engines.
    echo -en "Sorry, we only support VMware at this time. All other Linux based container engines will be supported in the future.\n"
  fi

}

function constantBanner() {
  clear
  printy @style bg@flatblue fg@flatyellow @continue
  printy @banner title="milkOS Dev Env Installer" information=" :: Configuring Environment"
  printy @reset
  echo -en "\n"
}

function introBanner() {
  clear

  printy @style bg@flatgreen fg@flatyellow @continue
  local introInformation=" :: ::    !!!  Attention  !!!    :: ::milkOS Dev Env Installer is still in the development along with milkOS::Some bugs may occur::If you run into issues please create an issue on Github.::"
  printy @banner title="milkOS Dev Env Installer" \
  message="Development Environment Installer for milkOS" \
  information=" :: ${introInformation} :: :: ::version 23.02.11:milk-dev-almond-milk-v23"
  printy @reset
  echo -en "\n"
  echo -en "* Running Alpine Linux"
  echo -en "\n"
  echo -en "\n"
  echo -en "* Running in a Virtual Machine\n"
  printy @style fg@flatblue @continue
  echo -en "\t(i)"
  printy @reset
  echo -en " VMWare, VirtualBox, or Libvirt (Qemu/KVM) are recommended for development"


  echo -en "\n\n\n"
  local timer=5 # In seconds
  for i in $(seq 15 -1 1); do
    echo -en "\rPress enter to initiate setup, or wait "
    printy @style fg@flatyellow @continue
    echo -en "${i}"
    printy @reset
    echo -en " seconds..."
    printy @reset
    read -t 1 _ && break
  done
}

introBanner
clear

constantBanner
checkDistro

# prompt_isVirtualMachine
# if [[ $is_virtualMachine = 1 ]]; then
#   prompt_selectVirtualizationEngine
# fi

# clear
# printy @style bg@flatgreen fg@white @continue
# printy @banner title="milkOS Dev Env Installer" information=":: Installing Environment::"
# printy @reset

# prompt_installDevEnvSystemPackages

# verify_packageManagerConnectivity

controller__test testItems.enable
controller__test testItems.disable

# enable_packageManagerRepositories

# run_installDevEnvSystemPackages

# generateMachineUID


