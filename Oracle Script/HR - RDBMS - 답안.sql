/*

*/
select * from employee;
desc employee;
select * from department;

-- 1.
select ename �̸�, dno �μ���ȣ
from employee
where eno = '7788';

-- 2.
select ename �̸�, hiredate �Ի���
from employee
where hiredate like '81_%';

-- 3.
select ename �̸�, job ������, salary �޿�
from employee
where job in ('CLERK', 'SALESMAN') and salary not in (1600, 950, 1300);

-- 4.
select trunc(months_between(sysdate, to_date('00/12/12', 'YY/MM/DD'))) ������
from dual;

-- 5.
select dno �μ���ȣ, round(avg(salary), 2) ��տ���
from employee
group by dno
having round(avg(salary), 2) >= 2000
order by dno asc;

-- 6.
select eno �����ȣ, ename �̸�
from employee
where salary > (
    select round(avg(salary), 2)
    from employee
    )
order by salary asc;

-- 7. 
select ename ����̸�, e.dno �μ���ȣ, dname �μ���, loc �μ���ġ
    from employee e
    JOIN department d
    on e.dno = d.dno
where job = 'MANAGER'
order by ename desc;

-- 8.
create view v_join
as
select ename ����̸�, job ��å, dname �μ���, loc �μ���ġ
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
values ('8181', 'ȫ�浿', '�繫��', '7788', sysdate, 1000, 100, '20');
commit;

-- (2)
update emp50
set commission = 50
where commission is null or commission = 0;
commit;

-- (3)
update dept50
set dname = '���', loc = '����'
where dno = 40;
commit;

-- (4)
delete emp50
where job = 'MANAGER';
commit;

