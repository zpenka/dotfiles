#!/bin/bash

# Symlink conf files to home dir, separating git from ~
ln -s $PWD/bashrc /home/$USER/.bashrc
ln -s $PWD/bashrc-local /home/$USER/.bashrc-local
ln -s $PWD/gitconfig /home/$USER/.gitconfig
ln -s $PWD/tmate /home/$USER/.tmate.conf
ln -s $PWD/tmux /home/$USER/.tmux.conf
ln -s $PWD/vim /home/$USER/.vim
ln -s $PWD/vimrc /home/$USER/.vimrc
ln -s $PWD/git-tab-completion /home/$USER/.git-tab-completion

