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

create table hbReply(
	rIdx int not null auto_increment,
	rBlogIdx int not null,
	rCoIdx int not null,
	rMid varchar(20) not null,
	rNickName varchar(20) not null,
	rContent text not null,
	rDate datetime default now(),
	rHostIp varchar(30) not null,
	parentReplyIdx int,
	rPublic char(3) default '공개',
	readCheck char(4) default '읽지않음',
	primary key(rIdx),
	foreign key(rBlogIdx) references hbBlog(blogIdx) on delete cascade,
	foreign key(rCoIdx) references hbContent(coIdx) on delete cascade,
	foreign key(rMid) references hbUser(mid),
	foreign key(parentReplyIdx) references hbReply(rIdx) on delete cascade
);

drop table hbReply;