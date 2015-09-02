#!/bin/bash

for intf in tap1 tap2 tap3
# OOB taps
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=30
  sudo ip link set dev $intf up
done

for intf in tap12 tap21
# VLAN 12
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=12
  sudo ip link set dev $intf up
done

for intf in tap13 tap31
# VLAN 13
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=13
  sudo ip link set dev $intf up
done

for intf in tap14 tap41
# VLAN 14
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=14
  sudo ip link set dev $intf up
done

for intf in tap23 tap32
# VLAN 23
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=23
  sudo ip link set dev $intf up
done

for intf in tap24 tap42
# VLAN 24
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=24
  sudo ip link set dev $intf up
done

for intf in tap34 tap43
# VLAN 34
do
  sudo ip tuntap add mode tap dev $intf group kvm
  sudo ovs-vsctl add-port br0 $intf tag=34
  sudo ip link set dev $intf up
done

../scripts/ovs-startup.sh r1.raw 512 1 \
  -device virtio-net,netdev=net12,mac="ba:ad:00:ca:fe:0c" \
  -netdev tap,ifname=tap12,id=net12,script=no \
  -device virtio-net,netdev=net13,mac="ba:ad:00:ca:fe:0d" \
  -netdev tap,ifname=tap13,id=net13,script=no \
  -device virtio-net,netdev=net14,mac="ba:ad:00:ca:fe:0e" \
  -netdev tap,ifname=tap14,id=net14,script=no

../scripts/ovs-startup.sh r2.raw 512 2 \
  -device virtio-net,netdev=net21,mac="ba:ad:00:ca:fe:15" \
  -netdev tap,ifname=tap21,id=net21,script=no \
  -device virtio-net,netdev=net23,mac="ba:ad:00:ca:fe:17" \
  -netdev tap,ifname=tap23,id=net23,script=no \
  -device virtio-net,netdev=net24,mac="ba:ad:00:ca:fe:18" \
  -netdev tap,ifname=tap24,id=net24,script=no

../scripts/ovs-startup.sh r3.raw 512 3 \
  -device virtio-net,netdev=net31,mac="ba:ad:00:ca:fe:1f" \
  -netdev tap,ifname=tap31,id=net31,script=no \
  -device virtio-net,netdev=net32,mac="ba:ad:00:ca:fe:20" \
  -netdev tap,ifname=tap32,id=net32,script=no \
  -device virtio-net,netdev=net34,mac="ba:ad:00:ca:fe:22" \
  -netdev tap,ifname=tap34,id=net34,script=no

../scripts/ovs-startup.sh r4.raw 512 41 \
  -device virtio-net,netdev=net42,mac="ba:ad:00:ca:fe:2a" \
  -netdev tap,ifname=tap42,id=net42,script=no \
  -device virtio-net,netdev=net43,mac="ba:ad:00:ca:fe:2b" \
  -netdev tap,ifname=tap43,id=net43,script=no
