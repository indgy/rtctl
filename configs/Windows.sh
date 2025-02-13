#!/bin/sh

bridge=bridge0

vmname=`basename "$0"`
iso=/venv/media/win/win2k16-server-multi.iso
drv=/venv/media/win/virtio-drivers.iso

tapdev=$(ifconfig tap create)
ifconfig $bridge addm $tapdev

ifconfig $bridge up
ifconfig $tapdev up

echo "Starting the $vmname VM"

bhyve -c 4 -m 4G -H \
        -s 0,hostbridge \
        -s 1,ahci-hd,/dev/zvol/base/venv/vms/$vmname \
        -s 3,ahci-cd,$iso \
        -s 4,ahci-cd,$drv \
        -s 6,virtio-net,$tapdev \
        -s 29,fbuf,tcp=0.0.0.0:45555,w=640,h=480,wait \
        -s 30,xhci,tablet \
        -s 31,lpc \
        -l com1,stdio \
        -l bootrom,/usr/local/share/uefi-firmware/BHYVE_UEFI.fd \
        $vmname

bhyvectl --destroy --vm=$vmname

ifconfig $bridge deletem $tapdev
ifconfig $tapdev destroy
