use sqldb;	-- 시작하기 전에 어떤 db를 참조할 지 명시

select *	-- price가 300 이상인 모든 칼럼을 출력
from buytbl
where price>=300;

select distinct(userID) 	-- 한번에 구매한 수량이 3 이상인 유저의 아이디를 중복 없이 출력
from buytbl
where amount>=3;

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

select *
from usertbl;
