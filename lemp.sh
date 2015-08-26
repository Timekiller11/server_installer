#!/bin/bash
if [ $(id -u) != "0" ]; then
    printf "Error: You have to login by user root!\n"
    exit
fi
# Variables.
HOSTNAME="cserver.me"


# Create update script for cron job
mkdir -p /root/cronjobs


# Dependencies and desired softwares
aptitude install -y build-essential
aptitude install -y python-software-properties
aptitude install -y libdate-manip-perl


. modules/composer.sh
. modules/nmap.sh
. modules/git.sh
. modules/curl.sh


# Create website directory
mkdir -p /var/www


. modules/mariadb.sh
. modules/nginx.sh
. modules/php.sh



# Securing the server
. modules/secure_host.sh
. modules/secure_shared.sh
. modules/secure_sysctl.sh

# Installing security appliances
. modules/apparmor.sh
. modules/chkrootkit.sh
. modules/fail2ban.sh
. modules/iwatch.sh
. modules/logwatch.sh
. modules/rkhunter.sh
. modules/tiger.sh

# Installing Firewall
. modules/ufw.sh

. modules/psad.sh



