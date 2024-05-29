show tables;

create table hbContent(
	coIdx int not null auto_increment,
	coBlogIdx int not null,
	categoryIdx int not null,
	part varchar(30),
	wDate datetime default now(),
	viewCnt int default 0,
	content text not null,
	ctPreview varchar(200) not null,
	cHostIp varchar(30) not null,
	primary key(coIdx),
	foreign key(coBlogIdx) references hbBlog(blogIdx) on delete cascade,
	foreign key(categoryIdx) references hbCategory(caIdx) on delete cascade
);