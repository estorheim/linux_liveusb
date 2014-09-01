#!/bin/bash

# Locate the USB storage devices connected to the computer.
export USBKEYS=($(
    grep -Hv ^0$ /sys/block/*/removable |
    sed s/removable:.*$/device\\/uevent/ |
    xargs grep -H ^DRIVER=sd |
    sed s/device.uevent.*$/size/ |
    xargs grep -Hv ^0$ |
    cut -d / -f 4
))

# Show a graphical menu which allows the user to 
# select the proper USB stick for installation.
export STICK
case ${#USBKEYS[@]} in
    0 ) echo No USB Stick found; exit 0 ;;
    #1 ) STICK=$USBKEYS ;;
    * )
    STICK=$(
    bash -c "$(
        echo -n  dialog --menu \
            \"Choose which USB stick to install Kali Linux on\" 22 76 17;
        for dev in ${USBKEYS[@]} ;do
            echo -n \ $dev \"$(
                sed -e s/\ *$//g </sys/block/$dev/device/model
                )\" ;
            done
        )" 2>&1 >/dev/tty
    )
    ;;
esac

[ "$STICK" ] || exit 0

pdrive=$STICK\3
echo $pdrive

# Start the installation of Kali Linux.
isoname=kali-linux-1.0.8-amd64.iso

echo $isoname

# Display a warning:
echo "This will write $isoname to /dev/$STICK"


#dd if=$isoname of=/dev/$STICK bs=1M

#size=5gb
#read bytes _ < <(du -bcm $isoname |tail -1); echo $bytes 
#parted /dev/$STICK mkpart primary $bytes $size
#mkfs.ext3 -L persistence /dev/$pdrive
#e2label /dev/$pdrive persistence
#mkdir -p /mnt/my_usb
#mount /dev/$pdrive /mnt/my_usb
#echo "/ union" > /mnt/my_usb/persistence.conf
#umount /dev/$pdrive


counter=0
(
# set infinite while loop
while :
do
cat <<EOF
XXX
$counter
Disk copy /dev/dvd to /home/data ( $counter%):
XXX
EOF
# increase counter by 10
(( counter+=10 ))
[ $counter -eq 100 ] && break
# delay it a specified amount of time i.e 1 sec
sleep 1
done
) |
dialog --keep-tite --title "File Copy" --gauge "Please wait" 7 70 0

dialog --title "Delete file" \
--backtitle "Linux Shell Script Tutorial Example" \
--yesno "Are you sure you want to permanently delete \"/tmp/foo.txt\"?" 7 60
 
# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) echo "File deleted.";;
   1) echo "File not deleted.";;
   255) echo "[ESC] key pressed.";;
esac
