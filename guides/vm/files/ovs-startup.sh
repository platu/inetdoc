#!/bin/bash

RedOnBlack='\E[31m'

vm=$1
shift
memory=$1
shift
tapnum=$1
shift

if [[ -z "$vm" || -z "$memory" || -z "$tapnum" ]]
then
        echo "ERREUR : paramètre manquant"
        echo "Utilisation : $0 <fichier image> <quantité mémoire en Mo> <numéro interface tap>"
        exit 1
fi

if (( $memory < 128 ))
then
	echo "ERREUR : quantité de mémoire RAM insuffisante"
	echo "La quantité de mémoire en Mo doit être supérieure ou égale à 128"
	exit 1
fi

macaddress="ba:ad:00:ca:fe:`printf "%02x" $tapnum`"

echo -e "$RedOnBlack"
echo "~> Machine virtuelle : $vm"
echo "~> Port SPICE        : $((5900 + $tapnum))"
echo "~> Mémoire RAM       : $memory"
echo "~> Adresse MAC       : $macaddress"
tput sgr0

ionice -c3 qemu-system-x86_64 \
  -machine type=q35,accel=kvm:tcg \
  -cpu qemu64,+ssse3,+sse4.1,+sse4.2,+x2apic \
  -daemonize \
  -name $vm \
  -m $memory \
  -balloon virtio \
  -smp 2,cores=2 \
  -rtc base=localtime,clock=host \
  -boot order=c \
  -drive if=none,id=drive0,aio=native,cache=none,format=raw,media=disk,file=$vm \
  -device virtio-blk,drive=drive0,scsi=off,config-wce=off,x-data-plane=on \
  -k fr \
  -vga qxl \
  -spice port=$((5900 + $tapnum)),addr=localhost,disable-ticketing \
  -device virtio-serial-pci \
  -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
  -chardev spicevmc,id=spicechannel0,name=vdagent \
  -usb -usbdevice tablet \
  -soundhw hda \
  -device virtio-net,netdev=net0,mac="$macaddress" \
  -netdev tap,ifname=tap$tapnum,id=net0,script=no \
  $*

