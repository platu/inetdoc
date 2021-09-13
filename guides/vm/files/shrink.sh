#!/bin/bash

vm=$1

image_format="${vm##*.}"

if [[ $image_format != "qcow2" ]]
then
	echo "Ce script ne traite que les images au format QCOW2"
	exit 1
fi

mv $1 $1_OldBackup

echo "Début de la réduction de taille d'image ..."
ionice -c3 qemu-img convert -O qcow2 -c $1_OldBackup $1

echo "Réduction terminée, la nouvelle image $1 est prête."

exit 0
