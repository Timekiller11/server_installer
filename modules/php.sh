#!/bin/bash
# PHP
apt-get install -y php5-fpm
apt-get install -y php5-cli
apt-get install -y php5-mysql
apt-get install -y php5-curl
apt-get install -y php5-gd
apt-get install -y php5-mcrypt

# Install mcrypt (Needed for Ubuntu)
php5enmod mcrypt

cat /etc/php5/fpm/php.ini | sed -e "s/.*;cgi.fix_pathinfo=1.*/cgi.fix_pathinfo=0/" > /etc/php5/fpm/php.ini.1
cat /etc/php5/fpm/php.ini.1 | sed -e "s/.*post_max_size.*/post_max_size = 8M/" > /etc/php5/fpm/php.ini.2
cat /etc/php5/fpm/php.ini.2 | sed -e "s/.*upload_max_filesize.*/upload_max_filesize = 8M/" > /etc/php5/fpm/php.ini.3
cat /etc/php5/fpm/php.ini.3 | sed -e "s/.*max_file_uploads.*/max_file_uploads = 5/" > /etc/php5/fpm/php.ini.4
cat /etc/php5/fpm/php.ini.4 | sed -e "s/.*expose_php.*/expose_php = off/" > /etc/php5/fpm/php.ini.new
mv /etc/php5/fpm/php.ini.new /etc/php5/fpm/php.ini.conf
# Remove for debugging
rm /etc/php5/fpm/php.ini.1
rm /etc/php5/fpm/php.ini.2
rm /etc/php5/fpm/php.ini.3
rm /etc/php5/fpm/php.ini.4

# Reload PHP
service php5-fpm restart
