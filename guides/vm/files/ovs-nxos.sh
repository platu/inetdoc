#!/bin/bash

# This script is part of https://inetdoc.net project
# 
# It starts a qemu/kvm x86 Nexus 9000v swicth which ports are plugged to Open
# VSwitch ports through already existing tap interfaces named nxtap???.
# 
# Nexus 9000v qcow2 uses EFI BIOS. You can get the OVMF_CODE-pure-efi.fd file
# following the recipe given at this address:
# https://fabianlee.org/2018/09/12/kvm-building-the-latest-ovmf-firmware-for-virtual-machines/ 
#
# The script should be run by a normal user account which belongs to the kvm
# system group and is able to run the ovs-vsctl command via sudo.
#
# Nexus to OvS port mapping is given by a yaml description file which is
# parsed with the shyaml python tool.
# Yaml example file:
#
#	name: "Switch 0 port mapping"
#	switch:
#	  hostname: sw0
#	  # mgmt0 port: nxtap number
#	  mgmt0: 10
#	  # Ethernet port: nxtap number
#	  ethernet:
#	    - 231
#	    - 232
#	    - 233
#	    - 234
#
# File: ovs-nxos.sh
# Author: Philippe Latu
# Source: https://github.com/platu/inetdoc/blob/master/guides/vm/files/ovs-nxos.sh
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

RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
NC='\e[0m' # No Color

vm="$1"
image_format="${vm##*.}"
shift
yamldesc="$1"
shift

# Are the 2 parameters there ?
if [[ -z "${vm}" || -z "${yamldesc}"  ]]
then
	echo -e "${RED}ERROR : missing parameter.${NC}"
	echo -e "${GREEN}Usage : $0 [image file] [port list yaml file]${NC}"
	exit 1
fi

# Does the VM image file exist ?
if [[ ! -f "${vm}" ]]
then
	echo -e "${RED}ERROR : the ${vm} image file does not exist.${NC}"
	exit 1
fi

# Is shyaml available ?
if [[ -z "$(pip3 list --user | grep shyaml)" ]]
then
	echo -e "${RED}~> shyaml tool install with pip3.${NC}"
	echo -e "${GREEN}Restart this script after relogging to the hypervisor.${NC}"
	tput sgr0
	pip3 install shyaml --user
	exit 1
fi

# OOB port mgmt0
tap_mgmt=$(cat ${yamldesc} | shyaml get-value switch.mgmt0)
spice=$((9900 + ${tap_mgmt}))
telnet=$((9000 + ${tap_mgmt}))

# Is the mgmt0 OOB interface mapped to a free tap interface ?
if [[ ! -z "$(ps aux | grep =[n]xtap${tap_mgmt}, )" ]]
then
	echo -e "${RED}Interface nxtap${tap_mgmt} is already in use.${NC}"
	exit 1
fi

