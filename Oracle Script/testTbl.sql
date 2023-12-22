create table testTbl (
    id number(4) not null primary key,
    name varchar2(50) not null,
    email varchar2(200) null
);

select * from testTbl
order by id desc;