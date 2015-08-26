#!/bin/bash
if [ $(id -u) != "0" ]; then
    printf "Error: You have to login by user root!\n"
    exit
fi
# Variables.
HOSTNAME="cserver.me"

echo "Create directories"
echo "cron job"
mkdir -p /root/cronjobs
echo "websites"
mkdir -p /var/www


echo "Dependencies"
echo "build-essential"
aptitude install -y build-essential >/dev/null 2>&1
echo "python-software-properties"
aptitude install -y python-software-properties >/dev/null 2>&1
echo "libdate-manip-perl"
aptitude install -y libdate-manip-perl >/dev/null 2>&1

echo "Securing the server"
echo "hots"
. modules/secure_host.sh >/dev/null 2>&1
echo "shared"
. modules/secure_shared.sh >/dev/null 2>&1
echo "syctl"
. modules/secure_sysctl.sh >/dev/null 2>&1


echo "Installing softwares"
echo "nmap"
. modules/nmap.sh >/dev/null 2>&1
echo "git"
. modules/git.sh >/dev/null 2>&1
echo "curl"
. modules/curl.sh >/dev/null 2>&1
echo "php"
. modules/php.sh >/dev/null 2>&1
echo "mariadb"
. modules/mariadb.sh >/dev/null 2>&1
echo "nginx"
. modules/nginx.sh >/dev/null 2>&1
echo "composer"
. modules/composer.sh >/dev/null 2>&1


echo "Installing security appliances"
echo "apparmor"
. modules/apparmor.sh >/dev/null 2>&1
echo "chkrootkit"
. modules/chkrootkit.sh >/dev/null 2>&1
echo "fail2ban"
. modules/fail2ban.sh >/dev/null 2>&1
echo "psad"
. modules/psad.sh >/dev/null 2>&1
#echo ""
#. modules/iwatch.sh >/dev/null 2>&1
echo "logwatch"
. modules/logwatch.sh >/dev/null 2>&1
echo "rkhunter"
. modules/rkhunter.sh >/dev/null 2>&1
#echo "tiger"
#. modules/tiger.sh >/dev/null 2>&1

echo "Installing Firewall"
echo "UFW"
. modules/ufw.sh >/dev/null 2>&1



