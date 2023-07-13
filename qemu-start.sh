#!/bin/bash -eu

# # Working rpi3 but sloooow
# qemu-system-aarch64 \
#    -machine raspi3b \
#    -cpu cortex-a72 \
#    -dtb /Volumes/boot/bcm2710-rpi-3-b-plus.dtb \
#    -m 1G -smp 4 -serial stdio \
#    -kernel /Volumes/boot/kernel8.img \
#    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
#    -sd $HOME/Work/enspirit/easycast/pi-gen/deploy/2023-07-14-easycast-ezcast-master.img

# # RPI 4
# qemu-system-aarch64 \
#   -machine virt -smp 8 -m 4G -cpu cortex-a72 \
#   -serial stdio \
#   -bios "/tmp/tamere.EFI" \
#   -drive if=none,file=$HOME/Work/enspirit/easycast/pi-gen/deploy/2023-07-14-easycast-ezcast-master.img,format=raw,id=hd -device qemu-xhci -device usb-storage,drive=hd -boot menu=on -device VGA


# qemu-system-aarch64 \
#   -M virt,highmem=off -smp 8 -m 2G -cpu cortex-a72 \
#   -kernel /Volumes/boot/kernel8.img \
#   -append "root=PARTUUID=d97f5830-02 rw console=ttyAMA0" \
#   -serial telnet:localhost:4321,server,nowait \
#   -monitor telnet:localhost:4322,server,nowait \
#   -device VGA,id=vga1 -device secondary-vga,id=vga2 \
#   -object iothread,id=io1 \
#   -drive file=$HOME/Work/enspirit/easycast/pi-gen/deploy/2023-07-14-easycast-ezcast-master.img,format=raw
#   # -device virtio-blk-pci,drive=disk0,iothread=io1 \

qemu-system-aarch64 -machine virt -cpu cortex-a72 -smp 6 -m 4G \
    -kernel /Volumes/boot/kernel8.img -append "root=/dev/vda2 rootfstype=ext4 rw panic=0 console=ttyAMA0" \
    -drive format=raw,file=$HOME/Work/enspirit/easycast/pi-gen/deploy/2023-07-14-easycast-ezcast-master-qemu.img,if=none,id=hd0,cache=writeback \
    -device virtio-blk,drive=hd0,bootindex=0 \
    -netdev user,id=mynet,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=mynet \
    -monitor telnet:127.0.0.1:5555,server,nowait
