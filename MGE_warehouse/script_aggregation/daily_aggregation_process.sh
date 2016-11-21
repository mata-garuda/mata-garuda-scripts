#!/bin/bash

id=$1
sid=$2
aggregation_start=$3
aggregation_end=$4

read -d '' daily_aggregation_process_sql << EOF
insert into daily_event_aggregation(
	select
		date_format(long_date, '%Y-%c-%e') date,
		date_format(long_date, '%k') hour,
		sid,
		ip_src,
		ip_dst,
		signature,
		signature_name,
		signature_priority,
		protocol,
		CASE WHEN protocol = 6
			THEN tcp_sport
		ELSE udp_sport END as s_port,
		CASE WHEN protocol = 6
			THEN tcp_dport
		ELSE udp_dport END as d_port,
		count(1) as counter
	from
		event
	where
		long_date between '$aggregation_start' and '$aggregation_end' and sid = '$sid'
	group by
		date,
		hour,
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
		hour,counter DESC
)

EOF
echo "$daily_aggregation_process_sql" | mysql -u sensor --password="sensor" -D MG16

echo "update sensor_push_log set agregation_status=2 where id='$id'" | mysql -u sensor --password="sensor" -D MG16
