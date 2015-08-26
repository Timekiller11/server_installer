#!/bin/bash

# Random Root password (512 bits by default)
PASSWORDMYSQL=$(tr -dc "[:alpha:]" < /dev/urandom | head -c 512)
    
# Installation de MariaDB as SQL server
echo 'mariadb-server mysql-server/root_password password '$PASSWORDMYSQL | debconf-set-selections
echo 'mariadb-server mysql-server/root_password_again password '$PASSWORDMYSQL | debconf-set-selections
echo 'mariadb-server-5.5	mariadb-server/oneway_migration	boolean	true' | debconf-set-selections

apt-get install -y mariadb-server
apt-get install -y mariadb-client


OUTPUT="MYSQL_ROOT_SHREDME"

touch $OUTPUT
{
    echo "------------------------------------------"
    echo " Mariadb was installed successfully "
    echo "------------------------------------------"
    echo ""
    echo " DB Username : root"
    echo " DB Password : ${PASSWORDMYSQL}"
    echo ""
    echo "------------------------------------------"
} > $OUTPUT

