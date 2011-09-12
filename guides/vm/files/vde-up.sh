#!/bin/bash

# $Id: vde-up.sh 1305 2008-06-08 20:59:09Z latu $
# Run this virtual ethernet switch setup script before KVM/QEMU launch
# These scripts should be located in ~/bin as they are run at normal user level

if [ -z $1 ] || [ -z $2 ]; then
	echo "Usage: vde-up.sh {tap interface} {IP address}"
	exit 1
fi

~/bin/tap-up.sh $1 $2
vde_switch -d --tap $1 -s /tmp/vde.ctl -M /tmp/vde.mgmt
