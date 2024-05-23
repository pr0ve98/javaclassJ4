show tables;

create table hbUser (
	idx int not null auto_increment,
	mid varchar(20) not null,
	email varchar(100) not null,
	pwd varchar(100) not null,
	nickName varchar(20) not null,
	name varchar(20) not null,
	birthday date not null,
	isDel int default 0,
	joinDate datetime default now(),
	userImg varchar(200) default 'user_basic.jpg',
	primary key (idx),
	unique key (mid),
	unique key (email)
);

desc hbUser;

drop table hbUser;
