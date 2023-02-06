#!/bin/sh
echo -en "\n\n"

echo "moosh : MilkOS Open Shell - ver 0:23.02.06"

echo "testing printy() from milkOS system"

. ./resources/milkOSSystem/printy
echo -en "\n"


# printy fg@white bg@mint+bold "What in the moo is this?\n"
printy @banner title="This is the title I want" width@100%