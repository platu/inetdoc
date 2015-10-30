#!/bin/bash

for vlan in $*
do
	ip link add link eth0 name eth0.$vlan type vlan id $vlan
	ip link set dev eth0.$vlan txqueuelen 10000
	tc qdisc add dev eth0.$vlan root pfifo_fast
	ip link set dev eth0.$vlan up
done
