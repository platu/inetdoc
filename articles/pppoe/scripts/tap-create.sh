#!/bin/bash

for intf in tap0 tap1 tap2 tap3
do
        if [ -z "$(ip addr ls | grep $intf)" ]; then
                echo setting $intf up
                sudo ip tuntap add mode tap dev $intf group kvm
                sudo ip link set dev $intf up
        else
                echo $intf is already there!
        fi
done
