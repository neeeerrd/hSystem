#!/bin/bash
archinstall --config archinstall_configs/configuration.json --creds archinstall_configs/credentials.json
mkdir -p /mnt/home/$username/.config
cp -r /etc/configs/* /mnt/home/$username/.config/
cp /root/stage2.sh /mnt/home/$username/
mkdir /mnt/etc/sddm.conf.d
cp /etc/sddm-conf/autologin.conf /mnt/etc/sddm.conf.d/
cp /etc/os-release /mnt/etc/

arch-chroot /mnt "systemctl enable bluetooth"

echo "stage1 installation finished."
echo "this system will reboot soon."
echo "after it has rebooted:"
echo " - login to your user"
echo " - run bash stage2.sh to complete the installation."
echo "this system will reboot in 10 seconds."
sleep 10
reboot
