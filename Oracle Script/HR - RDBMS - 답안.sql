/*

*/
select * from employee;
desc employee;
select * from department;

-- 1.
select ename 이름, dno 부서번호
from employee
where eno = '7788';

-- 2.
select ename 이름, hiredate 입사일
from employee
where hiredate like '81_%';

-- 3.
select ename 이름, job 담당업무, salary 급여
from employee
where job in ('CLERK', 'SALESMAN') and salary not in (1600, 950, 1300);

-- 4.
select trunc(months_between(sysdate, to_date('00/12/12', 'YY/MM/DD'))) 개월수
from dual;

-- 5.
select dno 부서번호, round(avg(salary), 2) 평균월급
from employee
group by dno
having round(avg(salary), 2) >= 2000
order by dno asc;

-- 6.
select eno 사원번호, ename 이름
from employee
where salary > (
    select round(avg(salary), 2)
    from employee
    )
order by salary asc;

-- 7. 
select ename 사원이름, e.dno 부서번호, dname 부서명, loc 부서위치
    from employee e
    JOIN department d
    on e.dno = d.dno
where job = 'MANAGER'
order by ename desc;

-- 8.
create view v_join
as
select ename 사원이름, job 직책, dname 부서명, loc 부서위치
    from employee e
    JOIN department d
    on e.dno = d.dno
where salary in (
    select min(salary)
    from employee
    where dno != 20
    group by dno
    having min(salary) >= 900
);

select * from v_join;

-- 9.
create table emp50
as
select * from employee;

create table dept50
as
select * from department;

alter table emp50
add constraint PK_EMP50_ENO primary key (eno);

alter table dept50
add constraint PK_DEPT50_DNO primary key (dno);

alter table emp50
add constraint FK_EMP50_DNO foreign key (dno) references dept50 (dno);
commit;

-- 10.
-- (1)
insert into emp50
values ('8181', '홍길동', '사무원', '7788', sysdate, 1000, 100, '20');
commit;

-- (2)
update emp50
set commission = 50
where commission is null or commission = 0;
commit;

-- (3)
update dept50
set dname = '운영부', loc = '서울'
where dno = 40;
commit;

-- (4)
delete emp50
where job = 'MANAGER';
commit;

