#!/bin/bash

NB_DEV=/home/phil/inetdoc

shopt -s dotglob

rsync -avSh --delete --copy-links \
      --exclude-from=$NB_DEV/common/nb_rsync_exclude.txt \
      $NB_DEV/* /var/www/

exit 0
