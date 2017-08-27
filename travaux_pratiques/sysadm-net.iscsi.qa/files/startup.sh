#!/bin/bash

../scripts/ovs-startup.sh target.qed 4096 100 \
-drive if=none,id=storagevol0,aio=native,cache=directsync,\
format=raw,media=disk,file=target.disk \
-device virtio-blk,drive=storagevol0,scsi=off,config-wce=off

../scripts/ovs-startup.sh initiator1.qed 1024 101 \
-drive if=none,id=initiator1addon,aio=native,cache=directsync,\
format=raw,media=disk,file=initiator1.disk \
-device virtio-blk,drive=initiator1addon,scsi=off,config-wce=off

../scripts/ovs-startup.sh initiator2.qed 1024 102 \
-drive if=none,id=initiator2addon,aio=native,cache=directsync,\
format=raw,media=disk,file=initiator2.disk \
-device virtio-blk,drive=initiator2addon,scsi=off,config-wce=off
