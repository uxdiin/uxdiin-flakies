#!/bin/bash
alacritty -e $SHELL -c 'sleep 3s' &&
$HOME/bspwm/script/spawn-clock-abu.sh
sleep 1s
$HOME/bspwm/script/spawn-cmatrix-abu.sh 
sleep 1s
$HOME/bspwm/script/spawn-htop-abu.sh 
sleep 1s
$HOME/bspwm/script/spawn-cava-abu.sh 
sleep 1s
$HOME/bspwm/script/spawn-neofetch-abu.sh


