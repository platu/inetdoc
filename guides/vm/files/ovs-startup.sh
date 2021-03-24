#!/bin/bash

RedOnBlack='\E[31m'

vm=$1
shift
memory=$1
shift
tapnum=$1
shift

# Est-ce que les 3 paramètres sont là ?
if [[ -z "$vm" || -z "$memory" || -z "$tapnum" ]]
then
	echo "ERREUR : paramètre manquant"
	echo "Utilisation : $0 [fichier image] [quantité mémoire en Mo] [numéro interface tap]"
	exit 1
fi

# Est-ce que le fichier image existe ?
if [[ ! -f "$vm" ]]
then
	echo "ERREUR : Le fichier image $vm n'existe pas !"
	exit 1
fi

# Est-ce que la quantité de RAM est suffisante ?
if [[ ${memory} -lt 128 ]]
then
	echo "ERREUR : mémoire RAM insuffisante : ${memory}Mo"
	echo "La taille mémoire doit être supérieure ou égale à 128Mo."
	exit 1
fi

# Est-ce que l'interface tap est libre ?
if [[ ! -z "$(ps aux | grep =[tap]${tapnum}, )" ]]
then
	echo "L'interface tap${tapnum} est déjà utilisée !"
	exit 1
fi

second_rightmost_byte=$(printf "%02x" $(expr $tapnum / 256))
rightmost_byte=$(printf "%02x" $(expr $tapnum % 256))
macaddress="ba:ad:ca:fe:$second_rightmost_byte:$rightmost_byte"

image_format="${vm##*.}"

spice=$((5900 + $tapnum))
telnet=$((2300 + $tapnum))

echo -e "$RedOnBlack"
echo "~> Machine virtuelle : $vm"
echo "~> Port SPICE        : $spice"
echo "~> Port Console TCP  : $telnet"
echo "~> Mémoire RAM       : $memory"
echo "~> Adresse MAC       : $macaddress"
tput sgr0

ionice -c3 qemu-system-x86_64 \
	-machine type=q35,accel=kvm:tcg \
	-cpu max,l3-cache=on,+vmx \
	-device intel-iommu \
	-daemonize \
	-name $vm \
	-m $memory \
	-device virtio-balloon \
	-smp 8,threads=2 \
	-rtc base=localtime,clock=host \
	-watchdog i6300esb \
	-watchdog-action none \
	-boot order=c,menu=on \
	-object "iothread,id=iothread.drive0" \
	-drive if=none,id=drive0,aio=native,cache.direct=on,discard=unmap,format=$image_format,media=disk,file=$vm \
	-device virtio-blk,num-queues=4,drive=drive0,scsi=off,config-wce=off,iothread=iothread.drive0 \
	-k fr \
	-vga qxl \
	-spice port=$spice,addr=localhost,disable-ticketing \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-usb \
	-device usb-tablet,bus=usb-bus.0 \
	-device intel-hda \
	-device hda-duplex \
	-serial telnet:localhost:$telnet,server,nowait \
	-device virtio-net-pci,mq=on,vectors=6,netdev=net$tapnum,mac="$macaddress" \
	-netdev tap,queues=2,ifname=tap$tapnum,id=net$tapnum,script=no,downscript=no,vhost=on \
	$*
