#!/bin/bash

# Symlink conf files to home dir, separating git from ~
ln -s $PWD/bash_profile /Users/$USER/.bash_profile
touch /Users/$USER/.bash_profile-local
ln -s $PWD/gitconfig /Users/$USER/.gitconfig
ln -s $PWD/tmate /Users/$USER/.tmate.conf
ln -s $PWD/tmux /Users/$USER/.tmux.conf
ln -s $PWD/vim /Users/$USER/.vim
ln -s $PWD/vimrc /Users/$USER/.vimrc
ln -s $PWD/git-tab-completion /Users/$USER/.git-tab-completion
