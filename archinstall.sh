#!/bin/bash

pacman -Sy reflector python --noconfirm

reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel nano

pacstrap /mnt linux linux-firmware linux-headers mkinitcpio

pacstrap /mnt xf86-input-libinput

genfstab -p /mnt >> /mnt/etc/fstab



