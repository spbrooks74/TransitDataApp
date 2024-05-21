CREATE DATABASE IF NOT EXISTS MBTAdb;

USE MBTAdb;

DROP TABLE IF EXISTS mbta_buses;

CREATE TABLE mbta_buses (
    record_num INT AUTO_INCREMENT PRIMARY KEY,
    id varchar(255) not null,
    latitude decimal(11,8) not null,
    longitude decimal(11,8) not null,
    vtype varchar(255) default null,
    direction_id varchar(255) default null,
    occupancy_status varchar(255) default null,
    current_status varchar(255) default null,
    current_stop_sequence varchar(255) default null,
    speed int default null,
    updated_at datetime null,
    rtid varchar(255) default null
);

