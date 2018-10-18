#!/bin/bash

for patchtap in $*
do
        if [ -z "$(ip link ls | grep $patchtap)" ]; then
                echo setting $patchtap up
                sudo ip tuntap add mode tap dev $patchtap group kvm multi_queue
                sudo ip link set dev $patchtap up
        else
                echo $patchtap is already there!
        fi
done
