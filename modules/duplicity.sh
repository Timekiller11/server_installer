#!/bin/bash
sudo aptitude install duplicity gzip python python-paramiko



cat > /root/cronjobs/backup.sh << "EOF"

#!/bin/bash

#File: /root/cronjobs/backup.sh

# to backup a set of folder, put its name
# in a file in backup.d. There maybe only
# one folder per file
# - enable  the backup with 'chmod +x'
# - disable the backup with 'chmod -x'
 
FTP_URL="ftp://<login>@<server.tld>/backup"
FTP_PASS="<your ftp pass goes here>"
BK_FULL_FREQ="1M" # create a new full backup every...
BK_FULL_LIFE="6M" # delete any backup older than this
BK_KEEP_FULL="1"  # How many full+inc cycle to keep
BK_PASS="<your very secret encryption key goes here>"
 
export APT='aptitude -y'
export CONF='/root/conf'
 
################################
#        enter section
################################
 
function enter_section {
  echo ""
  echo "=============================="
  echo "$1: $2"
  echo "=============================="
}
 
################################
#         do backup
################################
 
function do_backup {
  enter_section "backing up" "$2 -> $1"
  export FTP_PASSWORD=$FTP_PASS
  export PASSPHRASE="$BK_PASS"
  duplicity --full-if-older-than $BK_FULL_FREQ $3 "$2" --asynchronous-upload "$FTP_URL/$1"
  duplicity remove-older-than $BK_FULL_LIFE --force "$FTP_URL/$1"
  duplicity remove-all-inc-of-but-n-full $BK_KEEP_FULL --force "$FTP_URL/$1"
  unset PASSPHRASE
  unset FTP_PASSWORD
}
 
################################
#      run sub-scripts
################################
 
# backup should be independant from the system state
# always make sure the required tools are ready
$APT install duplicity ncftp > /dev/null
 
for PARAM in /root/server/backup.d/*
do
  if [ -f $PARAM -a -x $PARAM ]
  then
    do_backup $(basename "$PARAM") `cat $PARAM`
  fi
done

DB_NAME=
DB_USER=
DB_PASSWORD=

mysqldump --single-transaction --routines --events --triggers --add-drop-table --extended-insert -u $(DB_USER) -h 127.0.0.1 -p$(DB_PASSWORD) db_054 | gzip -9 > /var/backups/sql/$(DB_NAME)$(date +"%H:%M_%d-%m-%Y").sql.gz

unset DB_NAME
unset DB_USER
unset DB_PASSWORD
EOF

chmod +x /root/cronjobs/backup.sh

# Run backup
/root/cronjobs/backup.sh

# Create Cronjob to run backup every 24h
crontab -l > cronTmp
echo "00 2 * * * /root/cronjobs/backup.sh" >> cronTmp
crontab cronTmp
rm cronTmp


exit 0
