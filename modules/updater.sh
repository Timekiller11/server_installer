#!/bin/bash
# Install dependencies if needed.
aptitude install aptitude -y

mkdir -p /var/log/cronjobs/updates

cat > /root/cronjobs/update.sh << "EOF"
#!/bin/bash
DATE=`date +%Y-%m-%d:%H:%M:%S`
LOGS="/var/log/cronjobs/updates/"$DATE

touch $LOGS
{
    printf "Updating\n"
    sudo aptitude update
    printf "\n"
    printf "\n"
    printf "Installing upgrades (safe-upgrade)\n"
    sudo aptitude safe-upgrade -y
    printf "\n"
    printf "\n"
    sudo aptitude update
    printf "\n"
    printf "\n"
    printf "Cleaning up\n"
    sudo aptitude autoclean -y
} > $LOGS
EOF

chmod +x /root/cronjobs/update.sh

# Run Updates
/root/cronjobs/update.sh


# Create Cronjob to run updates every 24h
crontab -l > cronTmp
echo "00 00 * * * /root/cronjobs/update.sh" >> cronTmp
crontab cronTmp
rm cronTmp
