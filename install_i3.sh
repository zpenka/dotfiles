#!/bin/bash

mkdir -p /home/$USER/.config

ln -s $PWD/i3 /home/$USER/.config/i3/config
ln -s $PWD/i3status /home/$USER/.i3status.conf
