#!/usr/bin/env bash
xset s noblank
xset s off
xset -dpms

echo "Ensuring SSH key"
/home/easycast/easycast/bin/ensure-sshkey

echo "Ensuring Master node can SSH"
/home/easycast/easycast/bin/authorize-master-to-ssh

/home/easycast/easycast/bin/open-displays&

tail -f /dev/null
