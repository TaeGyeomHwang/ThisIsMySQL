use thisisjava;

CREATE TABLE users (
    userid VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    userpassword VARCHAR(50) NOT NULL,
    userage NUMERIC(3) NOT NULL,
    useremail VARCHAR(50) NOT NULL
);
CREATE TABLE boards (
    bno INT PRIMARY KEY AUTO_INCREMENT,
    btitle VARCHAR(100) NOT NULL,
    bcontent LONGTEXT NOT NULL,
    bwriter VARCHAR(50) NOT NULL,
    bdate DATETIME DEFAULT NOW(),
    bfilename VARCHAR(50) NULL,	-- 파일 이름은 저장하면 사라지므로 데이터와 따로 컬럼 선언
    bfiledata LONGBLOB NULL
);
CREATE TABLE accounts (
    ano VARCHAR(20) PRIMARY KEY,
    owner VARCHAR(20) NOT NULL,
    balance NUMERIC NOT NULL
);

insert into accounts (ano, owner, balance) 
values ('111-111-1111', '하여름', 1000000);

insert into accounts (ano, owner, balance) 
values ('222-222-2222', '한겨울', 0);

select * from accounts;
select * from users;
select * from boards;

select * from users where userid='winter';

-- 키가 ?인 유저의 구매 품목 전부 출력
select * 
from buytbl as b
where b.userid = any (
	select u.userid
	from usertbl as u
	where height > 175
);

select * from boards;
desc buytbl;
desc usertbl;

insert into boards (btitle, bwriter, bcontent)
values ('좋은 아침입니다', '홍길동', '오늘도 열공하세요^^');

update boards set bhitcount=0
where bno=1;

truncate table boards;
commit;
