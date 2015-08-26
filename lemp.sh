#!/bin/bash
if [ $(id -u) != "0" ]; then
    printf "Error: You have to login by user root!\n"
    exit
fi
# Variables.
HOSTNAME="cserver.me"


# Create update script for cron job
mkdir -p /root/cronjobs


echo "Dependencies and desired softwares"

aptitude install -y build-essential &> /dev/null
aptitude install -y python-software-properties &> /dev/null
aptitude install -y libdate-manip-perl &> /dev/null



. modules/composer.sh &> /dev/null
. modules/nmap.sh &> /dev/null
. modules/git.sh &> /dev/null
. modules/curl.sh &> /dev/null


# Create website directory
mkdir -p /var/www


. modules/mariadb.sh &> /dev/null
. modules/nginx.sh &> /dev/null
. modules/php.sh &> /dev/null



# Securing the server
. modules/secure_host.sh &> /dev/null
. modules/secure_shared.sh &> /dev/null
. modules/secure_sysctl.sh &> /dev/null

# Installing security appliances
. modules/apparmor.sh &> /dev/null
. modules/chkrootkit.sh &> /dev/null
. modules/fail2ban.sh &> /dev/null
. modules/iwatch.sh &> /dev/null
. modules/logwatch.sh &> /dev/null
. modules/rkhunter.sh &> /dev/null
. modules/tiger.sh &> /dev/null

# Installing Firewall
. modules/ufw.sh &> /dev/null

. modules/psad.sh &> /dev/null



