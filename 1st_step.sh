uci set network.lan.ipv6='off'
uci set dhcp.lan.dhcpv6='disabled'
uci delete network.globals.ula_prefix
sysctl -w net.ipv6.conf.all.disable_ipv6=1
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
opkg update && opkg install block-mount kmod-fs-ext4 kmod-usb-storage e2fsprogs kmod-usb-ohci kmod-usb-uhci fdisk
DEVICE="$(awk -e '/\s\/overlay\s/{print $1}' /etc/mtab)"
uci -q delete fstab.rwm
uci set fstab.rwm="mount"
uci set fstab.rwm.device="${DEVICE}"
uci set fstab.rwm.target="/rwm"
uci commit fstab
mkfs.ext4 /dev/sda1 ## look at the disks using the command ls -l /dev/ and then disconnect the disk and run the command again, if a disk disappears and appears different from the one in the command, change /dev/sda1 to your disk
DEVICE="/dev/sda1" ## look at the disks using the command ls -l /dev/ and then disconnect the disk and run the command again, if a disk disappears and appears different from the one in the command, change /dev/sda1 to your disk
eval $(block info "${DEVICE}" | grep -o -e "UUID=\S*")
uci -q delete fstab.overlay
uci set fstab.overlay="mount"
uci set fstab.overlay.uuid="${UUID}"
uci set fstab.overlay.target="/overlay"
uci commit fstab
mount /dev/sda1 /mnt  ## look at the disks using the command ls -l /dev/ and then disconnect the disk and run the command again, if a disk disappears and appears different from the one in the command, change /dev/sda1 to your disk
cp -a -f /overlay/. /mnt
umount /mnt
reboot
