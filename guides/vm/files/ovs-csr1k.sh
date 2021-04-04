#!/bin/bash

# This script is part of https://inetdoc.net project
# 
# It starts a qemu/kvm x86 CSR 1000v router which ports are plugged to Open
# VSwitch ports through already existing tap interfaces named tap???.
#
# Here, the CSR1000v has two GigabitEthernet ports: the first one is considered
# as the mgmt OOB port and the second one as the in band user traffic port. 
# 
# The script should be run by a normal user account which belongs to the kvm
# system group and is able to run the ovs-vsctl command via sudo.
#
# File: ovs-csr1k.sh
# Author: Philippe Latu
# Source: https://github.com/platu/inetdoc/blob/master/guides/vm/files/ovs-csr1k.sh
#
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>.

RED='\e[5;31m'
GREEN='\e[5;32m'
BLUE='\e[5;34m'
NC='\e[0m' # No Color

vm=$1
image_format="${vm##*.}"
shift
tap_mgmt=$1
shift
tap_g2=$1
shift

# Are the 3 parameters there ?
if [[ -z "$vm" || -z "$tap_mgmt" || -z "$tap_g2" ]]
then
	echo -e "${RED}ERROR : missing parameter.${NC}"
	echo -e "${GREEN}Usage : $0 [image file] [mgmt tap interface number] [in band tap interface number]${NC}"
	exit 1
fi

# Does the VM image file exist ?
if [[ ! -f "$vm" ]]
then
	echo -e "${RED}ERROR : the $vm image file does not exist.${NC}"
	exit 1
fi

# Is the mgmt0 OOB interface mapped to a free tap interface ?
if [[ ! -z "$(ps aux | grep =[t]ap${tap_mgmt}, )" ]]
then
	echo -e "${RED}Interface tap${tap_mgmt} is already in use.${NC}"
	exit 1
fi

# OOB port mgmt0
spice=$((7900 + ${tap_mgmt}))
telnet=$((7000 + ${tap_mgmt}))
second_rightmost_byte=$(printf "%02x" $(expr $tap_mgmt / 256))
rightmost_byte=$(printf "%02x" $(expr $tap_mgmt % 256))
macaddressG1="f8:ad:ca:fe:$second_rightmost_byte:$rightmost_byte"
lladdress="fe80::faad:caff:fefe:$(printf "%x" $tap_mgmt)"
vlan_mode="$(sudo ovs-vsctl list port tap${tap_mgmt} | grep vlan_mode | egrep -o '(access|trunk)')"

if [[ "$vlan_mode" == "access" ]]
then
	svi="vlan$(sudo ovs-vsctl list port tap${tap_mgmt} | grep tag | grep -o -E '[0-9]+')"
else
	svi="dsw-host"
fi

# In band GigabitEthernet2
second_rightmost_byte=$(printf "%02x" $(expr $(($tap_g2)) / 256))
rightmost_byte=$(printf "%02x" $(expr $(($tap_g2)) % 256))
macaddressG2="f8:ad:ca:fe:$second_rightmost_byte:$rightmost_byte"

# RAM size
memory=4096

echo -e "${RED}---${NC}"
echo -e "~> Router name                : ${RED}${vm}${NC}"
echo -e "~> RAM size                   : ${RED}${memory}MB${NC}"
echo -e "~> SPICE VDI port number      : ${GREEN}${spice}${NC}"
echo -e "~> telnet console port number : ${GREEN}${telnet}${NC}"
echo -e "~> mgmt0 tap interface        : ${BLUE}tap${tap_mgmt}, ${vlan_mode} mode${NC}"
echo -ne "~> GE2 tap interface          : ${BLUE}tap${tap_g2}"
echo -e ", $(sudo ovs-vsctl list port tap${tap_g2} | grep vlan_mode | egrep -o '(access|trunk)') mode${NC}"
echo -e "~> IPv6 LL address            : ${BLUE}${lladdress}%${svi}${NC}"
tput sgr0

ionice -c3 qemu-system-x86_64 \
	-machine type=q35,accel=kvm \
	-cpu max,l3-cache=on \
	-device intel-iommu \
	-daemonize \
	-name $vm \
	-m $memory \
	--device virtio-balloon \
	-smp 8,threads=2 \
	-rtc base=localtime,clock=host \
	-watchdog i6300esb \
	-watchdog-action none \
	-boot order=c,menu=on \
	-object "iothread,id=iothread.drive0" \
	-drive if=none,id=drive0,aio=native,cache.direct=on,discard=unmap,format=${image_format},media=disk,file=${vm} \
	-device virtio-blk,num-queues=4,drive=drive0,scsi=off,config-wce=off,iothread=iothread.drive0 \
	-k fr \
	-vga qxl \
	-spice port=${spice},addr=localhost,disable-ticketing \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-usb \
	-device usb-tablet,bus=usb-bus.0 \
	-serial telnet:localhost:${telnet},server,nowait \
	-device virtio-net-pci-non-transitional,mq=on,vectors=6,netdev=net${tap_mgmt},mac=${macaddressG1} \
	-netdev tap,queues=2,ifname=tap${tap_mgmt},id=net${tap_mgmt},script=no,downscript=no,vhost=on \
	-device virtio-net-pci-non-transitional,mq=on,vectors=6,netdev=net${tap_g2},mac=${macaddressG2} \
	-netdev tap,queues=2,ifname=tap${tap_g2},id=net${tap_g2},script=no,downscript=no,vhost=on \
	$*
