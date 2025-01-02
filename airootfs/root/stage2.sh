#!/bin/bash

echo "hSystem installation stage3"
echo "you're almost there!"
systemctl enable --now systemd-resolved
systemctl enable --now NetworkManager
echo "you will now be asked to set up your wifi connection."
echo "to do this, go to activate a connection, select your network, and select activate."
echo "if you are connected via ethernet, simply select quit."
echo "opening nmtui in 10 seconds..."
sleep 10
nmtui
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
paru -S eww mesa
chsh $(which fish)
systemctl enable sddm
echo "all done!!!!!!!!! :3"
echo "this machine will reboot in 5 seconds, after that you'll have a machine running hSystem!"
sleep 5
reboot
