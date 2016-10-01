#!/bin/bash

mkdir -p /home/$USER/bin

chmod +x $PWD/bin/mysql_ramdisk
ln -s $PWD/bin/mysql_ramdisk /home/$USER/bin/mysql_ramdisk

chmod +x $PWD/bin/bssync
ln -s $PWD/bin/bssync /home/$USER/bin/bssync

chmod +x $PWD/bin/packages_sort_by_size
ln -s $PWD/bin/packages_sort_by_size /home/$USER/bin/packages_sort_by_size

