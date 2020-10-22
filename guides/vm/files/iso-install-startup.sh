#!/bin/bash

RedOnBlack='\E[31m'

vm=$1
shift
iso=$1
shift
memory=$1
shift
tapnum=$1
shift

if [[ -z "$vm" || -z "$iso" || -z "$memory" || -z "$tapnum" ]]
then
	echo "ERREUR : paramètre manquant"
	echo "Utilisation : $0 <fichier image> <fichier iso> <quantité mémoire en Mo> <numéro interface tap>"
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
echo "~> Port SPICE        : $((5900 + $tapnum))"
echo "~> Mémoire RAM       : $memory"
echo "~> Adresse MAC       : $macaddress"
tput sgr0

ionice -c3 qemu-system-x86_64 \
	-machine type=q35,accel=kvm:tcg \
	-cpu max,l3-cache=on \
	-device intel-iommu \
	-daemonize \
	-name $vm \
	-m $memory \
	-device virtio-balloon \
	-smp 2,threads=2 \
	-rtc base=localtime,clock=host \
	-watchdog i6300esb \
	-watchdog-action none \
	-boot order=c,menu=on \
	-boot once=d,menu=on \
	-device ahci,id=ahci0 \
	-device ide-cd,bus=ahci0.0,drive=drive-sata0-0-0,id=sata0-0-0 \
	-drive media=cdrom,if=none,file=$iso,id=drive-sata0-0-0 \
	-drive if=none,id=drive0,aio=native,cache.direct=on,format=$image_format,media=disk,file=$vm \
	-device virtio-blk,drive=drive0,scsi=off,config-wce=off \
	-k fr \
	-vga qxl \
	-spice port=$((5900 + $tapnum)),addr=localhost,disable-ticketing \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-usb \
	-device usb-tablet,bus=usb-bus.0 \
	-device intel-hda \
	-device hda-duplex \
	-device virtio-net-pci,mq=on,vectors=6,netdev=net$tapnum,mac="$macaddress" \
	-netdev tap,queues=2,ifname=tap$tapnum,id=net$tapnum,script=no,downscript=no,vhost=on \
	$*
