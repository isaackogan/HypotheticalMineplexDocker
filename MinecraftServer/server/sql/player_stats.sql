create database if not exists player_stats;

use player_stats;

create table if not exists ipinfo
(
	id int auto_increment
		primary key,
	ipAddress varchar(32) not null,
	countryCode text null,
	countryName text null,
	regionCode text null,
	regionName text null,
	city text null,
	zipCode text null,
	timeZone text null,
	latitude double null,
	longitude double null,
	metrocode int null
);

create table if not exists playerinfo
(
	id int auto_increment
		primary key,
	name text not null,
	version int not null,
	uuid varchar(256) not null
);

create table if not exists playerips
(
	id int auto_increment
		primary key,
	playerInfoId int not null,
	ipInfoId int not null,
	date datetime not null,
	constraint playerips_ibfk_1
		foreign key (ipInfoId) references ipinfo (id),
	constraint playerips_ibfk_2
		foreign key (playerInfoId) references playerinfo (id)
);

create index if not exists ipInfoId
	on playerips (ipInfoId);

create index if not exists playerInfoId
	on playerips (playerInfoId);

create table if not exists playerloginsessions
(
	id int auto_increment
		primary key,
	playerInfoId int not null,
	loginTime datetime not null,
	timeInGame bigint not null,
	constraint playerloginsessions_ibfk_1
		foreign key (playerInfoId) references playerinfo (id)
);

create index if not exists playerInfoId
	on playerloginsessions (playerInfoId);

create table if not exists playeruniquelogins
(
	id int auto_increment
		primary key,
	playerInfoId int not null,
	day datetime not null,
	constraint playeruniquelogins_ibfk_1
		foreign key (playerInfoId) references playerinfo (id)
);

create index if not exists playerInfoId
	on playeruniquelogins (playerInfoId);


