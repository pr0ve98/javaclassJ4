show tables;

create table hbBlog (
	idx int not null auto_increment,
	mid varchar(20) not null,
	blogTitle varchar(100) not null,
	totalVisit int default 0,
	todayVisit int default 0,
	primary key(idx),
	foreign key(mid) references hbUser(mid) on delete cascade
);

desc hbBlog;

drop table hbBlog;