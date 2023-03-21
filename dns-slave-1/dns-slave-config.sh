#!/bin/bash

sudo systemctl stop named

sudo mv /etc/named.conf /etc/named.conf_ORIG
sudo cp /vagrant/dns-slave-1/named.conf /etc/named.conf
sudo cp /vagrant/dns-slave-1/named.conf.local /etc/named/named.conf.local
sudo cp /vagrant/dns-slave-1/check_bind.sh /root/check_bind.sh


sudo chown -R named:named /var/log/bind/
sudo chmod 640 /etc/named.conf 
sudo chmod 644 /etc/named/named.conf.local
sudo chmod 777 /root/check_bind.sh
sudo chown root:named /etc/named.conf

sudo grep "check_bind.sh" /root/.bash_profile
[ "$?" == 1 ] && sudo echo "/root/check_bind.sh" | sudo tee -a /root/.bash_profile

sudo systemctl restart named