#!/bin/bash

# $Id: tap-up.sh 1305 2008-06-08 20:59:09Z latu $
# Run this tap interface setup script before KVM/QEMU launch
# Sudo should be configured with the two following tools allowed from user level
# user    ALL = NOPASSWD: /sbin/ifconfig, /usr/sbin/openvpn
# These scripts should be located in ~/bin as they are run at normal user level

if [ -z $1 ] || [ -z $2 ]; then
	echo "Usage: tap-up.sh {tap interface} {IP address}"
	exit 1
fi

TAP=`/sbin/ifconfig 2>/dev/null|grep $1|cut -d " " -f 1`

if [ "$TAP" != "$1" ];
then
	sudo /usr/sbin/openvpn --mktun --dev $1 >/dev/null 2>&1
fi
sudo /sbin/ifconfig $1 $2
