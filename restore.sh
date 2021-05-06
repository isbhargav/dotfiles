# create dir if they don't exist 
[ ! -d "~/.hammerspoon" ] && mkdir "~/.hammerspoon"
[ ! -d "~/.config/nvim" ] && mkdir "~/.config/nvim"

# sync the files using rsync
rsync -r ./hammerspoon/ ~/.hammerspoon
rsync -r ./nvim/ ~/.config/nvim
rsync tmux/tmux.conf ~/.tmux.conf 
rsync zsh/zshrc ~/.zshrc 
