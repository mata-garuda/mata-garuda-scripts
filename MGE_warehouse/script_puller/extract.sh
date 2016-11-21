#!/bin/bash

echo "select id, package_name, s.ip_address from sensor_push_log l left join sensor s on s.sid = l.sid where extract_status=0 and package_name is not null" | mysql -u sensor --password="sensor" -D MG16 | sed 's/\t/,/g' > job_extract
sed -i '1d' job_extract

cat job_extract | while read line
do
	echo $line
	IFS=',' read -r -a array <<< "$line"
	echo "update sensor_push_log set extract_status=1 where id='${array[0]}'" | mysql -u sensor --password="sensor" -D MG16
	nohup /root/MGE_warehouse/script_puller/extract_process.sh ${array[0]} ${array[1]} ${array[2]} >/dev/null 2>&1 &
done

rm job_extract
