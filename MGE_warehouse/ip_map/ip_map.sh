#!/bin/bash

read -d '' sql_select_ip_map << EOF
	SELECT
		ip_addr
	FROM
		ip_map
	WHERE
		country = ''
	LIMIT 500
EOF

echo "$sql_select_ip_map" | mysql -u sensor --password="sensor" -D MG16 | sed 's/\t/,/g' > output_ip_map
sed -i '1d' output_ip_map

rm /var/lib/mysql/tellme

i=0
cat output_ip_map | while read line
do
((i++))

echo $i

IFS=',' read -r -a array <<< "$line"

if [[ "${array[0]}" -lt "781259368" ]]; then
    	reduction=33554431
fi

if [[ "${array[0]}" -ge "781259368" ]] && [[ "${array[0]}" -lt "1055769984" ]]; then
        reduction=16777215
fi

if [[ "${array[0]}" -ge "1055769984" ]] && [[ "${array[0]}" -lt "1114185512" ]]; then
        reduction=4194303
fi

if [[ "${array[0]}" -ge "1114185512" ]] && [[ "${array[0]}" -lt "1175652360" ]]; then
        reduction=786431
fi

if [[ "${array[0]}" -ge "1175652360" ]] && [[ "${array[0]}" -lt "1261735352" ]]; then
        reduction=524287
fi

if [[ "${array[0]}" -ge "1261735352" ]] && [[ "${array[0]}" -lt "1345703284" ]]; then
        reduction=1048575
fi

if [[ "${array[0]}" -ge "1345703284" ]] && [[ "${array[0]}" -lt "1399395592" ]]; then
        reduction=524287
fi

if [[ "${array[0]}" -ge "1399395592" ]] && [[ "${array[0]}" -lt "1534589952" ]]; then
        reduction=917503
fi

if [[ "${array[0]}" -ge "1534589952" ]] && [[ "${array[0]}" -lt "1756216456" ]]; then
        reduction=16777215
fi

if [[ "${array[0]}" -ge "1756216456" ]] && [[ "${array[0]}" -lt "3155456912" ]]; then
        reduction=16777215
fi

if [[ "${array[0]}" -ge "3155456912" ]] && [[ "${array[0]}" -lt "3379959552" ]]; then
        reduction=8650751
fi

if [[ "${array[0]}" -ge "3379959552" ]] && [[ "${array[0]}" -lt "3572137908" ]]; then
        reduction=3670015
fi

if [[ "${array[0]}" -ge "3572137908" ]] && [[ "${array[0]}" -lt "3732426496" ]]; then
        reduction=33554431
fi

if [[ "${array[0]}" -ge "3732426496" ]]; then
        reduction=536870911
fi

echo "SELECT ${array[0]}, country, stateprov, city, latitude, longitude, timezone_offset, timezone_name, isp_name, connection_type, organization_name FROM ip_location WHERE ip_start <= ${array[0]} and ip_start >= (${array[0]}-$reduction) and ip_end >= ${array[0]}" | mysql -u root --password="jarkom123" -D MGMETADATA >> /var/lib/mysql-files/tellme
sed -i "\:country:d" /var/lib/mysql-files/tellme

done

echo "LOAD DATA INFILE '/var/lib/mysql-files/tellme' REPLACE INTO TABLE ip_map" | mysql -u root --password="jarkom123" -D MG16
