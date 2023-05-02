#!/bin/bash
IMAGE=/home/jie/share/src/study/qemu_openwrt/source/bin/targets/armvirt/64/openwrt-armvirt-64-Image-initramfs
LAN=openwrt_tap0
# create tap interface which will be connected to OpenWrt LAN NIC
ip tuntap add mode tap $LAN
ip link set dev $LAN up
# configure interface with static ip to avoid overlapping routes
ip addr add 192.168.1.241/24 dev $LAN
qemu-system-aarch64 \
    -device virtio-net-pci,netdev=lan \
    -netdev tap,id=lan,ifname=$LAN,script=no,downscript=no \
    -device virtio-net-pci,netdev=wan \
    -netdev user,id=wan \
    -M virt -nographic -m 512 -cpu cortex-a53 -smp 4  -kernel $IMAGE
# cleanup. delete tap interface created earlier
ip addr flush dev $LAN
ip link set dev $LAN down
ip tuntap del mode tap dev $LAN
