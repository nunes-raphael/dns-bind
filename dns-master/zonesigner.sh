#!/bin/bash

PDIR=$(pwd)
ZONEDIR="/var/named" #location of your zone files
ZONE=$1
ZONEFILE=$2
DNSSERVICE="named" #On CentOS/Fedora replace this with "named"
cd $ZONEDIR
SERIAL=`/usr/sbin/named-checkzone $ZONE $ZONEFILE | egrep -ho '[0-9]{9}'`
sed -i 's/'$SERIAL'/'$(($SERIAL+1))'/' $ZONEFILE
/usr/sbin/dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N increment -o $1 -t $2
systemctl reload $DNSSERVICE
cd $PDIR
