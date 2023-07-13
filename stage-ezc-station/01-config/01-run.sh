#!/bin/bash -e

# Install config files

install -m 755 files/etc/avahi/services/easycast.service	"${ROOTFS_DIR}/etc/avahi/services/easycast.service"

install -m 755 files/etc/systemd/system/easycast-system-config.service	"${ROOTFS_DIR}/etc/systemd/system/easycast-system-config.service"
install -m 755 files/etc/systemd/system/easycast-station-config.service	"${ROOTFS_DIR}/etc/systemd/system/easycast-station-config.service"

install -m 755 files/etc/network/interfaces	"${ROOTFS_DIR}/etc/network/interfaces"
install -m 755 files/etc/network/wlan	"${ROOTFS_DIR}/etc/network/wlan"

install -m 755 files/etc/network/wlan	"${ROOTFS_DIR}/etc/network/wlan"

install -m 755 files/etc/wpa_supplicant/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf"
install -m 755 files/etc/dhcpcd.conf	"${ROOTFS_DIR}/etc/dhcpcd.conf"

install -m 755 files/etc/environment	"${ROOTFS_DIR}/etc/environment"
install -m 755 files/etc/rc.local	"${ROOTFS_DIR}/etc/rc.local"

install -d "${ROOTFS_DIR}/usr/share/easycast"
install -m 755 files/easycast.mp4	"${ROOTFS_DIR}/usr/share/easycast/easycast.mp4"

install -m 755 files/usr/local/bin/easycast-system-config	"${ROOTFS_DIR}/usr/local/bin/easycast-system-config"

on_chroot << EOF
systemctl disable hostapd
systemctl disable hciuart
systemctl disable systemd-rfkill
systemctl enable easycast-system-config
systemctl enable easycast-station-config
EOF
