#!/bin/bash

if [[ -z "$1" || -z "$2" ]]
then
        echo "ERREUR : paramètre manquant"
        echo "Utilisation : $0 <fichier image source> <fichier image différentiel>"
        exit 1
fi

image_format="${1##*.}"

qemu-img create -b $1 -f $image_format $2 >/dev/null

exit 0
