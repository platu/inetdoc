#!/bin/bash

for vlan in $*
do
	ip link add link eth0 name eth0.$vlan type vlan id $vlan
	ip link set dev eth0.$vlan up
done
