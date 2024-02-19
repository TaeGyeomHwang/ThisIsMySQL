use sqldb;

set @myVar1 = 5;	-- 글로벌 변수 선언
set @myVar2 = 3;
set @myVar3 = 4.25;
set @myVar4 = '가수 이름==>';

SELECT @myVar1;	-- 변수 출력
SELECT @myVar2 + @myVar3;
select @myVar4, name from usertbl where height > 180;

select avg(amount) as '평균 구매 개수' from buytbl;
select cast(avg(amount) as signed integer) as '평균 구매 개수' from buytbl;	-- 형변환
select convert(avg(amount), signed integer) as '평균 구매 개수' from buytbl;

SELECT ELT(2, 'a', 'b'); -- 해당 위치 문자열 반환
SELECT FIELD('a', 'a', 'b');	-- 해당 문자열 위치 반환

SELECT FORMAT(12341234123, 1);	-- 숫자를 소수점 아래 자릿수까지 표현, 1000 단위마다 콤마 표현
SELECT 
    INSERT('abcdefghi', 3, 4, '@@@@'),
    INSERT('abcdefghi', 3, 2, '@@@@');	-- 기준 문자열의 위치부터 길이만큼 지우고 삽입할 문자열 끼워넣음

SELECT LEFT('abcdefghi', 3); -- 왼쪽에서 문자열의 길이만큼 반환
SELECT REPLACE('이것이 mysql이다', '이것이', 'this is');	-- 문자열 변환
SELECT REVERSE('abcde');	-- 문자열 거꾸로

SELECT SUBSTRING('대한민국만세', 3, 2);	-- 문자열 자르기
SELECT SUBSTRING('대한민국만세'from 3 for 2);	

SELECT FLOOR(RAND() * 6 + 1) AS '주사위 눈'; -- 임의의 0 이상 1 미만의 실수 구함

select year(now());	-- 현재 날짜 출력

select *	-- 이너 조인 (구매를 한 사람만 나온다)
from buytbl b
join usertbl u on b.userID = u.userID;

select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1, u.mobile2) as '연락처'	-- 아우터 조인 (구매를 하지 않은 유저도 나온다)
from usertbl u
left outer join buytbl b
on u.userID = b.userid
order by u.userid;

drop procedure if exists ifProc;
-- 구분자 설정
delimiter $$	
create procedure ifProc()	-- 프로시져 정의
begin
	declare var1 int; -- 로컬 변수 선언 
    set var1 = 100;
    if var1=100 then	-- if문 시작 
		select '100입니다';
	else
		select '100이 아닙니다';
	end if;	-- if문 종료 
end $$
delimiter ;

show procedure status;	-- 프로시져 조회
call ifProc();	-- 프로시져 호출

drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
	declare point int;
    declare credit char(1);
    set point = 77;
    
    if point >= 90 then
		set credit = 'A';
	elseif point >= 80 then
        set credit = 'B';
	elseif point >= 70 then
        set credit = 'C';
	elseif point >= 60 then
        set credit = 'D';
	else
		set credit = 'F';
	end if;
    select concat('취득 점수 ==> ', point), concat('학점 ==> ',credit);
end $$
delimiter ;
call ifProc3();

delimiter $$
create procedure whileProc()
begin
	declare i int;
    declare hap int;
    
    set i = 1;
    set hap = 0;
    
    while (i <=100) do
		set hap = hap+i;
        set i = i+1;
	end while;
    
    select hap;
end $$
delimiter ;
call whileProc();

delimiter $$
create procedure whileProc2()
begin
	declare i int;
    declare hap int;
    
    set i = 1;
    set hap = 0;
    
    myWhile: while(i<=100) do
		if(i%7=0) then
			set i = i+1;
			iterate myWhile;	-- continue문 처럼 돌아감
		end if;
		
		set hap = hap+i;
		if(hap>1000) then
			leave myWhile;	-- break문 처럼 벗어남
		end if;
	end while;
    select hap;
end $$
delimiter ;
call whileProc2();

select u.userid, u.name, sum(price * amount) as '총 구매액',
-- 	case
-- 		when(sum(price * amount) >= 1500) then '최우수 고객'
--         when(sum(price * amount) >= 1000) then '우수 고객'
--         when(sum(price * amount) >= 1) then '일반 고객'
-- 		else '유령 고객'
-- 	end as '고객 등급'
	 if(sum(price * amount) >= 1500,'최우수 고객',
		if(sum(price * amount) >=1000, '우수 고객',
        if(sum(price * amount) >=1, '일반 고객', '유령 고객'))) as '고객 등급' 
from buytbl b
right outer join usertbl u on b.userid = u.userid
group by u.userid, u.name
order by sum(price * amount) desc;

-- 오류 처리
delimiter //
create procedure errorProc()
begin
	declare continue handler for 1146 select '테이블이 없습니다' as '메시지';
    select * from asdf;
end//
delimiter ;
call errorProc();