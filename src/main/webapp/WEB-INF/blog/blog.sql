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

create table hbCategory (
	caIdx int not null auto_increment,
	caBlogIdx int not null,
	category varchar(30) not null,
	parentCategoryIdx int,
	publicSetting char(3) default '공개',
	primary key(caIdx),
	foreign key(caBlogIdx) references hbBlog(blogIdx) on delete cascade,
	foreign key(parentCategoryIdx) references hbCategory(caIdx) on delete cascade
);

drop table hbCategory;