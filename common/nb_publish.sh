#!/bin/bash

NB_DEV=/home/phil/inetdoc

rsync -avh --delete --copy-unsafe-links --no-checksum \
      --exclude-from=$NB_DEV/common/nb_rsync_exclude.txt \
      $NB_DEV/* /var/www/
