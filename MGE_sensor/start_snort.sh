#!/bin/bash

echo "Starting snort eth0"
snort -q -u snort -g snort -c /etc/snort/snort_eth0.conf -i eth1 -D
barnyard2 -c /etc/snort/barnyard2_eth0.conf -d /var/log/snort -f snort_eth0.u2 -w /var/log/snort/barnyard2_eth0.bookmark -u snort -g snort -D

#echo "Starting snort eth1"
#snort -q -u snort -g snort -c /etc/snort/snort_eth1.conf -i eth1 -D
#barnyard2 -c /etc/snort/barnyard2_eth1.conf -d /var/log/snort -f snort_eth1.u2 -w /var/log/snort/barnyard2_eth1.bookmark -u snort -g snort -D

#echo "Starting snort eth2"
#snort -q -u snort -g snort -c /etc/snort/snort_eth2.conf -i eth2 -D
#barnyard2 -c /etc/snort/barnyard2_eth2.conf -d /var/log/snort -f snort_eth2.u2 -w /var/log/snort/barnyard2_eth2.bookmark -u snort -g snort -D
