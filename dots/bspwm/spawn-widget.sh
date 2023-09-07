#!/bin/bash
alacritty -e $SHELL -c 'sleep 3s' &&
$HOME/bspwm/script/spawn-clock.sh
sleep 1s
$HOME/bspwm/script/spawn-cmatrix.sh 
sleep 1s
$HOME/bspwm/script/spawn-htop.sh 
sleep 1s
$HOME/bspwm/script/spawn-cava.sh 
sleep 1s
$HOME/bspwm/script/spawn-neofetch-abu.sh


