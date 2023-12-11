/*
    JOIN: DataBase에는 많은 테이블이 존재, 모델링을 통해서 테이블이 분리되어 있다(R-DBMS)
    employee 테이블과 department 테이블은 하나의 테이블인데 모델링(제1,2,3정규화)을 통해서 테이블을 분리
    모델링: 중복 제거, 성능 향상
    
    제약 조건: 테이블의 컬럼에 들어가는 키, 데잍의 무결성(결함없는 데이터, 원하는 값만)
    
        Primary Key:
         - 테이블의 컬럼에 1번만 넣을 수 있다.
         - 두 개 컬럼을 묶어서 PK를 넣을 수 있다.
         - 테이블을 생성할 때 반드시 Primary Key 컬럼이 존재해야 함. - Update, Delete 구문에서 PK 컬럼을 where 조건으로 사용함.
         - 특정 컬럼에 동일한 값(중복된 값)을 넣지 못하도록 함.
         - 반드시 not null 컬럼이어야 함, null을 넣을 수 없음(지정하면 오류).
         - index가 자동으로 생성된다. 컬럼의 검색을 빠르게 함.
         - JOIN 시 ON에서 많이 사용하는 키 컬럼
        
        Unique Key:
         - 컬럼에 중복된 값을 넣지 못하도록 함.
         - null을 넣을 수 있다. 단, 1번만 넣을 수 있다. not null, null
         - 하나에 테이블에 Unique Key를 여러 번 넣을 수 있다.
         - index가 자동으로 생성됨. JOIN 시 ON에 사용됨
         
        Foreigin Key:
         - 다른 테이블(부모 테이블)의 특정 컬럼을 참조해서 값을 넣도록 함.
         - Foreign Key가 참조하는 컬럼은 부모 테이블의 Primary Key, Unique Key를 참조함.
        
        NOT NULL
         - 컬럼에 NULL을 넣을 수 없도록 하는 제약 조건
         
        CHECK
         - 컬럼에 조건을 넣어서 내가 원하는 값만 넣을 수 있도록 함.
         - 월 컬럼에 1~12까지 넣을 수 있도록.
        
        DEFAULT: 제약 조건은 아니지만 제약 조건처럼 사용됨.
         - 컬럼에 값을 넣지 않으면 default로 설정된 값이 등록됨.
*/

select * from employee;     -- employee 테이블의 dno 컬럼은 참조한다(Foreign Key): 자식 테이블 
                            -- department 테이블의 dno 컬럼을 참조한다
select * from department;   -- 부모 테이블

-- 테이블 복사: 원본 테이블의 제약 조건은 복사되어 오지 않는다. Alter Table을 사용해서 제약 조건을 부여

create table emp01
as 
select * from employee;

create table dept01
as
select * from department;

