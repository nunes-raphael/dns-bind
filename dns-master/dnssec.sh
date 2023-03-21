#!/bin/bash

for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo dnssec-keygen -K /var/named -a NSEC3RSASHA1 -b 2048 -n ZONE "$i";done >> /dev/null 2>&1
for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo dnssec-keygen -K /var/named -f KSK -a NSEC3RSASHA1 -b 4096 -n ZONE $i;done >> /dev/null 2>&1
for i in $(sudo -E grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do for key in `sudo -E ls /var/named | grep K$i.*.key`; do echo -e "\$INCLUDE $key" | sudo tee -a /var/named/"$i".db;done;done >> /dev/null 2>&1
for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo zonesigner.sh $i $i.db;done >> /dev/null 2>&1
for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do echo "00       */3     *       *       /usr/sbin/zonesigner.sh $i $i.db" | sudo tee -a /var/spool/cron/root;done
sudo systemctl restart named