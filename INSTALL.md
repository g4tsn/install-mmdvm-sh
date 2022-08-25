
# INSTALL MMDVM Raspberry PI on Raspbian 10 (Buster)        


Download the package from the terminal using the command:  if you are root user forget the sudo 

	cd /opt
        
	git clone https://github.com/g4tsn/install-mmdvm-sh.git ./install-mmdvm-sh
	
	cd install-mmdvm-sh

	Launch the script using the command
	
	sudo sh mmdvm.sh
	
	you will have several options to install or not answer y/n
	
	the first option is for direct attached display always choose n for this option library missing 
	
	for dmr only installation choose y for mmdvmhost dmrgateway and dashboard 

	wait for the installation to end ....
	
Config  This script allows you to final edit config files 
	
	
	Make sure you are always in the same direcory /opt/install-mmdvm-sh/ and open the file using the command
	
	sudo nano MMDVMConfig.sh    
	
	you can do this over and over to check config and edit anything you need but be sure to run the script once you edit something 
	
	check your config files look ok and change your callsign DMR id etc 
	
	once you check to the end Ctrl X will prompt you to save changes you made and open the next section  
	
	again check for any changes you want to make scroll to the end Ctrl X will prompt to save and the next section will open 
	
	if you have not configured a section because you did not install for example YSF  CTRL X at the end will take you straight to the next section
		
	
	Once saved all sections,  run the script
	
	sudo bash MMDVMConfig.sh
	
	Make sure you run above after any edit to copy the changes into place 
	
	This copies all the config files into their correct place in /etc/mmdvmhost/MMDVM.ini     for example

Uninstall by command

	sudo mmdvm_uninstall.sh

# Start commands by servicing

MMDVMHost

	sudo service mmdvmhost start
	
	sudo service mmdvmhost stop
	
	sudo service mmdvmhost restart
	
	sudo service mmdvmhost status
	
DMRGateway

	sudo service dmrgateway start
	
	sudo service dmrgateway stop
	
	sudo service dmrgateway restart
	
	sudo service dmrgateway status


YSFGateway

	sudo service ysfgateway start
	
	sudo service ysfgateway stop
	
	sudo service ysfgateway restart
	
	sudo service ysfgateway status

YSFParrot

	sudo service ysfparrot start
	
	sudo service ysfparrot stop
	
	sudo service ysfparrot restart
	
	sudo service ysfparrot status

IrcDDBGateway

	sudo service ircddbgatewayd start
	
	sudo service ircddbgatewayd stop
	
	sudo service ircddbgatewayd restart
	
	sudo service ircddbgatewady status

# Command for automatic start of service
	sudo systemctl enable mmdvmhost.timer
	sudo systemctl enable dmrgateway.timer
	sudo systemctl enable ysfgateway.timer
	sudo systemctl enable ysfparrot.timer
	sudo systemctl enable ircddbgatewayd.timer
	sudo systemctl enable telegrambot.timer

# Disable service at startup
	sudo systemctl disable <nome_servizio>.timer

# Connect to Screen Output of a service to see what is happening 
   
   sudo screen -r MMDVMHost
   
   Ctrl a then d to disconnect from screen and keep the service running

# Connect to Screen Output of a service to see what is happening 
   
   sudo screen -r DMRGateway
 
   Ctrl a then d to disconnect from screen and keep the service running


# Starting shell programs
Remember to stop the service

	MMDVMHost
	sudo MMDVMHost /etc/mmdvmhost/MMDVM.ini
	
	DMRGateway
	sudo DMRGateway /etc/dmrgateway/DMRGateway.ini

	YSFGateway
	sudo DMRGateway /etc/dmrgateway/DMRGateway.ini
	
	ircDBGateway
	sudo ircddbgatewayd -logdir /var/log/ircddbgateway -confdir /etc/ircddbgateway

	Telegrambot
	sudo python /home/pi/telegrambot.py
	
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


