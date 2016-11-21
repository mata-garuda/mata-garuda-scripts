#!/bin/bash

id=$1
sid=$2
aggregation_date=$3

read -d '' monthly_aggregation_process_sql << EOF
insert into monthly_event_aggregation(
	select
		date,
		sid,
		ip_src,
		ip_dst,
		signature,
		signature_name,
		signature_priority,
		protocol,
		s_port,
		d_port,
		sum(counter) counter
	from
		daily_event_aggregation
	where
		date = '$aggregation_date' and sid = '$sid'
	group by
		date,
		sid,
		ip_src,
		ip_dst,
		signature,
		signature_name,
		signature_priority,
		protocol,
		s_port,
		d_port
	order by
		counter DESC
)

EOF
echo "$monthly_aggregation_process_sql" | mysql -u sensor --password="sensor" -D MG16

echo "update sensor_push_log set agregation_status=4 where id='$id'" | mysql -u sensor --password="sensor" -D MG16
