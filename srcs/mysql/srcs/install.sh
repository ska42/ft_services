#!/bin/bash

apk upgrade
apk add mysql --no-cache

mysql_install_db --user=mysql

echo -ne "FLUSH PRIVILEGES;\n 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;" | mysqld --user=mysql --bootstrap --verbose=0

sleep(5);

mysqld --user=mysql --console
