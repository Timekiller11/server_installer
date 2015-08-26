#!/bin/bash
# PSAD
echo "postfix postfix/main_mailer_type select Internet Site" | sudo debconf-set-selections
echo "postfix postfix/mailname string `$HOSTNAME`" | sudo debconf-set-selections
apt-get install -y psad

# Change de default action line
cat /etc/psad/psad.conf | sed -e "s/\s*HOSTNAME.*/HOSTNAME $HOSTNAME;/" > /etc/psad/psad.conf.new1
cat /etc/psad/psad.conf.new1 | sed -e "s/\s*SYSLOG_DAEMON.*/SYSLOG_DAEMON syslog-ng;/" > /etc/psad/psad.conf.new
mv /etc/psad/psad.conf.new /etc/psad/psad.conf
rm /etc/psad/psad.conf.new1

# Run updates
psad --sig-update
psad -H 
psad --Status
