printf "You are about to Restore the backup files. Please confim [y/n]"
read answer
if [ $answer == 'y' ]
then
  printf "your answer"
fi

# create dir if they don't exist 
if [ ! -d "~/.hammerspoon" ] then
  mkdir "~/.hammerspoon"
fi
if [ ! -d "~/.config/nvim" ] then
  mkdir "~/.config/nvim"
fi

# sync the files using rsync
rsync -r ./hammerspoon/ ~/.hammerspoon
rsync -r ./nvim/ ~/.config/nvim
rsync tmux/tmux.conf ~/.tmux.conf 
rsync zsh/zshrc ~/.zshrc 
