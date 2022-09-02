#!/bin/bash

if [[ ! -f $1 ]]
then
	echo "ERROR: file $1 not found."
	exit 1
fi

vm=$1

image_format="${vm##*.}"

if [[ $image_format != "qcow2" ]]
then
	echo "This script only processes QCOW2 image files."
	exit 1
fi

if pgrep -u $USER -l -f ${vm} | grep -v $$
then
	echo "The ${vm} image is in use."
	exit 1
else
	mv ${vm} ${vm}_OldBackup

	echo "Start of image file size reduction ..."
	ionice -c3 qemu-img convert -m16 -W -O qcow2 -c ${vm}_OldBackup ${vm}

	echo "Reduction completed. The new image file ${vm} is ready."
fi

exit 0
