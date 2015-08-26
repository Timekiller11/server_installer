#!/bin/bash
aptitude install -y rkhunter
rkhunter --update
rkhunter --propupd #Update DB
rkhunter -c -sk #-sk removes interactive mode

