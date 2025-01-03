#!/bin/bash
username=""
read -p "Enter your username: " username
pacstrap -K /mnt base linux linux-firmware sudo networkmanager iwd fish hyprland git firefox playerctl base-devel sddm brightnessctl adwaita-cursors fish swww bluez bluez-utils blueman alacritty helix sof-firmware rofi-wayland nano mesa
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt "useradd -m $username"
arch-chroot /mnt "echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo"
arch-chroot /mnt "usermod -aG wheel $username"
echo "You will be asked to set the root password for your hSystem install now."
arch-chroot /mnt "passwd"
echo "You will be asked to set the password for your user on your hSystem install now."
arch-chroot /mnt "passwd $username"
mkdir -p /mnt/home/$username/.config
cp -r /etc/configs/* /mnt/home/$username/.config/
mkdir -p /mnt/etc/iwd/
cp /etc/networkconfigs/main.conf /mnt/etc/iwd/
mkdir -p /mnt/etc/NetworkManager/conf.d/
cp /etc/networkconfigs/wifi_backend.conf /mnt/etc/NetworkManager/conf.d
mkdir -p /mnt/etc/sddm.conf.d
cp /etc/sddm-conf/autologin.conf /mnt/etc/sddm.conf.d/
cp /etc/os-release /mnt/etc/
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -s && rm paru-debug-*.pkg.tar.zst && mv paru-*.pkg.tar.zst /mnt/home/$username/ && cd
git clone https://aur.archlinux.org/eww.git
cd eww && makepkg -s && rm eww-debug-*.pkg.tar.zst && mv eww-*.pkg.tar.zst /mnt/home/$username/ && cd
arch-chroot /mnt "pacman -U /home/$username/eww-*.pkg.tar.zst /home/$username/paru-*.pkg.tar.zst"
arch-chroot /mnt "ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf"
arch-chroot /mnt "systemctl enable NetworkManager"
arch-chroot /mnt "systemctl enable systemd-resolved"
arch-chroot /mnt "systemctl enable bluetooth"
arch-chroot /mnt "systemctl enable sddm"
rm -rf eww/ paru/
echo "all done!"
echo "hSystem has been partially installed."
echo "you must now complete the Arch Linux installation guide from steps 3.2 to 4."
echo "after that, your hSystem install will be complete."
