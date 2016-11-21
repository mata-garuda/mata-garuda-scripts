#!/bin/bash

job_aggregation_start=$(date '+%Y-%m-%d %H:%M:%S')
aggregation_id=$(echo $job_aggregation_start | tr -d ' :-')

read -d '' annual_sql_select << EOF
	SELECT
		id,
		sid,
		DATE_FORMAT(range_start, '%c') agregation_month,
		(DATE_FORMAT(range_end,'%c')-DATE_FORMAT(range_start, '%c')) as gap
	FROM
		sensor_push_log
	WHERE
		(DATE_FORMAT(range_end,'%c')-DATE_FORMAT(range_start, '%c')) > 0
		AND agregation_status = 4 and extract_status = 2
EOF

echo "$annual_sql_select" | mysql -u sensor --password="sensor" -D MG16 | sed 's/\t/,/g' > output_annual_${agregation_id}
sed -i '1d' output_annual_${agregation_id}

cat output_annual_${agregation_id} | while read line
do
	IFS=',' read -r -a array <<< "$line"
	nohup /root/MGE_warehouse/script_aggregation/annual_aggregation_process.sh "${array[1]}" "${array[2]}" "${array[3]}" >/dev/null 2>&1 &
	echo "update sensor_push_log set agregation_status=5 where id='${array[0]}'" | mysql -u sensor --password="sensor" -D MG16

done
rm output_annual_${agregation_id}
