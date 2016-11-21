#!/bin/bash

job_aggregation_start=$(date '+%Y-%m-%d %H:%M:%S')
aggregation_id=$(echo $job_aggregation_start | tr -d ' :-')

read -d '' monthly_sql_select << EOF
	SELECT
		id,
		sid,
		DATE_FORMAT(range_start, '%Y-%m-%d') agregation_date,
		TIMESTAMPDIFF(DAY, DATE_FORMAT(range_start, '%Y-%m-%d 00:00:00'), DATE_FORMAT(range_end, '%Y-%m-%d 00:00:00')) as gap
	FROM
		sensor_push_log
	WHERE
		TIMESTAMPDIFF(DAY, DATE_FORMAT(range_start, '%Y-%m-%d 00:00:00'), DATE_FORMAT(range_end, '%Y-%m-%d 00:00:00')) > 0
		AND agregation_status = 2 and extract_status = 2
EOF

echo "$monthly_sql_select" | mysql -u sensor --password="sensor" -D MG16 | sed 's/\t/,/g' > output_monthly_${aggregation_id}
sed -i '1d' output_monthly_${aggregation_id}

cat output_monthly_${aggregation_id} | while read line
do
	IFS=',' read -r -a array <<< "$line"
	nohup /root/MGE_warehouse/script_aggregation/monthly_aggregation_process.sh "${array[0]}" "${array[1]}" "${array[2]}" >/dev/null 2>&1 &
	echo "update sensor_push_log set agregation_status=3 where id='${array[0]}'" | mysql -u sensor --password="sensor" -D MG16

done
rm output_monthly_${aggregation_id}
