# neofetch
(cat ~/.cache/wal/sequences &)
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


function neovidex() {
  WINIT_UNIX_BACKEND=x11 neovide & exit
}

function wal-tile() {
    wal -n -i $1 $2
    swww init
    swww img $1 --transition-type grow --transition-pos 0.5,0.7 --transition-duration 3        
} 


eval "$(ssh-agent -s)" > /dev/null
ssh-add $HOME/.ssh/id_rsa_github  > /dev/null 2>&1


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/uxdiin/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/uxdiin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/uxdiin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/uxdiin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# export LD_LIBRARY_PATH=/home/uxdiin/anaconda3/envs/text-process/lib

