#!/bin/bash

sudo systemctl stop named
sudo systemctl enable named

sudo mv /etc/named.conf /etc/named.conf_ORIG
sudo cp /vagrant/dns-master/named.conf /etc/named.conf
sudo cp /vagrant/dns-master/named.conf.local /etc/named/named.conf.local
sudo cp /vagrant/dns-master/zonesigner.sh /usr/sbin/zonesigner.sh
sudo cp /vagrant/dns-master/check_bind.sh /root/check_bind.sh
sudo cp /vagrant/dns-master/192.168.0.db /var/named/192.168.0.db
sudo cp /vagrant/dns-master/dcing.corp.db /var/named/dcing.corp.db
sudo cp /vagrant/dns-master/docker.example.db /var/named/docker.example.db

sudo mkdir /var/log/bind/
sudo touch /var/log/bind/example.log
sudo chown -R named:named /var/log/bind/
sudo chmod 640 /etc/named.conf 
sudo chmod 644 /etc/named/named.conf.local
sudo chmod 755 /usr/sbin/zonesigner.sh
sudo chmod 777 /root/check_bind.sh
sudo chmod 644 /var/named/dcing.corp.db.signed
[ "$?" == 0 ] && sudo systemctl start named
sudo chmod 644 /var/named/192.168.0.db
sudo chmod 644 /var/named/dcing.corp.db
sudo chmod 644 /var/named/docker.example.db
sudo chown root:named /etc/named.conf
grep "check_bind.sh" /root/.bash_profile 2>&1 > /dev/null
[ "$?" == 1 ] && sudo echo "/root/check_bind.sh" | sudo tee -a /root/.bash_profile
for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo zonesigner.sh $i $i.db;done >> /dev/null 2>&1