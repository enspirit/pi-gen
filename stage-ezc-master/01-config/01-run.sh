#!/bin/bash -e

# Install config files
install -m 755 files/etc/dhcpcd.conf	"${ROOTFS_DIR}/etc/dhcpcd.conf"
install -m 755 files/etc/network/interfaces	"${ROOTFS_DIR}/etc/network/interfaces"
install -m 755 files/etc/dnsmasq.conf	"${ROOTFS_DIR}/etc/dnsmasq.conf"
install -m 755 files/etc/hosts.dnsmasq	"${ROOTFS_DIR}/etc/hosts.dnsmasq"
install -m 755 files/etc/iptables.ipv4.nat	"${ROOTFS_DIR}/etc/iptables.ipv4.nat"
install -m 755 files/etc/rc.local	"${ROOTFS_DIR}/etc/rc.local"
install -m 755 files/etc/sysctl.conf	"${ROOTFS_DIR}/etc/sysctl.conf"

install -m 755 files/etc/default/hostapd	"${ROOTFS_DIR}/etc/hostapd"
install -m 755 files/etc/hostapd/hostapd.conf.tpl	"${ROOTFS_DIR}/etc/hostapd/hostapd.conf.tpl"

install -m 755 files/usr/local/bin/easycast-gen-hostapd	"${ROOTFS_DIR}/usr/local/bin/easycast-gen-hostapd"

install -m 755 files/etc/systemd/system/easycast.service	"${ROOTFS_DIR}/etc/systemd/system/easycast.service"
install -m 755 files/etc/systemd/system/easycast-gen-hostapd.service	"${ROOTFS_DIR}/etc/systemd/system/easycast-gen-hostapd.service"

on_chroot << EOF
systemctl enable hostapd
systemctl enable easycast.service
systemctl disable easycast-system-config
systemctl enable easycast-gen-hostapd.service

echo -e "\n/dev/sda1 /media vfat auto,nofail,noatime,rw,user,uid=easycast,gid=easycast 0 2" >> /etc/fstab
EOF
