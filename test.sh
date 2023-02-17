#!/bin/sh
clear

# echo "moosh : MilkOS Open Shell - ver 0:23.02.06"
# echo "testing printy() from milkOS system"
# echo -en "\n"

## testing ##
. ./resources/milkOSSystem/printy
. ./resources/milkOSSystem/printlog

# value=$(cat << "EOF"

#                                 MMMMMMMMMMM MMMMMMMMMMM
#                  db 88 88       MMP"""""YMM MP""""""`MM 
#                     88 88       M' .mmm. `M M  mmmmm..M 
#       88d8b.d8b. 88 88 88  .dP  M  MMMMM  M M.      `YM 
#       88'`88'`88 88 88 88888"   M  MMMMM  M MMMMMMM.  M 
#       88  88  88 88 88 88  `8b. M. `MMM' .M M. .MMM'  M 
#       88  88  88 88 88 88   `YP MMb     dMM Mb.     .dM 
#                                 MMMMMMMMMMM MMMMMMMMMMM
#                                        v23.02.10

# EOF
# )

# sleep 3s
# clear

# printy @style fg@mint @continue
# echo -e "$value"
# printy @reset

# sleep 3s
# clear

printy @style bg@flatblue fg@white @continue
printy @banner title="milkOS Dev Env Installer" message="milkOS is an operating system built atop of Alpine Linux. I use arch btw. This is the future of OS" \
information=" ::version 23.02.11::milk-dev-almond-milk-v23"


##
printy @reset

printy @style fg@flatred @continue
echo -en "hello world!\n" | printlog
echo -en "this is the end of the program UwU\n" | printlog `
printy @reset




