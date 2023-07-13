#!/bin/bash -e

# Bundler
on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" gem install bundler
EOF

# Clone easycast

on_chroot << EOF
	cd /home/easycast && git clone https://github.com/CoMicFont/easycast/
	cd /home/easycast/easycast && bundle install --path vendor/bundle
	cd /home/easycast && chown easycast:easycast -R easycast
EOF
