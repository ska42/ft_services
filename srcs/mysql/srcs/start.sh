#!/bin/sh
mkdir -p /run/mysqld

mysql_install_db --user=root
tfile=sql_temp
	cat << EOF > $tfile
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
EOF

echo 'FLUSH PRIVILEGES;' >> $tfile

/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile

sleep 5;

exec /usr/bin/mysqld --user=root --console
