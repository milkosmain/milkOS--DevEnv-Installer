#!/bin/sh
clear

echo "moosh : MilkOS Open Shell - ver 0:23.02.06"
echo "testing printy() from milkOS system"
echo -en "\n"



## testing ##
. ./resources/milkOSSystem/printy
# printy fg@white bg@mint+bold "What in the moo is this?\n"
# printy @style fg=white bg=mint+bold "What in the moo is this?\n"
printy bg@orange fg@black @continue
printy @banner title="You need a better OS" message="I sure hope this looks cool!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo -en "\e[0m"
