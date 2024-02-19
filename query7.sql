create view v_userbuytbl as
select u.userid as 'user id',u.name as 'user name',b.prodName as 'product name', u.addr as 'address', concat(u.mobile1,u.mobile2) as 'mobile phone'
from usertbl u
join buytbl b on u.userid = b.userid;

select * from v_userbuytbl;

alter view v_userbuytbl as
select u.userid as '사용자 아아디',u.name as '사용자 이름',b.prodName as '제품 이름', u.addr as '주소', concat(u.mobile1,u.mobile2) as '휴대폰 번호'
from usertbl u
join buytbl b on u.userid = b.userid;

drop view v_userbuytbl;

create view v_usertbl as
select userid, name, addr from usertbl;

select * from v_usertbl;

update v_usertbl set addr = '부산' where userid='JKW';

insert into v_usertbl(userid,name,addr) values('KBN','김병만','충북');

create view v_sum as
select userid as 'userid', sum(price*amount) as 'total'
from buytbl
group by userid;

SELECT * FROM v_sum;

create view v_height177 as
select * from usertbl where height>=177;

select * from v_height177;

delete from v_height177 where height<177;
delete from usertbl where userid='KBN';

insert into v_height177 values('KBN','김병만','1977','경기','010','55555555','158','2023-01-01');

alter view v_height177 as
select * from usertbl where height>=177
with check option;

insert into v_height177 values('SJH','서장훈','2006','경기','010','33333333','201','2023-01-02');
drop table tbl3;
create table tbl3
(
	a int unique not null,
	b int unique,
	c int unique,
    d int
);

show index from tbl3;