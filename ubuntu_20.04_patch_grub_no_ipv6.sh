#!/bin/bash

# Source
# https://linuxconfig.org/how-to-disable-ipv6-address-on-ubuntu-20-04-lts-focal-fossa


echo "--------------------"
echo "Starting '/etc/default/grub' patching to disable ipv6"
echo ""
sudo sed -i 's#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash ipv6.disable=1"#g' /etc/default/grub
sudo update-grub
echo "Patching done! Restart now..."
echo "--------------------"
