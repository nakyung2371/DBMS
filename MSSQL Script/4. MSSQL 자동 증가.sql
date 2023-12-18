-- 컬럼의 값을 넣지 않을 때 자동으로 증가되는 컬럼: identity
-- identity 컬럼은 값을 넣지 않는다.
-- 초기값: 1, 증가값: 1
-- 정수 선언(int, bigint)
-- primary key

create table abc (
	a int not null identity primary key,
	b varchar(50),
	c varchar(50)
);

insert into abc
values ('서울', 'add1');

select * from abc;