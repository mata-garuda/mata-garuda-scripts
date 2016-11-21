#!/bin/bash

crontab -l > mycron

sed -i "\:ip_map.sh:d" mycron
sed -i "\:extract.sh:d" mycron
sed -i "\:daily_aggregation.sh:d" mycron
sed -i "\:monthly_aggregation.sh:d" mycron
sed -i "\:annual_aggregation.sh:d" mycron

echo "* * * * * /root/MGE_warehouse/ip_map/ip_map.sh" >> mycron
echo "* * * * * /root/MGE_warehouse/script_puller/extract.sh" >> mycron
echo "* * * * * /root/MGE_warehouse/script_aggregation/daily_aggregation.sh" >> mycron
echo "* * * * * /root/MGE_warehouse/script_aggregation/monthly_aggregation.sh" >> mycron
echo "* * * * * /root/MGE_warehouse/script_aggregation/annual_aggregation.sh" >> mycron

crontab mycron
rm mycron