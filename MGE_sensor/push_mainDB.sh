#!/bin/bash

ip_sensor=$1
ip_mainDB=$2
interface=$3

base_logdir="/var/log/MGE_scheaduler"
sub_logdir=$(date '+%Y-%m-%d')

mkdir $base_logdir/$sub_logdir

scheaduler_start=$(date '+%Y-%m-%d %H:%M:%S')
scheaduler_id=$(echo $scheaduler_start | tr -d ' :-')

echo "update sensor set push_status = 1 where ip_address='$ip_sensor' and interface='$interface'" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16

# =====================================================================
# GET SID
# =====================================================================

echo "SELECT sid from sensor WHERE ip_address = '$ip_sensor' AND interface = '$interface'" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16 > sid_${interface}_${scheaduler_id}
sed -i '1d' sid_${interface}_${scheaduler_id}
sid=$(cat sid_${interface}_${scheaduler_id})
echo "$sid" >> x.txt

echo "select sid from sensor where interface = '$interface'" | mysql -u snort --password="jarkom123" -D snort > local_sid_${interface}_${scheaduler_id}
sed -i '1d' local_sid_${interface}_${scheaduler_id}
local_sid=$(cat local_sid_${interface}_${scheaduler_id})
echo "$local_sid" >> x.txt


# =====================================================================
# Get range push
# =====================================================================

echo "select max(range_end) from sensor_push_log where sid='$sid'" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16 > range_start_${interface}_${scheaduler_id}
sed -i '1d' range_start_${interface}_${scheaduler_id}
range_start=$(cat range_start_${interface}_${scheaduler_id})
echo "$range_start" >> x.txt

echo "select date_add(max(timestamp), INTERVAL -1 second) from event where sid=(select s.sid from sensor s where s.interface = '$interface')" | mysql -u snort --password="jarkom123" -D snort > range_end_${interface}_${scheaduler_id}
sed -i '1d' range_end_${interface}_${scheaduler_id}
range_end=$(cat range_end_${interface}_${scheaduler_id})
echo "$range_end" >> x.txt

# =====================================================================
# Write log
# =====================================================================

echo "INSERT INTO sensor_push_log VALUES (null,'$sid','$scheaduler_start',null,'$range_start','$range_end',null,null,null,null,0,null)" | mysql -u sensor --password="sensor" -h $ip_mainDB -D MG16

echo "==============================================================================" >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "Starting " ${interface}_${scheaduler_id} " job at : " $scheaduler_start >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "==============================================================================" >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "Push event in range : $range_start < ( event ) <= $range_end" >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log

# =====================================================================
#  query SELECT Summary / Agregasi
# =====================================================================

read -d '' sql_select << EOF
SELECT
        e.timestamp AS long_date,
        substring(replace(replace(FROM_UNIXTIME(UNIX_TIMESTAMP(e.timestamp)),'-',':'),' ',':'),3,11) as code,
        e.cid,
	'$sid',
        e.signature,
        COALESCE (ip_src, 0) ip_src,
        COALESCE (ip_dst, 0) ip_dst,
        COALESCE (tcp_sport, 0) tcp_sport,
        COALESCE (tcp_dport, 0) tcp_dport,
        COALESCE (udp_sport, 0) udp_sport,
        COALESCE (udp_dport, 0) udp_dport,
        s.sig_name AS signature_name,
        s.sig_priority AS signature_priority,
        ip.ip_proto,
        0 AS detail
FROM
        event e
        LEFT JOIN iphdr ip ON e.sid = ip.sid AND e.cid = ip.cid
        LEFT JOIN tcphdr t ON e.sid = t.sid AND e.cid = t.cid
        LEFT JOIN udphdr u ON e.sid = u.sid AND e.cid = u.cid
        LEFT JOIN signature s ON e.signature = s.sig_id
WHERE
	FROM_UNIXTIME(UNIX_TIMESTAMP(e.timestamp)) > '$range_start'
        AND FROM_UNIXTIME(UNIX_TIMESTAMP(e.timestamp)) <= '$range_end'
	AND e.sid = '$local_sid';
EOF

echo "$sql_select" | mysql -u snort --password="jarkom123" -D snort > output_${sid}_${interface}_${scheaduler_id}
sed -i '1d' output_${sid}_${interface}_${scheaduler_id}

# =====================================================================
# write to log
# =====================================================================

echo "SELECT min(cid) from event WHERE FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) > '$range_start' AND FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) <= '$range_end' AND sid=$local_sid " | mysql -u snort --password="jarkom123" -D snort > min_cid_${interface}_${scheaduler_id}
sed -i '1d' min_cid_${interface}_${scheaduler_id}
first_cid=$(cat min_cid_${interface}_${scheaduler_id})
echo "First event cid : " $first_cid >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log

echo "SELECT max(cid) from event WHERE FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) > '$range_start' AND FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) <= '$range_end' AND sid=$local_sid " | mysql -u snort --password="jarkom123" -D snort > max_cid_${interface}_${scheaduler_id}
sed -i '1d' max_cid_${interface}_${scheaduler_id}
last_cid=$(cat max_cid_${interface}_${scheaduler_id})
echo "Last event cid : " $last_cid >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log

echo "SELECT count(1) from event WHERE FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) > '$range_start' AND FROM_UNIXTIME(UNIX_TIMESTAMP(timestamp)) <= '$range_end' AND sid=$local_sid " | mysql -u snort --password="jarkom123" -D snort > event_count_${interface}_${scheaduler_id}
sed -i '1d' event_count_${interface}_${scheaduler_id}
event_count=$(cat event_count_${interface}_${scheaduler_id})

job_end=$(date '+%Y-%m-%d %H:%M:%S')

echo "Pushed event : " $event_count >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "==============================================================================" >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "Job " ${interface}_${scheaduler_id} " finished at : " $job_end >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log
echo "==============================================================================" >> $base_logdir/$sub_logdir/${interface}_${scheaduler_id}.log

zip output_${sid}_${interface}_${scheaduler_id}.zip output_${sid}_${interface}_${scheaduler_id}

rm output_${sid}_${interface}_${scheaduler_id}

echo "UPDATE sensor_push_log SET job_end='$job_end', first_cid='$first_cid', last_cid='$last_cid', count_event='$event_count', package_name='output_${sid}_${interface}_${scheaduler_id}', extract_status=0 where sid='$sid' and job_start = '$scheaduler_start'" | mysql -u sensor --password="sensor" -D snort -h $ip_mainDB -D MG16

rm event_count_${interface}_${scheaduler_id}
rm output_${interface}_${scheaduler_id}
rm range_start_${interface}_${scheaduler_id}
rm range_end_${interface}_${scheaduler_id}
rm sid_${interface}_${scheaduler_id}
rm min_cid_${interface}_${scheaduler_id}
rm max_cid_${interface}_${scheaduler_id}
rm local_sid_${interface}_${scheaduler_id}
rm permission_${interface}_${scheaduler_id}
