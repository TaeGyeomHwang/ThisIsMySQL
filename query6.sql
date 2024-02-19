CREATE VIEW v_table_usertbl AS	-- 보여주고 싶지 않은 정보가 있다면 뷰로 생성해서 보여주는 방법이 있다.
    SELECT 
        userid, name, birthyear, height, mdate
    FROM
        usertbl;

SELECT 
    *
FROM
    v_table_usertbl;
    
create user 'test_user'@'%' identified by '1234';	-- 유저 생성

select * from mysql.user;	-- 유저 조회

grant select on v_table_usertbl to 'test_user'@'%';	-- 권한 부여 
flush privileges;