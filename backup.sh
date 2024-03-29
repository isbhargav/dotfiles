#!/bin/sh

read -p "You are about to backup your existing dot files. Please confim [y/n]" yn
case $yn in
    [Yy]* ) 
      # create dir if they don't exist 
      [ ! -d "./hammerspoon" ] && mkdir "hammerspoon"
      [ ! -d "./nvim" ] && mkdir "nvim"
      [ ! -d "./vim" ] && mkdir "vim"
      [ ! -d "./tmux" ] && mkdir "tmux"
      [ ! -d "./zsh" ] && mkdir "zsh"

      # sync the files using rsync
      rsync -r ~/.hammerspoon/ hammerspoon
      rsync -r ~/.config/nvim/ nvim
      rsync ~/.tmux.conf tmux/tmux.conf
      rsync ~/.zshrc zsh/zshrc
      rsync ~/.vimrc vim/vimrc
      break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
esac
