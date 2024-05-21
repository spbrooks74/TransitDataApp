use MBTAdb;
select count(*) from mbta_buses;

select rtid, min(cast(current_stop_sequence as SIGNED)) as min_stop, max(cast(current_stop_sequence as SIGNED)) as max_stop,  TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeHours, 60.0*TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeMins  from mbta_buses group by rtid having  min(cast(current_stop_sequence as SIGNED)) = 1 and  max(cast(current_stop_sequence as SIGNED)) = 24  and  count(distinct id) = 1;
-- T1.avg_lat, T1.avg_long, T2.first_stop_seq as next_stop, T2.avg_lat as next_avg_lat, T2.avg_long,;





-- Avg Miles;

select T3.direction_id, sum(miles_to_next_stop) as total_miles from
(select T1.direction_id, T1.first_stop_seq,  
ST_Distance_Sphere(point(T1.avg_long, T1.avg_lat),point(T2.avg_long, T2.avg_lat))*.000621371192 as miles_to_next_stop
FROM

(select cast(direction_id as SIGNED) as direction_id, 
cast(current_stop_sequence as SIGNED) as first_stop_seq, avg(latitude) avg_lat, avg(longitude) as avg_long 
from mbta_buses
group by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)
order by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)) AS T1

LEFT JOIN

(select cast(direction_id as SIGNED) as direction_id, 
cast(current_stop_sequence as SIGNED) as first_stop_seq, avg(latitude) avg_lat, avg(longitude) as avg_long 
from mbta_buses
group by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)
order by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)) AS T2
ON T1.direction_id = T2.direction_id and T1.first_stop_seq = T2.first_stop_seq-1) T3
group by T3.direction_id;

-- Explore Avg Miles;
select T1.direction_id, T1.first_stop_seq, T1.avg_lat, T1.min_lat, T1.max_lat, T1.avg_long,
T1.min_long, T1.max_long, 
ST_Distance_Sphere(point(T1.avg_long, T1.avg_lat),point(T2.avg_long, T2.avg_lat))*.000621371192 as miles_to_next_stop
FROM

(select cast(direction_id as SIGNED) as direction_id, 
cast(current_stop_sequence as SIGNED) as first_stop_seq, 
avg(latitude) as avg_lat, avg(longitude) as avg_long,  
min(latitude) as min_lat, min(longitude) as min_long,  
max(latitude) as max_lat, max(longitude) as max_long  
from mbta_buses
group by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)
order by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)) AS T1

LEFT JOIN

(select cast(direction_id as SIGNED) as direction_id, 
cast(current_stop_sequence as SIGNED) as first_stop_seq, avg(latitude) avg_lat, avg(longitude) as avg_long 
from mbta_buses
group by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)
order by cast(direction_id as SIGNED), cast(current_stop_sequence as SIGNED)) AS T2
ON T1.direction_id = T2.direction_id and T1.first_stop_seq = T2.first_stop_seq-1;










select * from mbta_buses where current_stop_sequence = 1;
SELECT id, min(cast(current_stop_sequence as SIGNED)), 
max(cast(current_stop_sequence as SIGNED)), count(*) FROM mbta_buses group by id;

select record_num, id, latitude, longitude, direction_id, 
current_status, current_stop_sequence, updated_at, rtid
 from mbta_buses where id='y1771' order by updated_at;
 
 select rtid, direction_id,
 min(cast(current_stop_sequence as SIGNED)) as min_stop,
 max(cast(current_stop_sequence as SIGNED)) as max_stop, 
 count(distinct id) as did,
 min(cast(updated_at as datetime)) as min_date, 
 max(cast(updated_at as datetime)) as max_date,
 timediff(max(cast(updated_at as datetime)),min(cast(updated_at as datetime))) as TimeDiff1 ,
 ABS(TIMESTAMPDIFF(HOUR,min(cast(updated_at as datetime)),max(cast(updated_at as datetime)))) as TimeDiff2,
 TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeDiff3,
 count(*) as records 
 from mbta_buses group by rtid, direction_id;



 select rtid, count(distinct direction_id) as dids,
 min(cast(current_stop_sequence as SIGNED)) as min_stop,
 max(cast(current_stop_sequence as SIGNED)) as max_stop, 
 count(distinct id) as did,
 min(cast(updated_at as datetime)) as min_date, 
 max(cast(updated_at as datetime)) as max_date,
 timediff(max(cast(updated_at as datetime)),min(cast(updated_at as datetime))) as TimeDiff1 ,

 TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeDiff3,
 count(*) as records 
 from mbta_buses group by rtid
 having  min(cast(current_stop_sequence as SIGNED)) = 1
 and  max(cast(current_stop_sequence as SIGNED)) = 24
 and  count(distinct id) = 1;

-- PythonSQL;
 select rtid, count(distinct direction_id) as dids,
 min(cast(current_stop_sequence as SIGNED)) as min_stop,
 max(cast(current_stop_sequence as SIGNED)) as max_stop, 
 TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeDiff3
 from mbta_buses group by rtid
 having  min(cast(current_stop_sequence as SIGNED)) = 1
 and  max(cast(current_stop_sequence as SIGNED)) = 24
 and  count(distinct id) = 1;

 select rtid, 
 min(cast(current_stop_sequence as SIGNED)) as min_stop,
 max(cast(current_stop_sequence as SIGNED)) as max_stop, 
 count(distinct id) as did,
 min(cast(updated_at as datetime)) as min_date, 
 max(cast(updated_at as datetime)) as max_date,
 timediff(max(cast(updated_at as datetime)),min(cast(updated_at as datetime))) as TimeDiff1 ,
 ABS(TIMESTAMPDIFF(HOUR,min(cast(updated_at as datetime)),max(cast(updated_at as datetime)))) as TimeDiff2,
 TIME_TO_SEC(TIMEDIFF(max(cast(updated_at as datetime)), min(cast(updated_at as datetime))))/3600 as TimeDiff3,
 count(*) as records 
 from mbta_buses group by rtid
 having  min(cast(current_stop_sequence as SIGNED)) = 1
 and  max(cast(current_stop_sequence as SIGNED)) = 24;



select record_num, id, latitude, longitude, direction_id, 
current_status, current_stop_sequence, updated_at, rtid
 from mbta_buses where rtid='60168987' order by updated_at;
