#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
clear
cat <<EOF
#######################################################
#######################################################

Connect the button to:
BCM23 (pin 16) & GND (pins 9, 14, 20, 25, 30, 34, 39).

Incorrect wiring of the Raspberry Pi GPIO pins
can cause permanent damage to your Pi. You assume
all responsibility when wiring your Pi.
#######################################################
#######################################################
EOF

read -n 1 -s -r -p "Press any key to continue"
clear
echo;echo "installing safe shutdown script"

###     sudo mv $MYDIR/km4ack-shutdown /usr/local/bin/
###     sudo mv $MYDIR/km4ack-shutdown.service /lib/systemd/system/


sudo cp $MYDIR/shutdown_button /opt/bin/
sudo cp $MYDIR/shutdown_button.service /lib/systemd/system/


echo "enabling script on boot"

### sudo systemctl enable km4ack-shutdown.service
### sudo systemctl start km4ack-shutdown.service

sudo systemctl enable shutdown_button.service
sudo systemctl start shutdown_button.service
sudo systemctl status shutdown_button.service
sudo systemctl daemon-reload

#get status of service
### STATUS=$(sudo systemctl is-enabled km4ack-shutdown.service)
STATUS=$(sudo systemctl is-enabled shutdown_button.service)


cat <<EOF


Script installed and $STATUS

#######################################################
#######################################################

Connect the button to:
BCM23 (pin 16) & GND (pins 9, 14, 20, 25, 30, 34, 39).

#######################################################
#######################################################

To disable the script from running at boot, run:
sudo systemctl disable shutdown_button.service

To enable the script to run at boot, run:
sudo systemctl enable shutdown_button.service

EOF