/*
    테이블의 제약 조건을 확인하는 명령어
    user_constraints: 데이터 사전 <- 테이블의 각종 정보를 알려주는 테이블
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');

-- 테이블을 복사하면 테이블의 컬럼에 부여된 제약 조건은 복사되어 오지 않는다. 컬럼과 값만 복사되어 온다.
-- alter table을 사용해서 제약 조건을 부여해야 함.
select * from user_constraints
where table_name in ('EMP01', 'DEPT01');        --EMP01과 DEPT01은 제약 조건이 부여되지 않았다

-- dept01 테이블에 Primary Key 제약 조건을 추가
alter table dept01
add constraint PK_DEPT01_DNO primary key (dno);

-- emp01 테이블에 eno 컬럼에 Primary Key 제약 조건 추가
alter table emp01
add constraint PK_EMP01_ENO primary key (eno);

-- emp01 테이블의 dno 컬럼에 Foreign Key 부여, 참조(references)할 테이블의 컬럼은 Dept01 테이블의 dno 컬럼을 참조
alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references dept01(dno);

-- Primary Key 컬럼을 확인:
desc emp01;

select * from emp01;

-- 값을 넣을 때 컬럼에 부여된 제약 조건을 잘 확인하고 값을 insert
-- eno: Primary Key가 등록, 중복된 값을 넣으면 안됨
-- dno: Foregin Key가 등록, Dept01 테이블의 dno 컬럼에 존재하는 값만 넣어야 함

insert into emp01 (eno, ename, job, manager, hiredate, salary, commission, dno)
values (7977, 'KNK', 'CLERK', 7782, '23/12/11', 1500, null, 40);

commit;     -- DML(insert, update, delete)에서 DB에 영구히 저장되도록 함    <Orcle>

select * from emp01;
select * from dept01;

-- dept 테이블에 값 넣기: dno 컬럼: Primary Key가 있음.
desc dept01;

insert into dept01 (dno, dname, loc)
values (50, 'HR', 'SEOUL');

commit;     -- DML(insert, update, delete)에서 반드시 적용

select * from dept01;

select * from emp01;

-- JOIN: 여러 테이블의 컬럼을 출력할 때 JOIN을 사용해서 하나의 테이블처럼 출력함
    -- 두 테이블의 공통 키 컬럼을 확인
    -- emp01, dept01 테이블의 공통 키 컬럼은 dno이다.
    -- EQUI JOIN: 오라클에서만 작동하는 JOIN 구문
    -- ANSI JOIN: 모든 DBMS에서 공통으로 사용되는 JOIN 구문
    
-- EQUI JOIN 구문으로 두 테이블 조인
-- from 절에서 JOIN 할 테이블을 명시(,)
-- 테이블 이름은 별칭이름으로 둠.
-- where 절에서 두 테이블의 공통 키 컬럼을 명시
-- and 절에서 조건을 처리
-- 공통 키 컬럼을 출력 시 반드시 테이블명.컬럼명

select e.eno, e.ename, e.job, d.dno, d.dname, d.loc
from emp01 e, dept01 d
where e.dno = d.dno;

select eno, ename, job, d.dno, dname, loc
from emp01 e, dept01 d
where e.dno = d.dno
and d.dno = 20;

-- ANSI JOIN: 모든 DBMS에서 공통으로 사용되는 JOIN 구문
    -- INNER JOIN: 두 테이블에서 키 컬럼에 공통되는 부분만 출력    <- 80%
    -- OUTER JOIN
        -- LEFT OUTER JOIN
        -- RIGHT OUTER JOIN
        -- FULL OUTER JOIN
    -- SELF JOIN
    -- CLOSS JOIN

-- INNER JOIN: ANSI JOIN
    -- from 절에 JOIN 테이블 이름을 명시,
    -- INNER 키는 생략될 수 있다.       <- 80% 이상
    -- on 절에 두 테이블의 공통 키 컬럼을 명시, 두 테이블의 공통인 것만 출력
    
-- 테이블 이름을 alias(별칭) 시키지 않는 경우
select emp01.eno, emp01.ename, emp01.salary, dept01.dno, dept01.dname, dept01.loc
from emp01 INNER JOIN dept01 
on emp01.dno = dept01.dno;
    
-- 테이블 이름을 alias(별칭) 사용한 경우
select eno, ename, salary, d.dno, dname, loc
from emp01 e INNER JOIN dept01 d
on e.dno = d.dno
where e.dno = 20
order by ename desc;

-- INNER JOIN: ANSI SQL: 모든 DBMS에서 공통으로 사용되는 SQL 윌리(Oracle, MySQL, MSSQL, DB2, ...)
    -- ON 절에 두 테이블의 공통 분모만 출력
select *
from emp01 e JOIN dept01 d
on e.dno = d.dno;

-- OUTER JOIN:
    -- LEFT OUTER JOIN: 왼쪽 테이블의 모든 내용을 출력함
    -- RIGHT OUTER JOIN: 오른쪽 테이블의 모든 내용을 출력함
    -- FULL OUTER JOIN: 왼쪽, 오른쪽 테이블의 모든 내용을 출력함

select * from dept01;
    
insert into dept01(dno, dname, loc)
values (60, 'MANAGE', 'BUSAN');

commit;

-- 가끔 사용 함
-- RIGHT OUTER JOIN: 두 테이블의 공통 부분과 오른쪽(dept01) 테이블의 모든 값을 출력
select *
from emp01 e RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;
    
-- FULL OUTER JOIN: 두 테이블(왼쪽, 오른쪽)의 모든 내용을 출력
select *
from emp01 e FULL OUTER JOIN dept01 d
on e.dno = d.dno;
    
select * from emp01;

-- SELF JOIN: 자신의 테이블을 JOIN, 자신의 테이블을 별칭 이름으로 가상으로 생성해서 JOIN
    -- 조직도 출력, 직급 상사를 바로 출력할 때 사용

select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관사번, m.ename 직속상관명
from emp01 e JOIN emp01 m
on e.manager = m.eno;

-- SELF JOIN으로 사원 이름에 대한 직속 상관이 누구인지 출력
-- 직속 상관이 없는 사원을 출력: LEFT OUTER JOIN
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관사번, m.ename 직속상관명
from emp01 e LEFT OUTER JOIN emp01 m
on e.manager = m.eno;
    
-- 사원번호는 있지만 어떤 사원의 상관이 아닌 사원도 모두 출력: RIGHT OUTER JOIN
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관사번, m.ename 직속상관명
from emp01 e RIGHT OUTER JOIN emp01 m
on e.manager = m.eno;

-- 직속 상관이 없는 것(왼쪽), 사원 번호는 가지고 있지만 어떤 사원의 직속 상관이 아닌 사원(오른쪽)


select eno, ename, manager, eno, ename
from employee;
    
-- 1. 사원이름 'SCOTT'의 부서명(dname), 부서위치(loc)  <- ename: 'SCOTT'은 emp01, dept01: dname, loc
-- ANSI JOIN
select * from emp01;
select * from dept01;

-- emp01, dept01을 JOIN 해서 출력
select e.ename 사원이름, d.dname 부서명, d.loc 부서위치
from emp01 e JOIN dept01 d
on e.dno = d.dno
where ename = 'SCOTT';

-- 2. 월급이 2000만원 이상인 사원의 이름, 부서명, 부서위치, 월급을 출력: ANSI JOIN
select ename 사원이름, dname 부서명, loc 부서위치, salary 월급, e.dno 부서번호
from emp01 e JOIN dept01 d
on e.dno = d.dno
where salary >= 2000
order by e.dno desc;

-- ANSI JOIN
-- 3. 직책이 'MANAGER'인 사원 이름(ename), 부서번호(dno), 부서명(dname), 부서위치(loc) 출력하되 사원이름 내림차순 정렬
select ename 사원이름, d.dno 부서번호, dname 부서명, loc 부서위치, job
from emp01 e JOIN dept01 d
on e.dno = d.dno
where job = 'MANAGER'
order by ename desc;



                                                                                                                                                                                                                                        