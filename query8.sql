delimiter $$
create procedure userProc1(in userName varChar(10))
begin
	select * from usertbl where name = userName;
end $$
delimiter ;
call userProc1('조관우');

delimiter $$
create procedure userProc2(in userBirth int, in userHeight int)
begin
	select * from usertbl
    where birthYear > userBirth and height > userHeight;
end $$
delimiter ;
call userProc2(1970,178);

CREATE TABLE IF NOT EXISTS testtbl (
    id INT AUTO_INCREMENT PRIMARY KEY,
    txt CHAR(10)
);
delimiter $$
create procedure userProc3(
	in txtValue char(10),
    out outValue int
    )
begin
	insert into testtbl values(null, txtvalue);
    select max(id) into outvalue from testtbl;
end $$
delimiter ;
call userProc3('테스트값',@myValue);
select @myValue;

create table gugutbl(txt varchar(100));
delimiter $$
create procedure whileProc3()
begin
	declare str varchar(100);
    declare i int;
    declare k int;
    
    set i = 2;
    while(i<10) do
		set str = '';
        set k = 1;
        while(k<10) do
			set str = concat(str, ' ', i, 'x', k, '=', i*k);
            set k = k+1;
		end while;
        set i = i+1;
        insert into gugutbl values(str);
	end while;
end $$
delimiter ;
call whileProc3();
SELECT * FROM gugutbl;

set global log_bin_trust_function_creators = 1;
delimiter $$
create function userFunc(value1 int, value2 int) returns int
begin
	return value1 + value2;
end $$
delimiter ;
select userFunc(100,200);

delimiter $$
create procedure cursorProc()
begin
	declare userHeight int;
    declare count int default 0;
    declare totalHeight int default 0;
    
    declare endOfRow boolean default false;
    declare userCursor cursor for select height from usertbl;
    declare continue handler for not found set endOfRow = true;
    
    open userCursor;
    
    cursor_loop : loop
		fetch userCursor into userHeight;
        if endOfrow then 
			leave cursor_loop;
        end if;
        set count = count+1;
        set totalHeight = totalHeight + userHeight;
	end loop cursor_loop;
    
    select totalHeight / count;
    
    close userCursor;
end $$
delimiter ;
call cursorProc();
select avg(height) from usertbl;	-- 값이 같다.

create table testtbl2 (
	id int,
    txt varChar(10)
);
insert into testtbl2 values(1, '레드벨벳'), (2, '잇지'), (3, '블랙핑크');
delimiter $$
create trigger testtrg
	after delete
    on testtbl2
    for each row
begin
	set @msg = '가수 그룹이 삭제됨';
end $$
delimiter ;
set @msg ='';
insert into testtbl2 values(4,'마마무');
select @msg;
update testtbl2 set txt = '블핑' where id = 3;
select @msg;
delete from testtbl2 where id=4;
select @msg;

create table backup_usertbl(
	userID char(8) not null primary key,
    name varchar(10) not null,
    birthYear int not null,
    addr char(2) not null,
    mobile1 char(3),
    mobile2 char(8),
    height smallint,
    mDate date,
    modType char(2),
    modDate date,
    modUser varChar(256)
);
delimiter //
create trigger backuptbl_updatetrg
	after update
    on usertbl
    for each row
begin
	insert into backup_usertbl values(old.userid, old.name, old.birthYear, old.addr, old.mobile1,
		old.mobile2, old.height, old.mDate, '수정', curdate(), current_user());
end //
delimiter ;
delimiter //
create trigger backuptbl_deletetrg
	after delete
    on usertbl
    for each row
begin
	insert into backup_usertbl values(old.userid, old.name, old.birthYear, old.addr, old.mobile1,
		old.mobile2, old.height, old.mDate, '삭제', curdate(), current_user());
end //
delimiter ;
update usertbl set addr = '몽고' where userid='JKW';
select * from usertbl;
select * from backup_usertbl;
delete from usertbl where height>=177;
truncate table usertbl;

delimiter //
create trigger usertbl_beforeInsertTrg
	before insert
    on usertbl
    for each row
begin
	if new.birthYear <1900 then set new.birthYear = 0;
    elseif new.birthYear>year(curdate()) then set new.birthYear = year(curdate());
    end if;
end //
delimiter ;
insert into usertbl values('aaa','에이',1877,'서울','011','1112222',181,'2022-12-25'),
	('bbb','비',2977,'경기','011','1112222',181,'2022-12-25');
select * from usertbl;