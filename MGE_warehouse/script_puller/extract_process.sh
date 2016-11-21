#!/bin/bash

id=$1
package_name=$2
ip_sensor=$3

scp root@$ip_sensor:~/$package_name.zip /var/lib/mysql-files/
unzip /var/lib/mysql-files/$package_name.zip -d /var/lib/mysql-files/

echo 'rm '$package_name'.zip' | ssh root@$ip_sensor

echo "LOAD DATA INFILE '/var/lib/mysql-files/$package_name' INTO TABLE event" | mysql -u root --password="jarkom123" -D MG16
echo "LOAD DATA INFILE '/var/lib/mysql-files/$package_name' IGNORE INTO TABLE ip_map (@ignore,@ignore,@ignore,@ignore,@ignore,ip_addr) " | mysql -u root --password="jarkom123" -D MG16
echo "LOAD DATA INFILE '/var/lib/mysql-files/$package_name' IGNORE INTO TABLE ip_map (@ignore,@ignore,@ignore,@ignore,@ignore,@ignore,ip_addr) " | mysql -u root --password="jarkom123" -D MG16
echo "update sensor_push_log set extract_status=2 where id='$id'" | mysql -u sensor --password="sensor" -D MG16

rm /var/lib/mysql-files/$package_name.zip
rm /var/lib/mysql-files/$package_name
