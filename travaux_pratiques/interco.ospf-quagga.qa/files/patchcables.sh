#!/bin/bash

for patchtap in $*
do
        if [ -z "$(ip addr ls | grep $patchtap)" ]; then
                echo setting $patchtap up
                sudo ip tuntap add mode tap dev $patchtap group kvm
                sudo ip link set dev $patchtap up
        else
                echo $patchtap is already there!
        fi
done
