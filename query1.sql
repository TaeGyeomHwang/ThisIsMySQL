create database sampledb;

use sampledb;

create table sampleTBL (name char(10) not null primary key, age int null);

insert into sampleTBL values("홍길동", 30);
-- insert into sampleTBL(name) values("홍길동"); 불가능
insert into sampleTBL(name) values("김김김");
/*
insert into sampleTBL(age) values(30); 불가능
*/

select * from sampleTBL;