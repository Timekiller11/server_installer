#!/bin/bash
# Dependencies
aptitude install -y fail2ban
# Change de default action line
cat /etc/fail2ban/jail.conf | sed -e "s/action = %(action_)s/action = %(action_mwl)s/" > /etc/fail2ban/jail.conf.new
mv /etc/fail2ban/jail.conf.new /etc/fail2ban/jail.conf

fail2ban-client set ssh bantime 604800
fail2ban-client set ssh findtime 3600

