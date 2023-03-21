#!/bin/bash

sudo yum update -y
sudo yum install epel-release vim dig telnet yum-utils wget net-tools nmap tcpdump -y
sudo yum install bind bind-utils httpd vsftpd -y
sudo yum makecache fast
sudo yum install -y haveged
sudo systemctl enable --now haveged.service

sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Brazil/East /etc/localtime

sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0

sudo systemctl status firewalld 
sudo systemctl stop firewalld
sudo systemctl disable firewalld 
sudo systemctl status firewalld

sudo yum install ntp -y

sed -i "s/server 0.centos.pool.ntp.org iburst/server 200.160.7.186 iburst/g" /etc/ntp.conf
sed -i "s/server 1.centos.pool.ntp.org iburst/server 200.20.186.76 iburst/g" /etc/ntp.conf
sed -i "s/server 2.centos.pool.ntp.org iburst/server 200.186.125.195 iburst/g" /etc/ntp.conf
sed -i "/server 3.centos.pool.ntp.org iburst/d" /etc/ntp.conf

sudo systemctl stop chronyd.service
sudo systemctl disable chronyd.service
sudo timedatectl set-timezone America/Sao_Paulo
sudo systemctl enable ntpd
sudo systemctl start ntpd
sudo systemctl status ntpd

#sudo systemctl stop named
#sudo systemctl enable named

sudo mkdir /var/log/bind/
sudo touch /var/log/bind/example.log
sudo chown -R named:named /var/log/bind/

sudo sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo "L1nux*021" | sudo passwd root --stdin