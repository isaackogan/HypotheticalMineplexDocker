create database if not exists mineplex;

use mineplex;

create table if not exists antihack_kick_log
(
	id int auto_increment
		primary key,
	updated bigint null,
	playerName varchar(256) null,
	motd varchar(56) null,
	gameType varchar(56) null,
	map varchar(256) null,
	serverName varchar(256) null,
	report varchar(256) null,
	ping varchar(25) null
)
charset=latin1;

create table if not exists newslist
(
	id int auto_increment
		primary key,
	newsString varchar(256) null,
	newsPosition int null
)
charset=latin1;


