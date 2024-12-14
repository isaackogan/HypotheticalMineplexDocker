create database if not exists queue;

use queue;

create table if not exists playerqueue
(
	id int auto_increment
		primary key,
	playerList varchar(256) null,
	gameType varchar(256) null,
	playerCount int null,
	elo int null,
	state varchar(256) null,
	time mediumtext null,
	assignedMatch int null,
	US tinyint(1) default 1 not null,
	constraint name_gametype
		unique (playerList, gameType)
);


