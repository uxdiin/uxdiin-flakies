# neofetch
pfetch
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

source $HOME/flakies/dots/zsh/p10k/powerlevel10k.zsh-theme
source $HOME/flakies/dots/zsh/.p10k.zsh

(cat ~/.cache/wal/sequences &)

function neovidex() {
  WINIT_UNIX_BACKEND=x11 neovide & exit
}

function wal-tile() {
    wal -n -i "$@" $2
    swww img "$@" --transition-type grow --transition-pos 0.5,0.7 --transition-duration 3        
} 
