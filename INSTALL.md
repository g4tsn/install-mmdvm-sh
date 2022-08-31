
# INSTALL MMDVM Raspberry PI on Raspbian 10 (Buster)        

First prepare SD card for PI 

Download the Raspberry pi Buster 10 OS lite img

Write this to your SD card via SD card reader and suitable program of choice   (win32 disk imager)
find the drive letter in windows asigned to the /boot folder on the SD card in windows mine is H:

open a cmd prompt in windows change to drive letter of /boot folder    H:

copy con ssh
F6  

This allows the pi to accept ssh connections via putty without attaching a screen

connect pi to network and insert created SD card

boot up and find the IP assigned to your pi by your router 

login as pi  password raspberry

create password root with following command
sudo passwd root

enter password twice for root ...

edit the sshd_config file with following command 

sudo nano /etc/ssh/sshd_config

look for following line about 20 lines down from top  
#PermitRootLogin ????????
edit to read

PermitRootLogin yes

save

Ctrl X    then Y to save

re boot pi 

sudo reboot

login again via ssh this time as root and the password you set


Now the install part of the MMDVM software 


Issue the following commands assuming you are logged in as root user and your pi is connnected to the internet


	cd /opt
	
        apt-get update
	
	apt-get install git
	
	apt-get install screen
	
	git clone https://github.com/g4tsn/install-mmdvm-sh.git ./install-mmdvm-sh
	
	cd install-mmdvm-sh

	Launch the script using the command
	
	sh mmdvm.sh
	
	you will have several options to install or not answer y/n
	
	the second option is for direct attached display always choose n for this option library missing 
	
	for dmr only installation choose y for mmdvmhost dmrgateway and dashboard 

	wait for the installation to complete.
		
	
	During the install nano editor will allow you to edit your config files change your callsign DMR id etc 
	
	once you have done the edit Ctrl X  and Y to save the build will continue  
			
	All the config files into their correct place in /etc/mmdvmhost/MMDVM.ini  
	
	or /etc/dmrgateway/DMRGateway.ini 
	
	After intallation you can go back and further edit your config 



Uninstall by command

	mmdvm_uninstall.sh

# Start commands by servicing

MMDVMHost

	systemctl start mmdvmhost 
	
	systemctl stop mmdvmhost 
	
	systemctl restart mmdvmhost restart
	
	systemctl status mmdvmhost 
	
DMRGateway

	systemctl start dmrgateway 
	
	systemctl stop dmrgateway 
	
	systemctl restart dmrgateway 
	
	systemctl status dmrgateway 


YSFGateway

	service ysfgateway start
	
	service ysfgateway stop
	
	service ysfgateway restart
	
	service ysfgateway status

YSFParrot

	service ysfparrot start
	
	service ysfparrot stop
	
	service ysfparrot restart
	
	service ysfparrot status

IrcDDBGateway

	service ircddbgatewayd start
	
	service ircddbgatewayd stop
	
	service ircddbgatewayd restart
	
	service ircddbgatewady status

# Command for automatic start of service
	systemctl enable mmdvmhost.timer
	systemctl enable dmrgateway.timer
	systemctl enable ysfgateway.timer
	systemctl enable ysfparrot.timer
	systemctl enable ircddbgatewayd.timer
	systemctl enable telegrambot.timer

# Disable service at startup
	systemctl disable <name of service>.timer

# Connect to Screen Output of a service to see what is happening  
   
   screen -r MMDVMHost
   
   Ctrl a then d to disconnect from screen and keep the service running

# Connect to Screen Output of a service to see what is happening 
   
   screen -r DMRGateway
 
   Ctrl a then d to disconnect from screen and keep the service running


# Starting shell programs for more detailed diagnostics 
This is useful initially to check whats happening on startup ......Remember to stop the service first

	MMDVMHost
	MMDVMHost /etc/mmdvmhost/MMDVM.ini
	
	DMRGateway
	DMRGateway /etc/dmrgateway/DMRGateway.ini

	YSFGateway
	YSFGateway /etc/ysfgateway/YSFGateway.ini
	
	ircDBGateway
	ircddbgatewayd -logdir /var/log/ircddbgateway -confdir /etc/ircddbgateway
	
CTRL+C to exit

# Add crontab service

sudo nano /etc/crontab
 
add at the bottom of the file

	*/5 *   * * *   root    wget -O /var/log/ysfgateway/YSFHosts.txt http://register.ysfreflector.de/export_csv.php
	 0 0    * * *   root    wget -O /var/log/mmdvmhost/NXDN.csv http://nxmanager.weebly.com/uploads/7/1/2/0/71209569/nxuid_export.csv
	 0 0    * * *   root    sh /home/pi/script/DMRIDUpdate.sh 1>/dev/null 2>&1
	 
	 
# File paths

MMDVMHost

	MMDVM.ini
	
	/etc/mmdvmhost/	
	
	LOG file e data base
	
	/var/log/mmdvmhost/

DMRGateway

	DMRGateway.ini

	/etc/dmrgateway/

	LOG file e data base

	/var/log/dmrgateway/

YSFgateway

	YSFGateway.ini

	/etc/ysfgateway/

	LOG file e data base

	/var/log/ysfgateway/

ircDDBGateway

	ircddbgateway_config

	/etc/ircddbgateway/

	LOG file e data base

	/var/log/ircddbgateway/
	
	AUDIO File and Reflector list
	
	/usr/share/ircddbgateway


