#!/bin/bash

../scripts/ovs-startup.sh hub.qed 1024 0 \
        -device virtio-net,netdev=net2,mac=de:ad:be:ef:00:01 \
        -netdev tap,ifname=tap1,id=net2,script=no

../scripts/ovs-startup.sh spoke.qed 1024 2 \
        -device virtio-net,netdev=net2,mac=de:ad:be:ef:00:03 \
        -netdev tap,ifname=tap3,id=net2,script=no
