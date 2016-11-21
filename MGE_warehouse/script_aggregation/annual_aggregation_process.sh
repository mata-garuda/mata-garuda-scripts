#!/bin/bash

id=$1
sid=$2
aggregation_onth=$3

read -d '' annual_aggregation_process_sql << EOF
insert into annual_event_aggregation(
	select
		date_format(date, '%c') month,
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
		monthly_event_aggregation
	where
		date_format(date, '%c') = '$aggregation_month' and sid = '$sid'
	group by
		month,
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
		counter DESC;
)

EOF
echo "$annual_aggregation_process_sql" | mysql -u sensor --password="sensor" -D MG16

echo "update sensor_push_log set agregation_status=6 where id='$id'" | mysql -u sensor --password="sensor" -D MG16

