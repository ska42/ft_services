#!/bin/sh
mkdir -p /run/mysqld

mysql_install_db --user=root
tmp=sql_tmp

echo -ne "FLUSH PRIVILEGES;\n
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;\n
FLUSH PRIVILEGES;\n" >> $tmp 

/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tmp
rm -rf $tmp

exec /usr/bin/mysqld --user=root
