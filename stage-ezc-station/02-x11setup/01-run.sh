#!/bin/bash -e

# x11 autologin service
install -m 755 files/etc/systemd/system/easycast-x11.service "${ROOTFS_DIR}/etc/systemd/system/easycast-x11.service"

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" systemctl enable easycast-x11.service
EOF

# Easycast's user's config files
install -v -o 1000 -g 1000 -m 644 "files/home/easycast/.xsession" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.xsession"
install -v -o 1000 -g 1000 -m 644 "files/home/easycast/.bash_login" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bash_login"
