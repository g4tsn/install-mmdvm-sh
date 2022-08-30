#!/bin/sh

	echo 'install dashboard....'

	git clone https://github.com/dg9vh/MMDVMHost-Dashboard.git /var/www/html/MMDVMHost-Dashboard

        c383e537e55a22d237cfcd82641d82f35d195a32
	groupadd www-data
	usermod -G www-data -a pi
	chown -R www-data:www-data /var/www/html
	chmod -R 775 /var/www/html
	
	apt-get install php7.3-common php7.3-cgi php
	apt-get install sqlite3 php7.3-sqlite
	
	lighty-enable-mod fastcgi
	lighty-enable-mod fastcgi-php
	service lighttpd force-reload
	
exit 0