tapList=( $(cat ${yamldesc} | shyaml get-value switch.ethernet | tr -d '\n-') )
tapNum=${#tapList[@]}
tapNum=$((tapNum - 1))
ethPorts=""

# Are the Ethernet interfaces mapped to free tap interfaces ?
for i in $(seq 0 $tapNum)
do
	if [[ ! -z "$(ps aux | grep =[n]xtap${tapList[$i]}, )" ]]
	then
		echo -e "${RED}Interface nxtap${tapList[$i]} is already in use.${NC}"
		exit 1
	fi
done

# The last 2 bytes of MAC address are generated from mgmt0 port
# tap interface number
second_rightmost_byte=$(printf "%02x" $(expr ${tap_mgmt} / 256))
rightmost_byte=$(printf "%02x" $(expr ${tap_mgmt} % 256))

# The OUI part of the Ethernet ports MAC address is random as each nexus VM
# must use a different one. The rightmost bit of a unicast interface is set to 0
oui=$(printf "%02x:" $(shuf -i 1-256 -n 3) | sed -e 's/^\(.\)[13579bdf]/\10/')

for i in $(seq 0 $tapNum)
do
	addr=$((i + 1))
	ethPorts+="-netdev tap,ifname=nxtap${tapList[$i]},script=no,downscript=no,id=eth1_1_${addr} \
		-device e1000,bus=bridge-1,addr=1.${addr},netdev=eth1_1_${addr},mac=${oui}01:01:$(printf '%02x' ${addr}),multifunction=on,romfile= " 
done

# RAM size
memory=10240

# Are the OVMF symlink and file copy there ?
if [[ ! -L "./OVMF_CODE.fd" ]]
then
	ln -s /usr/share/OVMF/OVMF_CODE.fd .
fi

if [[ ! -f "${vm}_OVMF_VARS.fd" ]]
then
	cp /usr/share/OVMF/OVMF_VARS.fd ${vm}_OVMF_VARS.fd
fi

echo -e "${RED}---${NC}"
echo -e "~> Switch name                : ${RED}$(cat ${yamldesc} | shyaml get-value switch.hostname)${NC}"
echo -e "~> RAM size                   : ${RED}${memory}MB${NC}"
echo -e "~> SPICE VDI port number      : ${GREEN}${spice}${NC}"
echo -e "~> telnet console port number : ${GREEN}${telnet}${NC}"
echo -ne "~> mgmt0 tap interface        : ${BLUE}nxtap${tap_mgmt}"
echo -e ", $(sudo ovs-vsctl list port nxtap${tap_mgmt} | grep vlan_mode | egrep -o '(access|trunk)') mode${NC}"
for i in $(seq 0 $tapNum)
do
	echo -ne "~> Ethernet1/$((i + 1)) tap interface  : ${BLUE}nxtap${tapList[$i]}"
	echo -e ", $(sudo ovs-vsctl list port nxtap${tapList[$i]} | grep vlan_mode | egrep -o '(access|trunk)') mode${NC}"
done
tput sgr0

ionice -c3 qemu-system-x86_64 \
	-machine type=q35,accel=kvm \
	-cpu max,l3-cache=on \
	-daemonize \
	-m ${memory} \
	--device virtio-balloon \
	-smp 8,threads=4 \
	-rtc base=localtime,clock=host \
	-boot order=c,menu=on \
	-global driver=cfi.pflash01,property=secure,value=on \
	-drive if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly=on \
	-drive if=pflash,format=raw,unit=1,file=${vm}_OVMF_VARS.fd \
	-k fr \
	-vga none \
	-usb \
	-device usb-tablet,bus=usb-bus.0 \
	-device i82801b11-bridge,id=dmi-pci-bridge \
	-device pci-bridge,id=bridge-1,chassis_nr=1,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-2,chassis_nr=2,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-3,chassis_nr=3,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-4,chassis_nr=4,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-5,chassis_nr=5,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-6,chassis_nr=6,bus=dmi-pci-bridge \
	-device pci-bridge,id=bridge-7,chassis_nr=7,bus=dmi-pci-bridge \
	-device ahci,id=ahci0 \
	-drive file=${vm},aio=native,cache.direct=on,if=none,id=drive-sata-disk0,id=drive-sata-disk0,format=${image_format},l2-cache-size=8M,media=disk \
	-device ide-hd,bus=ahci0.0,drive=drive-sata-disk0,id=drive-sata-disk0 \
	-spice port=${spice},addr=localhost,disable-ticketing=on \
	-device virtio-serial-pci \
	-serial telnet:localhost:${telnet},server,nowait \
	-netdev tap,ifname=nxtap${tap_mgmt},script=no,downscript=no,id=mgmt0 \
	-device e1000,bus=bridge-1,addr=1.0,netdev=mgmt0,mac=${oui}ae:${second_rightmost_byte}:${rightmost_byte},multifunction=on,romfile= \
	${ethPorts}
