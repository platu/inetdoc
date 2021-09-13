#!/bin/bash

RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
NC='\e[0m' # No Color

iso='Win10_1909_French_x64.iso'

virtio_iso='virtio-win-0.1.173.iso'

vm=$1
shift
memory=$1
shift
tapnum=$1
shift

if [[ -z "${vm}" || -z "${memory}" || -z "${tapnum}" ]]
then
	echo "ERREUR : paramètre manquant"
	echo "Utilisation : $0 <fichier image> <quantité mémoire en Mo> <numéro interface tap>"
	exit 1
fi

if (( ${memory} < 128 ))
then
	echo "ERREUR : quantité de mémoire RAM insuffisante"
	echo "La quantité de mémoire en Mo doit être supérieure ou égale à 128"
	exit 1
fi

second_rightmost_byte=$(printf "%02x" $(expr ${tapnum} / 256))
rightmost_byte=$(printf "%02x" $(expr ${tapnum} % 256))
macaddress="ba:ad:ca:fe:$second_rightmost_byte:$rightmost_byte"

image_format="${vm##*.}"


spice=$((5900 + ${tapnum}))
telnet=$((2300 + ${tapnum}))

echo -e "~> Virtual machine filename   : ${RED}${vm}${NC}"
echo -e "~> RAM size                   : ${RED}${memory}MB${NC}"
echo -e "~> SPICE VDI port number      : ${GREEN}${spice}${NC}"
echo -e "~> telnet console port number : ${GREEN}${telnet}${NC}"
echo -e "~> MAC address                : ${BLUE}${macaddress}${NC}"
echo -e "~> Switch port interface      : ${BLUE}tap${tapnum}, ${vlan_mode} mode${NC}"
echo -e "~> IPv6 LL address            : ${BLUE}${lladdress}%${svi}${NC}"
tput sgr0

ionice -c3 qemu-system-x86_64 \
	-machine type=q35,accel=kvm:tcg \
	-cpu max,l3-cache=on \
	-device intel-iommu \
	-daemonize \
	-name ${vm} \
	-m ${memory} \
	-device virtio-net-pci,mq=on,vectors=6,netdev=net${tapnum},mac="${macaddress}" \
	-netdev tap,queues=2,ifname=tap${tapnum},id=net${tapnum},script=no,downscript=no,vhost=on \
	-serial telnet:localhost:${telnet},server,nowait \
	-device virtio-balloon \
	-smp 8,threads=2 \
	-rtc base=localtime,clock=host \
	-watchdog i6300esb \
	-watchdog-action none \
	-boot once=d,menu=on \
	-device ahci,id=ahci0 \
	-device ide-drive,bus=ahci0.0,drive=drive-sata0-0-0,id=sata0-0-0 \
	-drive media=cdrom,if=none,file=${iso},id=drive-sata0-0-0 \
	-device ide-drive,bus=ahci0.1,drive=drive-sata0-0-1,id=sata0-0-1 \
	-drive media=cdrom,if=none,file=${virtio_iso},id=drive-sata0-0-1 \
	-object "iothread,id=iothread.drive0" \
	-drive if=none,id=drive0,aio=native,cache.direct=on,discard=unmap,format=${image_format},media=disk,file=${vm} \
	-device virtio-blk,num-queues=4,drive=drive0,scsi=off,config-wce=off,iothread=iothread.drive0 \
	-k fr \
	-vga qxl \
	-spice port=${spice},addr=localhost,disable-ticketing=on \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-usb \
	-device usb-tablet,bus=usb-bus.0 \
	$*

