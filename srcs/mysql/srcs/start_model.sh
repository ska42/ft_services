#!/bin/sh

mysql_install_db --user=__DB_USER__
tmp=sql_tmp

echo -ne "FLUSH PRIVILEGES;\n
GRANT ALL PRIVILEGES ON *.* TO '__DB_USER__'@'%' IDENTIFIED BY '__DB_PASSWORD__' WITH GRANT OPTION;\n
FLUSH PRIVILEGES;\n" >> $tmp 

/usr/bin/mysqld --user=__DB_USER__ --bootstrap --verbose=0 < $tmp
rm -rf $tmp

exec /usr/bin/mysqld --user=__DB_USER__
