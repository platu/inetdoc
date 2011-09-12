#!/bin/bash

# $Id: diff-img.sh 1607 2011-03-12 16:59:47Z latu $

if [[ -z "$1" || -z "$2" ]]
then
	echo "ERREUR : paramètre manquant"
	echo "Utilisation : $0 <fichier image source> <fichier image différentiel>"
	exit 1
fi

qemu-img create -b $1 -f qcow2 $2 >/dev/null
