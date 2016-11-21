#!/bin/bash

ip_sensor=$1
ip_mainDB=$2

script_dir="/root/MGE_sensor"
log_dir="/var/log/MGE_scheaduler"

mkdir $log_dir
touch $log_dir/scheaduler_created.log

now=$(date '+%Y-%m-%d %H:%M:%S')

echo "select sid,interface from sensor where ip_address='$ip_sensor'" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16 | sed 's/\t/,/g' > list_interface
sed -i '1d' list_interface

cat list_interface | while read line
do
	IFS=',' read -r -a array <<< "$line"

	echo "INSERT INTO sensor_push_log VALUES(null,'${array[0]}','$now',null,null,'$now',null,null,null,null,null,null)" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16

	crontab -l > mycron
	sed -i "\:push_mainDB.sh $ip_sensor $ip_mainDB ${array[1]}:d " mycron
	echo "* * * * * $script_dir/push_mainDB.sh $ip_sensor $ip_mainDB ${array[1]}" >> mycron
	crontab mycron
	rm mycron

	echo "Scheaduler push ${array[1]} Created at : $now" >> $log_dir/scheaduler_created.log
done

rm list_interface
