#!/bin/bash


echo ============================================================================
echo =================== welcome to archinstaller================================
echo ============================================================================

echo select your keymap. write es, en, la-latin.

read -p "insert your keymap: " keymap

loadkeys $keymap

echo step1 use cfdisk for make the partitions

read -p "press enter to continue" a

cfdisk

lsblk

echo select your device to format to ext4

#read -p "insert your device.example /dev/sda,/dev/sda1: " device

while true;
do
	read -p "insert your device.example /dev/sda,/dev/sda1 or insert 1 finish : " device
	if [ "$device" -eq  "1" ]; then
	break
	elif [ "$device" -ne "1" ]; then
	mkfs.ext4 $device 
	fi
done

echo select partition to mount boot or 1 for next step
read -p "insert partition " bootdevice
mount $bootdevice /mnt/boot


echo select partition to mount root or 1 for next step
read -p "insert partition " rootdevice
mount $rootdevice /mnt/


echo select partition to mount swap or 1 for next step
read -p "insert partition " swapdevice
mkswap $swapdevice
swapon $swapdevice


pacman -Sy reflector python --noconfirm
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel nano
pacstrap /mnt linux-firmware linux linux-headers mkinitcpio dhcpcd networkmanager iwd net-tools ifplugd iw wireless_tools wpa_supplicant dialog wireless-regdb xf86-input-libinput bluez bluez-utils pulseaudio-bluetooth
genfstab -p /mnt >> /mnt/etc/fstab


arch-chroot /mnt

nano /etc/locale.gen

locale-gen

read -p "insert lang" locallang

echo $locallang > /etc/locale.conf

export $locallang


ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime

hwclock -w

echo KEYMAP=es > /etc/vconsole.conf

read -p "inserte nombre del pc: " nombredepc

echo $nombredepc > /etc/hostname

echo 127.0.0.1		localhost > /etc/hosts
echo ::1		loclahost > /etc/hosts
echo 127.0.1.1		$nombredepc.localdomain $nombredepc > /etc/hosts

passwd root

read -p "inserte nombre de usuario" username

useradd -m -g users -G wheel -s /bin/bash $username
passwd $username


nano /etc/sudoers

systemctl enable dhcpcd NetworkManager

systemctl enable bluetooth


pacman -Sy reflector
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist


pacman -Syu

nano /etc/pacman.conf

pacman -Sy git wget
pacman -Sy neofetch lsb-release
pacman -Sy intel-ucode
pacman -S xdg-user-dirs
xdg-user-dirs-update

pacman -Sy xorg xorg-apps xorg-xinit xorg-twm xterm xorg-xclock
pacman -S xf86-video-intel vulkan-intel 

pacman -S gnu-free-fonts ttf-hack ttf-inconsolata gnome-font-viewer
pacman -S pulseaudio pavucontrol
localectl set-x11-keymap latam


sudo pacman -Syu

sudo pacman -S git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
makepkg -si

yay -S xfce4 xfce4-goodies network-manager-applet --noconfirm 
yay -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings light-locker accountsservice  --noconfirm 

systemctl enable lightdm

pacman -S grub os-prober ntfs-3g
grub-install /dev/sda
nano /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg


exit
exit
umount -R /mnt

reboot















