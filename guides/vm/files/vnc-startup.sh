#!/bin/bash
# $Id: vnc-startup.sh 1603 2011-03-04 09:11:15Z latu $

RedOnBlack='\E[31m'

vm=$1
shift
memory=$1
shift
port=$1
vnc=$1
shift

if [[ -z "$vm" || -z "$memory" || -z "$port" ]]
then
        echo "ERREUR : paramètre manquant"
        echo "Utilisation : $0 <fichier image> <quantité mémoire en Mo> <port commutateur [2..32]>"
        exit 1
fi

if (( $memory < 128 ))
then
	echo "ERREUR : quantité de mémoire RAM insuffisante"
	echo "La quantité de mémoire en Mo doit être supérieure ou égale à 128"
	exit 1
fi

macaddress="52:54:00:12:34:$port"

echo -e "$RedOnBlack"
echo "~> Machine virtuelle : $vm"
echo "~> Mémoire RAM       : $memory"
echo "~> Adresse VNC       : :$vnc ou $((5900 + $vnc))"
echo "~> Port commutateur  : $port"
echo "~> Adresse MAC       : $macaddress"
tput sgr0

#  -vga vmware \
kvm \
  -daemonize \
  -name $vm \
  -m $memory \
  -vnc :$vnc \
  -rtc base=localtime,clock=host \
  -drive file=$vm,if=virtio,media=disk,boot=on \
  -k fr \
  -usb -usbdevice tablet \
  -net vde,vlan=1,sock=/var/run/vde2/tap0.ctl,port=$port \
  -net nic,vlan=1,model=virtio,macaddr=$macaddress \
  $*
