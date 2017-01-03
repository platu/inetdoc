#!/bin/bash

RedOnBlack='\E[31m'

vm=$1
shift
memory=$1
shift
num=$1
shift

if [[ -z "$vm" || -z "$memory" || -z "$num" ]]
then
	echo "ERREUR : paramètre manquant"
	echo "Utilisation : $0 <fichier image> <quantité mémoire en Mo> <numéro de port SPICE>"
	exit 1
fi

if (( $memory < 128 ))
then
	echo "ERREUR : quantité de mémoire RAM insuffisante"
	echo "La quantité de mémoire en Mo doit être supérieure ou égale à 128"
	exit 1
fi

second_rightmost_byte=$(printf "%02x" $(expr $tapnum / 256))
rightmost_byte=$(printf "%02x" $(expr $tapnum % 256))
macaddress="ba:ad:ca:fe:$second_rightmost_byte:$rightmost_byte"

image_format="${vm##*.}"

echo -e "$RedOnBlack"
echo "~> Machine virtuelle : $vm"
echo "~> Port SPICE        : $((5900 + $num))"
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
	-watchdog i6300esb \
	-watchdog-action none \
	-boot order=c,menu=on \
	-drive if=none,id=drive0,aio=native,cache.direct=on,format=$image_format,media=disk,file=$vm \
	-device virtio-blk,drive=drive0,scsi=off,config-wce=off \
	-k fr \
	-vga qxl \
	-spice port=$((5900 + $num)),addr=localhost,disable-ticketing \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-usb -usbdevice tablet \
	-soundhw hda \
	-device virtio-net,netdev=net0,mac="$macaddress" \
	-netdev user,id=net0 \
	-redir tcp:$((5000 + $num))::22 \
	$*
