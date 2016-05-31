#!/bin/sh

echo "NOTE: This script is meant to install printers in shared areas."
echo "      This means office printers and label printers are not part of this list (e.g. toad, launchpad, 9th 105SL,  etc)."
echo "      Since the label and office printers are only needed by certain users, you will need to add them to their computers manually."

echo
echo "[------------INSTALL AN INDIVIDUAL PRINTER------------]"
echo "| ech1-1	 ech2-1   ech3-1   crc1-1   crc2-1   crc3-1 |"
echo "| ech1-2   ech2-2   ech3-2   crc1-2   crc2-2   crc3-2 |"
echo "[-----------------------------------------------------]"
echo
echo "[--------------INSTALL PRINTERS BY GROUPS-------------]"
echo "| ech1          ech2          ech3                    |"
echo "| crc1          crc2          crc3                    |"
echo "| allgsc        allech        allcrc                  |"
echo "[-----------------------------------------------------]"
echo

#list for individual printers to be compared to later on
iprinters=(ech1-1 ech1-2 ech2-1 ech2-2 ech3-1 ech3-2 crc1-1 crc1-2 crc2-1 crc2-2 crc3-1 crc3-2)

#list for group printers to be compared to later on
gprinters=(ech1 ech2 ech3 crc1 crc2 crc3 allgsc allech allcrc)

#initialize array for printer groups
ech1=(ech1-1 ech1-2)
ech2=(ech2-1 ech2-2)
ech3=(ech3-1 ech3-2)
crc1=(crc1-1 crc1-2)
crc2=(crc2-1 crc2-2)
crc3=(crc3-1 crc3-2)
allgsc=(ech1-1 ech1-2 ech2-1 ech2-2 ech3-1 ech3-2 crc1-1 crc1-2 crc2-1 crc2-2 crc3-1 crc3-2)
allech=(ech1-1 ech1-2 ech2-1 ech2-2 ech3-1 ech3-2)
allcrc=(crc1-1 crc1-2 crc2-1 crc2-2 crc3-1 crc3-2)

while true
do
	echo "-----Choose 'individual' or 'group'"
	read type
	echo
	if [ $type = "individual" -o $type = "group" ] ; then
		break
	else
		echo "~Not a valid option!"
		continue
	fi
done

p2_install=() #array for the list of printers that need to be installed

case "$type" in
	#installing invidiual printers
	individual)
	while true
	do
		echo "-----Type in the name of the printer you want to install"
		read printer
		for i in "${iprinters[@]}"
		do
		if [ $printer = $i ] ; then
			p2_install=("${p2_install[@]}" $printer)
			echo "~Do you want to install more printers? ('y' for yes, anything else for no)"
			read ans
			if [[ $ans = "y" ]] ; then
				continue 2
			else
				break 5
			fi
		fi
		done
		echo "~Not a valid printer name!"
	done
	;;

	#installing printers by groups
	group)
	g2_install=() #initializing empty group printer arrays which will be converted to individual printers later on
	while true
        do
                echo "-----Type in the printer group you want to install"
                read printer
                for i in "${gprinters[@]}"
                do
                if [ $printer = $i ] ; then
                        g2_install=("${g2_install[@]}" $printer)
			echo "~Do you want to install more groups? ('y' for yes, anything else for no)"
			read ans
			if [[ $ans = "y" ]] ; then
				continue 2
			else
                        	break 4
			fi
                fi
                done
                echo "~Not a valid printer group!"
        done
	;;
esac

#converting group list into individual printers to make installing easier
if [ $type = "group" ] ; then
	for i in "${g2_install[@]}"
	do
		case "$i" in
		ech1) p2_install=("${p2_install[@]}" "${ech1[@]}")
		;;
		ech2) p2_install=("${p2_install[@]}" "${ech2[@]}")
		;;
		ech3) p2_install=("${p2_install[@]}" "${ech3[@]}")
		;;
		crc1) p2_install=("${p2_install[@]}" "${crc1[@]}")
		;;
		crc2) p2_install=("${p2_install[@]}" "${crc2[@]}")
    ;;
		crc3) p2_install=("${p2_install[@]}" "${crc3[@]}")
    ;;
		allech) p2_install=("${p2_install[@]}" "${allech[@]}")
		;;
		allcrc) p2_install=("${p2_install[@]}" "${allcrc[@]}")
		;;
		allgsc) p2_install=("${p2_install[@]}" "${allgsc[@]}")
		;;
		esac
	done
fi

echo "-----Installing Printer(s)"

for i in "${p2_install[@]}"
do
	case "$i" in
	ech1-1)
		  	 echo "~Installing $i ..."
		  	 /usr/sbin/lpadmin -p ech1-1 -E -o printer-is-shared=false -L ECH-1st-Floor -v lpd://server/ech1-1 -P /etc/cups/ppd/ech1-1.ppd
  		 	 ;;
  ech1-2)
				 echo "~Installing $i ..."
				 /usr/sbin/lpadmin -p ech1-2 -E -o printer-is-shared=false -L ECH-1st-Floor -v lpd://server/ech1-2 -P /etc/cups/ppd/ech1-2.ppd
         ;;
	ech2-1)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p ech2-1 -E -o printer-is-shared=false -L ECH-2nd-Floor -v lpd://server/ech2-1 -P /etc/cups/ppd/ech2-1.ppd
			   ;;
	ech2-2)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p ech2-2 -E -o printer-is-shared=false -L ECH-2nd-Floor -v lpd://server/ech2-2 -P /etc/cups/ppd/ech2-2.ppd
			   ;;
	ech3-1)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p ech3-1 -E -o printer-is-shared=false -L ECH-3rd-Floor -v lpd://server/ech3-1 -P /etc/cups/ppd/ech3-1.ppd
	 		 	 ;;
  ech3-2)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p ech3-2 -E -o printer-is-shared=false -L ECH-3rd-Floor -v lpd://server/ech3-2 -P /etc/cups/ppd/ech3-2.ppd
			   ;;
	crc1-1)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p crc1-1 -E -o printer-is-shared=false -L CRC-1st-Floor -v lpd://server/crc1-1 -P /etc/cups/ppd/crc1-1.ppd
		  	 ;;
	crc1-2)
			 	 echo "~Installing $i ..."
				 /usr/sbin/lpadmin -p crc1-2 -E -o printer-is-shared=false -L CRC-1st-Floor -v lpd://server/crc1-2 -P /etc/cups/ppd/crc1-2.ppd
			   ;;
	crc2-1)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p crc2-1 -E -o printer-is-shared=false -L CRC-2nd-Floor -v lpd://server/crc2-1 -P /etc/cups/ppd/crc2-1.ppd
			   ;;
	crc2-2)
			 	 echo "~Installing $i ..."
		   	 /usr/sbin/lpadmin -p crc2-2 -E -o printer-is-shared=false -L CRC-2nd-Floor -v lpd://server/crc2-2 -P /etc/cups/ppd/ech2-2.ppd
	  	   ;;
	crc3-1)
			 	 echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p crc3-1 -E -o printer-is-shared=false -L CRC-3rd-Floor -v lpd://server/crc3-1 -P /etc/cups/ppd/crc3-1.ppd
			 	 ;;
	crc3-2)
			   echo "~Installing $i ..."
			 	 /usr/sbin/lpadmin -p crc3-2 -E -o printer-is-shared=false -L CRC-3rd-Floor -v lpd://server/crc3-2 -P /etc/cups/ppd/crc3-2.ppd
			   ;;
	esac
	echo " .... done"
done

echo "-----Finished"
