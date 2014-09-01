dialog --title "Live USB disk creator" --msgbox "\nThis will install a Linux distribution to a USB drive. Press OK to start the installation" 15 55

dialog --title "Live USB disk creator" --menu "Please choose an option:" 15 55 5 1 "Take over the world" \
2 "Kick ass" \
3 "Call the cops"





dialog --infobox "Installing Linux to the USB device" 15 55 ; sleep 5

(
c=10
while [ $c -ne 110 ]
	do
		echo $c
		echo "###"
		echo "$c %"
		echo "###"
		((c+=10))
		sleep 1
done
) |
dialog --title "Live USB disk creator" --gauge "Please wait ..." 15 55 5

dialog --title "Live USB disk creator" --yesno "Are you sure you want to continue?" 15 55

dialog --infobox "Installation complete! Unmount the USB drive before removal." 15 55 ; sleep 5
