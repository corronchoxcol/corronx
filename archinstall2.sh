 #!/bin/bash
 
 nano /etc/locale.gen

 locale-gen

 echo LANG=es_CL.UTF-8 > /etc/locale.conf

 export LANG=es_CL.UTF-8

 ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime

 hwclock -w

 echo hpprobook > /etc/hostname

 echo -e 127.0.0.1  localhost \n::1 localhost \n127.0.1.1   hpprobook.localdomain hpprobook >> /etc/localhosts

 useradd -m -g users -G wheel -s /bin/bash jose

 passwd jose

 nano /etc/sudoers
 
 pacman -S dhcp dhcpcd networkmanager iwd

 systemctl enable dhcpcd NetworkManager
 
 pacman -Sy reflector

 reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

 pacman -S grub os-prober ntfs-3g

 os-prober

 grub-install --target=i386-pc /dev/sda
 
 nano /etc/default/grub
 
 grub-mkconfig -o /boot/grub/grub.cfg

 pacman -Syu

 pacman -S xdg-user-dirs

 xdg-user-dirs-update

 pacman -S gnu-free-fonts ttf-hack ttf-inconsolata noto-fonts-emoji

 pacman -S neofetch lsb-release git wget 

 pacman -S xf86-video-intel vulkan-intel lib32-vulkan-intel vulkan-tools mesa lib32-mesa

 pacman -S pulseaudio pulseaudio-alsa pamixer pavucontrol

 pacman -Sy xorg xorg-apps xorg-xinit xorg-twm xterm xorg-xclock

 pacman -S xfce4 xfce4-goodies network-manager-applet lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings light-locker accountsservice

 sudo systemctl enable lightdm.service

 exit

 exit 

 reboot