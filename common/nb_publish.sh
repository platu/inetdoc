#!/bin/bash

NB_DEV=/home/phil/inetdoc

rsync -avSh --delete --copy-links --keep-dirlinks \
	--exclude-from="${NB_DEV}"/common/nb_rsync_exclude.txt \
	"${NB_DEV}"/ /var/www/

exit 0
