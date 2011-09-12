#!/bin/bash
# $Id: startup.sh 1614 2011-03-17 22:41:04Z latu $

#RedOnBlack='\E[31;40m'
RedOnBlack='\E[31m'

vm=$1
shift
memory=$1
shift
port=$1
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
echo "~> Port commutateur  : $port"
echo "~> Adresse MAC       : $macaddress"
tput sgr0

#  -vga vmware \
kvm \
  -daemonize \
  -name $vm \
  -m $memory \
  -rtc base=localtime,clock=host \
  -drive file=$vm,if=virtio,media=disk,boot=on \
  -k fr \
  -usb -usbdevice tablet \
  -soundhw es1370 \
  -net vde,vlan=1,sock=/var/run/vde2/tap0.ctl,port=$port \
  -net nic,vlan=1,model=virtio,macaddr=$macaddress \
  $*
