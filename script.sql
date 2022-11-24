use aidev;
SELECT * FROM tb_member;

create table tb_board (
	b_idx int auto_increment primary key,
    b_userid  varchar(20) not null,
    b_name varchar(20) not null,
    b_title varchar(100) not null,
    b_content text not null,
    b_hit int default 0,
    b_regdate datetime default now(),
    b_like int default 0
);
select * from tb_board;

create table tb_reply(
	re_idx int auto_increment primary key,
    re_userid varchar(20) not null,
    re_name varchar(20) not null,
    re_content varchar(2000) not null,
    re_regdate datetime default now(),
    re_boardidx int,
    foreign key (re_boardidx) references tb_board(b_idx) on delete cascade
);

desc tb_reply;
ALTER TABLE tb_reply ADD CONSTRAINT  FOREIGN KEY(re_boardidx)
 REFERENCES tb_board(b_idx) ON DELETE CASCADE;
 ALTER TABLE tb_reply DROP FOREIGN KEY re_boardidx;
select * from tb_reply;

SELECT TIMESTAMPDIFF(DAY, '2022-11-19', now());
# select 필드1, 필드2, ... FROM 테이블명 limit 시작행(0부터시작), 가져올 행의 갯수
INSERT INTO tb_board (b_userid, b_name, b_title, b_content) VALUES ('banana','반하나','테스트','테스트입니다');
SELECT b_idx, b_userid, b_name, b_title, b_content, b_hit, b_regdate, b_like FROM tb_board;

-- tb_member
-- tb_board 
-- tb_reply
-- tb_like
# likeidx, b_idx, userid
create table tb_like (
	li_idx int auto_increment primary key,
    li_boardidx int not null,
    li_userid varchar(20) not null,
    foreign key (li_boardidx) references tb_board(b_idx) on delete cascade
);
select * from tb_like;
SELECT * from tb_board;
drop table tb_like;

create table tb_hit (
	hit_idx int auto_increment primary key,
    hit_boardidx int not null,
    hit_userid varchar(20) not null,
    foreign key (hit_boardidx) references tb_board(b_idx) on delete cascade
);