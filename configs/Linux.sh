#!/bin/sh

bridge=bridge0

vmname=`basename "$0"`
iso=/venv/media/linux/ubuntu-18.04.1-live-server-amd64.iso


tapdev=$(ifconfig tap create)
ifconfig $bridge addm $tapdev

ifconfig $bridge up
ifconfig $tapdev up

echo "(hd0) /dev/zvol/base/venv/vms/UbuntuServer" > /venv/init/maps/$vmname.map
echo "(cd0) $iso " >> /venv/init/maps/$vmname.map

echo "Starting the $vmname installer"

grub-bhyve -m /venv/init/maps/$vmname.map -M 2G -r hd0,gpt2 -d /boot/grub  $vmname

bhyve -A -H -P \
          -s 0,hostbridge \
          -s 1,virtio-blk,/dev/zvol/base/venv/vms/UbuntuServer \
          -s 4,ahci-cd,$iso \
          -s 10,virtio-net,$tapdev,mac=00:d3:4d:b3:3f:01 \
          -s 30,xhci,tablet \
          -s 31,lpc \
          -l com1,stdio \
          -c 8 \
          -m 2G \
          $vmname

bhyvectl --destroy --vm=$vmname

ifconfig $tapdev destroy
