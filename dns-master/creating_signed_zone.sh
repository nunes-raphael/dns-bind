#!/bin/bash

for i in $(sudo grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo zonesigner.sh $i $i.db;done >> /dev/null 2>&1