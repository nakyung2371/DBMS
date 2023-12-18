
-- 한줄 주석

/*
	여러 줄 주석
*/

-- 1. 사용자 DB 생성
create database myDB;

-- 2. 사용자 DB에 연결
use myDB;

-- 3. myDB에서 테이블 생성
/*
	Oracle: 정수(number(4)), 실수(number(7,2)), 문자: varchar2(50)
	MSSQL, MySQL: 정수(int), 실수(float), 문자: varchar(50)
		- MySQL: double
		- MSSQL: real

*/

create table emp01 (
	eno int not null constraint PK_EMP01_ENO primary key,
	ename varchar(50) not null,
	salary float not null,
	hiredate date,
	dno int
);

/*
	객체의 전체 이름: DB, 테이블명, 뷰명, 저장프로시저명, 함수
	dbo: 생략 가능

	DB명.스키마명.객체이름
*/

select * from myDB.dbo.emp01;

select * from emp01;

/*
	Oracle: 데이터 사전(user_*)과 같이 시스템의 정보를 출력, sp_*

	sp_helpdb: 시스템의 모든 DB 정보를 출력 <- MSSQL
	sp_help '스키마명.테이블명'; <- 테이블의 정보를 출력
*/

sp_helpdb;
sp_help 'dbo.emp01';		-- desc emp01, select * from user_constraint where table_name in ('EMP01')

-- 3. 값 넣기: MSSQL은 자동 커밋 트랜잭션(insert, update, delete)
insert into emp01 (eno, ename, salary, hiredate, dno)
values (1, '홍길동', 500, '81-01-01',10);

insert into emp01 (eno, ename, salary, hiredate, dno)
values (2, '김길동', 1000, '71-01-01',20);

-- 4. 값 넣을 때 명시적으로 트랜잭션: ALL or Nothing
	-- 홍길동 월급에서 30억 출금해서 김길동 월급으로 입금
begin transaction;

-- 홍길동 계좌에서 30억 출금
update emp01
set salary = salary - 30
where eno = 1;

-- 김길동 계좌에서 30억 입금
update emp01
set salary = salary + 30
where eno = 2;

rollback;
commit;

select * from emp01;

-- delete
delete emp01
where eno = 1;

rollback;		-- 명시적으로 트랜잭션을 시작해야 commit, rollback 할 수 있다.


-- 부서 테이블: dept01
create table dept01 (
	dno int not null constraint PK_DEPT01_DNO primary key,
	dname varchar(50) not null,
	loc varchar(50) null
);

select * from dept01;
sp_help 'dbo.dept01';

insert into dept01
values (10, '인사부', '서울');

insert into dept01
values (20, '관리부', '부산');

insert into dept01
values (30, '영업부', '광주');

select * from emp01;
select * from dept01;

-- alter table을 사용해서 emp01(dno): FK -> dept01(dno)

alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references dept01 (dno);

sp_help 'dbo.emp01';

-- JOIN: AMSI JOIN: INNER JOIN	<- ERD(DB 내의 테이블과 테이블의 관계)

select *
from emp01 e
	JOIN dept01 d
	on e.dno = d.dno;

insert into emp01
values (3, '옥길동', 2000, '22-03-10', 30);

-- 부서가 적용되어 있지 않는 부서를 출력: Right Outer JOIN
select *
from emp01 e
	RIGHT OUTER JOIN dept01 d
	on e.dno = d.dno;