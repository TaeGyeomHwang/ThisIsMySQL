use sqldb;	-- 시작하기 전에 어떤 db를 참조할 지 명시

select *	-- price가 300 이상인 모든 칼럼을 출력
from buytbl
where price>=300;

select name, height, addr
from usertbl
-- where birthyear>=1970 and height>=182;
-- where height between 180 and 183;
-- where addr in ('경남', '전남', '경북');	-- 해당 값들을 가지는 주소
-- where addr like '_남'; -- 앞에 한 글자만 오고 남으로 끝나는 주소만
where name like '김%'; -- 김으로 시작하고 몇글자든 뒤에 오는 이름만

select name, height, addr	-- 메인쿼리 
from (
	select a.name, a.height, a.addr	-- 서브쿼리
	from usertbl as a 
	where name like '김%'
) as b -- alias(별칭 부여) 
where b.height<=175;

select name, height
from usertbl
where height>(	-- 서브쿼리를 통해 원하는 조건을 입력할 수 있다
	select height
	from usertbl
	where name='김경호'
);

select * from usertbl;
select * from buytbl;

select *
from buytbl
where userid = any (	-- any: 서브쿼리의 여러 개 결과 중 하나라도 만족
	select userid
	from usertbl
	where birthyear > 1975
);

select *
from usertbl
where height > all (	-- all: 서브쿼리의 결과 중 여러 개의 결과를 모두 만족
	select height	-- select max(height)가 더 성능이 좋음
	from usertbl
	where birthyear < 1975
);

select max(height) as '가장 큰 키'
from usertbl
where birthyear < 1975;

select userid, prodname, amount	-- order by 기본값: 오름차순
from buytbl
order by amount desc;

select distinct(userID) 	-- distinct로 중복 없이 출력
from buytbl
where amount>=3;

select *	-- limit: 상위 5개 값만 가져옴
from usertbl
limit 5;

create table buytbl_backup	-- create table ... select로 테이블 복사 가능
select * from buytbl;

select * from buytbl_backup; -- 제약조건이 복사되지는 않는다.

select userid, sum(price*amount) as total -- 집계 함수로 칼럼 생성 가능
from buytbl
group by userid -- group by로 그룹핑
having total>100 -- having으로 집계 함수 조건 설정 가능
order by total desc;

select userid, max(price), min(price), count(userid), avg(price*amount)
from buytbl
group by userid;

select count(distinct(prodname))
from buytbl;

select * from usertbl;
update usertbl
set mobile2 = '12341234'
where userid='bbk';	-- where절 없이 update하면 데이터 전부에 덧씌워진다.

delete from usertbl where userid='yjs'; -- where절 없이 delete하면 데이터 전부를 삭제한다.

drop table buytbl_backup; -- drop은 table을 삭제한다.
truncate table usertbl; -- truncate는 트랜젝션 로그를 기록하지 않으므로 속도가 빠르다.

select u.userid, sum(price*amount)
from usertbl as u
join buytbl as b -- join은 연산횟수가 많으므로 잘 써야 한다. 잘못 쓰면 성능이 떨어진다. join문과 서브쿼리는 서로 변환할 수 있는 형태다.
on u.userid = b.userid
where u.height < 175
group by u.userid;

select b.userid, sum(price*amount) -- 키가 175 이하인 사람들이 구매한 총액
from buytbl as b
where b.userid = any (	-- any를 in으로 써도 결과는 같다.
	select u.userid
	from usertbl as u
	where height < 175
)
group by userid;


