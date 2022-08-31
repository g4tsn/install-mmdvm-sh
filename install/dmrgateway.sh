#!/bin/sh
PATH_RUN_SCRIPT=$1
LOG_PATH_DMRGATEWAY=$2
CONFIG_PATH_DMRGATEWAY=$3
PATH_EXEC=$4
N_CPU=$5

	git clone https://github.com/g4klx/DMRGateway.git /home/pi/MMDVM/DMRGateway
sleep 2
        
	cd /home/pi/MMDVM/DMRGateway/
	git reset --hard 42afea8527728b95eb719cc27d79e47d4bf1c030
	make clean
	echo 'Compile  DMRGateway...'
	if [ $N_CPU = "0" ]; then
		make
	else
		make -j$N_CPU all
	fi
        cp -R /opt/install-mmdvm-sh/install/DMRGateway.ini /home/pi/MMDVM/DMRGateway/DMRGatway.ini
	cp -R /opt/install-mmdvm-sh/install/DMRGateway.ini /etc/dmrgateway/DMRGateway.ini
	cp -R /home/pi/MMDVM/DMRGateway/DMRGateway ${PATH_EXEC}
	mkdir -p ${CONFIG_PATH_DMRGATEWAY}
	mkdir -p ${LOG_PATH_DMRGATEWAY}
	chmod -R 777 ${CONFIG_PATH_DMRGATEWAY}
	chmod -R 777 ${LOG_PATH_DMRGATEWAY}

	# sed -i 's,FilePath=.,FilePath=${LOG_PATH_DMRGATEWAY},g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,FileLevel=1,FileLevel=0,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,# Port=/dev/ttyACM0,Port=/dev/ttyAMA0,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
	# sed -i 's,Port=\\.\COM3,# Port=\\.\COM3,g' ${CONFIG_PATH_DMRGATEWAY}MMDVM.ini
        cp /opt/install-mmdvm-sh/install/DMRGateway.ini /etc/dmrgateway/DMRGateway.ini
	
	nano /etc/dmrgateway/DMRGateway.ini

	#cp -R /home/pi/MMDVM/DMRGateway/DMRGateway.ini ${CONFIG_PATH_DMRGATEWAY}
	cp -R /home/pi/MMDVM/DMRGateway/XLXHosts.txt ${LOG_PATH_DMRGATEWAY}
	cp -R /home/pi/MMDVM/DMRGateway/Audio ${CONFIG_PATH_DMRGATEWAY}
	cp -R /opt/install-mmdvm-sh/service/dmrgateway.service /lib/systemd/system/
	cp -R /opt/install-mmdvm-sh/service/dmrgateway.timer /lib/systemd/system/
	chmod 755 /lib/systemd/system/dmrgateway.service	
	chmod 755 /lib/systemd/system/dmrgateway.timer
	systemctl enable dmrgateway.service
	systemctl enable dmrgateway.timer
exit 0
