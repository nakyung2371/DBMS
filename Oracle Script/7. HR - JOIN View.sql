/*
    JOIN: DataBase���� ���� ���̺��� ����, �𵨸��� ���ؼ� ���̺��� �и��Ǿ� �ִ�(R-DBMS)
    employee ���̺�� department ���̺��� �ϳ��� ���̺��ε� �𵨸�(��1,2,3����ȭ)�� ���ؼ� ���̺��� �и�
    �𵨸�: �ߺ� ����, ���� ���
    
    ���� ����: ���̺��� �÷��� ���� Ű, ������ ���Ἲ(���Ծ��� ������, ���ϴ� ����)
    
        Primary Key:
         - ���̺��� �÷��� 1���� ���� �� �ִ�.
         - �� �� �÷��� ��� PK�� ���� �� �ִ�.
         - ���̺��� ������ �� �ݵ�� Primary Key �÷��� �����ؾ� ��. - Update, Delete �������� PK �÷��� where �������� �����.
         - Ư�� �÷��� ������ ��(�ߺ��� ��)�� ���� ���ϵ��� ��.
         - �ݵ�� not null �÷��̾�� ��, null�� ���� �� ����(�����ϸ� ����).
         - index�� �ڵ����� �����ȴ�. �÷��� �˻��� ������ ��.
         - JOIN �� ON���� ���� ����ϴ� Ű �÷�
        
        Unique Key:
         - �÷��� �ߺ��� ���� ���� ���ϵ��� ��.
         - null�� ���� �� �ִ�. ��, 1���� ���� �� �ִ�. not null, null
         - �ϳ��� ���̺� Unique Key�� ���� �� ���� �� �ִ�.
         - index�� �ڵ����� ������. JOIN �� ON�� ����
         
        Foreigin Key:
         - �ٸ� ���̺�(�θ� ���̺�)�� Ư�� �÷��� �����ؼ� ���� �ֵ��� ��.
         - Foreign Key�� �����ϴ� �÷��� �θ� ���̺��� Primary Key, Unique Key�� ������.
        
        NOT NULL
         - �÷��� NULL�� ���� �� ������ �ϴ� ���� ����
         
        CHECK
         - �÷��� ������ �־ ���� ���ϴ� ���� ���� �� �ֵ��� ��.
         - �� �÷��� 1~12���� ���� �� �ֵ���.
        
        DEFAULT: ���� ������ �ƴ����� ���� ����ó�� ����.
         - �÷��� ���� ���� ������ default�� ������ ���� ��ϵ�.
*/

select * from employee;     -- employee ���̺��� dno �÷��� �����Ѵ�(Foreign Key): �ڽ� ���̺� 
                            -- department ���̺��� dno �÷��� �����Ѵ�
select * from department;   -- �θ� ���̺�

-- ���̺� ����: ���� ���̺��� ���� ������ ����Ǿ� ���� �ʴ´�. Alter Table�� ����ؼ� ���� ������ �ο�

create table emp01
as 
select * from employee;

create table dept01
as
select * from department;

/*
    ���̺��� ���� ������ Ȯ���ϴ� ��ɾ�
    user_constraints: ������ ���� <- ���̺��� ���� ������ �˷��ִ� ���̺�
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE', 'DEPARTMENT');

-- ���̺��� �����ϸ� ���̺��� �÷��� �ο��� ���� ������ ����Ǿ� ���� �ʴ´�. �÷��� ���� ����Ǿ� �´�.
-- alter table�� ����ؼ� ���� ������ �ο��ؾ� ��.
select * from user_constraints
where table_name in ('EMP01', 'DEPT01');        --EMP01�� DEPT01�� ���� ������ �ο����� �ʾҴ�

-- dept01 ���̺� Primary Key ���� ������ �߰�
alter table dept01
add constraint PK_DEPT01_DNO primary key (dno);

-- emp01 ���̺� eno �÷��� Primary Key ���� ���� �߰�
alter table emp01
add constraint PK_EMP01_ENO primary key (eno);

-- emp01 ���̺��� dno �÷��� Foreign Key �ο�, ����(references)�� ���̺��� �÷��� Dept01 ���̺��� dno �÷��� ����
alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references dept01(dno);

-- Primary Key �÷��� Ȯ��:
desc emp01;

select * from emp01;

-- ���� ���� �� �÷��� �ο��� ���� ������ �� Ȯ���ϰ� ���� insert
-- eno: Primary Key�� ���, �ߺ��� ���� ������ �ȵ�
-- dno: Foregin Key�� ���, Dept01 ���̺��� dno �÷��� �����ϴ� ���� �־�� ��

insert into emp01 (eno, ename, job, manager, hiredate, salary, commission, dno)
values (7977, 'KNK', 'CLERK', 7782, '23/12/11', 1500, null, 40);

commit;     -- DML(insert, update, delete)���� DB�� ������ ����ǵ��� ��    <Orcle>

select * from emp01;
select * from dept01;

-- dept ���̺� �� �ֱ�: dno �÷�: Primary Key�� ����.
desc dept01;

insert into dept01 (dno, dname, loc)
values (50, 'HR', 'SEOUL');

commit;     -- DML(insert, update, delete)���� �ݵ�� ����

select * from dept01;

select * from emp01;

-- JOIN: ���� ���̺��� �÷��� ����� �� JOIN�� ����ؼ� �ϳ��� ���̺�ó�� �����
    -- �� ���̺��� ���� Ű �÷��� Ȯ��
    -- emp01, dept01 ���̺��� ���� Ű �÷��� dno�̴�.
    -- EQUI JOIN: ����Ŭ������ �۵��ϴ� JOIN ����
    -- ANSI JOIN: ��� DBMS���� �������� ���Ǵ� JOIN ����
    
-- EQUI JOIN �������� �� ���̺� ����
-- from ������ JOIN �� ���̺��� ���(,)
-- ���̺� �̸��� ��Ī�̸����� ��.
-- where ������ �� ���̺��� ���� Ű �÷��� ���
-- and ������ ������ ó��
-- ���� Ű �÷��� ��� �� �ݵ�� ���̺��.�÷���

select e.eno, e.ename, e.job, d.dno, d.dname, d.loc
from emp01 e, dept01 d
where e.dno = d.dno;

select eno, ename, job, d.dno, dname, loc
from emp01 e, dept01 d
where e.dno = d.dno
and d.dno = 20;

-- ANSI JOIN: ��� DBMS���� �������� ���Ǵ� JOIN ����
    -- INNER JOIN: �� ���̺��� Ű �÷��� ����Ǵ� �κи� ���    <- 80%
    -- OUTER JOIN
        -- LEFT OUTER JOIN
        -- RIGHT OUTER JOIN
        -- FULL OUTER JOIN
    -- SELF JOIN
    -- CLOSS JOIN

-- INNER JOIN: ANSI JOIN
    -- from ���� JOIN ���̺� �̸��� ���,
    -- INNER Ű�� ������ �� �ִ�.       <- 80% �̻�
    -- on ���� �� ���̺��� ���� Ű �÷��� ���, �� ���̺��� ������ �͸� ���
    
-- ���̺� �̸��� alias(��Ī) ��Ű�� �ʴ� ���
select emp01.eno, emp01.ename, emp01.salary, dept01.dno, dept01.dname, dept01.loc
from emp01 INNER JOIN dept01 
on emp01.dno = dept01.dno;
    
-- ���̺� �̸��� alias(��Ī) ����� ���
select eno, ename, salary, d.dno, dname, loc
from emp01 e INNER JOIN dept01 d
on e.dno = d.dno
where e.dno = 20
order by ename desc;

-- INNER JOIN: ANSI SQL: ��� DBMS���� �������� ���Ǵ� SQL ����(Oracle, MySQL, MSSQL, DB2, ...)
    -- ON ���� �� ���̺��� ���� �и� ���
select *
from emp01 e JOIN dept01 d
on e.dno = d.dno;

-- OUTER JOIN:
    -- LEFT OUTER JOIN: ���� ���̺��� ��� ������ �����
    -- RIGHT OUTER JOIN: ������ ���̺��� ��� ������ �����
    -- FULL OUTER JOIN: ����, ������ ���̺��� ��� ������ �����

select * from dept01;
    
insert into dept01(dno, dname, loc)
values (60, 'MANAGE', 'BUSAN');

commit;

-- ���� ��� ��
-- RIGHT OUTER JOIN: �� ���̺��� ���� �κа� ������(dept01) ���̺��� ��� ���� ���
select *
from emp01 e RIGHT OUTER JOIN dept01 d
on e.dno = d.dno;
    
-- FULL OUTER JOIN: �� ���̺�(����, ������)�� ��� ������ ���
select *
from emp01 e FULL OUTER JOIN dept01 d
on e.dno = d.dno;
    
select * from emp01;

-- SELF JOIN: �ڽ��� ���̺��� JOIN, �ڽ��� ���̺��� ��Ī �̸����� �������� �����ؼ� JOIN
    -- ������ ���, ���� ��縦 �ٷ� ����� �� ���

select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
from emp01 e JOIN emp01 m
on e.manager = m.eno;

-- SELF JOIN���� ��� �̸��� ���� ���� ����� �������� ���
-- ���� ����� ���� ����� ���: LEFT OUTER JOIN
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
from emp01 e LEFT OUTER JOIN emp01 m
on e.manager = m.eno;
    
-- �����ȣ�� ������ � ����� ����� �ƴ� ����� ��� ���: RIGHT OUTER JOIN
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
from emp01 e RIGHT OUTER JOIN emp01 m
on e.manager = m.eno;

-- ���� ����� ���� ��(����), ��� ��ȣ�� ������ ������ � ����� ���� ����� �ƴ� ���(������)


select eno, ename, manager, eno, ename
from employee;
    
-- 1. ����̸� 'SCOTT'�� �μ���(dname), �μ���ġ(loc)  <- ename: 'SCOTT'�� emp01, dept01: dname, loc
-- ANSI JOIN
select * from emp01;
select * from dept01;

-- emp01, dept01�� JOIN �ؼ� ���
select e.ename ����̸�, d.dname �μ���, d.loc �μ���ġ
from emp01 e JOIN dept01 d
on e.dno = d.dno
where ename = 'SCOTT';

-- 2. ������ 2000���� �̻��� ����� �̸�, �μ���, �μ���ġ, ������ ���: ANSI JOIN
select ename ����̸�, dname �μ���, loc �μ���ġ, salary ����, e.dno �μ���ȣ
from emp01 e JOIN dept01 d
on e.dno = d.dno
where salary >= 2000
order by e.dno desc;

-- ANSI JOIN
-- 3. ��å�� 'MANAGER'�� ��� �̸�(ename), �μ���ȣ(dno), �μ���(dname), �μ���ġ(loc) ����ϵ� ����̸� �������� ����
select ename ����̸�, d.dno �μ���ȣ, dname �μ���, loc �μ���ġ, job
from emp01 e JOIN dept01 d
on e.dno = d.dno
where job = 'MANAGER'
order by ename desc;

-- VIEW(��): ������ ���̺�, ���� ������ �ʰ� �ڵ常 ������.
    -- 1. ���� ���̺��� Ư�� �÷��� ����� ��  <- ����
    -- 2. ������ ������ �� �� ���� ����    <- ������ JOIN ������ �ܼ�ȭ �� �� �ִ�. 

-- view�� �ǽ��ϱ� ���� ���� ���̺�: emp02
drop table EMP02 cascade constraints;

create table EMP02
as
select eno, ename, salary, commission, job, hiredate, dno
from employee
where salary > 1500;

select * from emp02;

create table dept02
as
select * from department;

select * from dept02;

-- ������ �������̺�: employee, department -> emp01, dept01
    -- �ʵ��, ���� �����
    -- �÷��� �ο��� ���� ������ ������� ���� <- Alter Table�� ����ؼ� ���� ���� �߰�

select * from user_constraints where table_name in ('EMPLOYEE', 'DEPARTMENT');
select * from user_constraints where table_name in ('EMP02', 'DEPT02');

-- 1. DEPT02 ���̺��� dno(Primary Key)
-- 2. EMP01 ���̺��� eno(Primary Key), dno(Foreign Key) -> dept02(dno)

alter table DEPT02
add constraints PK_DEPT02_DNO primary key (dno);

alter table EMP02
add constraints PK_EMP02_ENO primary key (eno);

alter table EMP02
add constraints FK_EMP02_DNO foreign key (dno) references dept02(dno);

-- VIEW ���� 1. ���� ���̺��� �߿� ������ ���߰� ���, ������ ����� �� �ִ�.
    -- as ������ select �ڵ带 ������ ����
select * from emp02;    -- ���� ���̺�: emp02

-- �� ����: ���� ���̺��� ���� ������ ���� �ƴ϶� ���� �ڵ常 ������.
create view v_emp02
as
select ename, job, dno
from emp02;

-- �� ����:
select �÷��� from ���̺��[���]
select * from v_emp02;

-- ������ ����: user_���̺�     <- �ý����� ������ ����Ǿ� �ִ� ���̺�
select * from user_views;

-- 2. ����� ���Ǽ�, ������ ������ view�� �����ؼ� ������� �ΰ� ����    <- JOIN

-- �� ���̺��� join�ؼ� ������ 2500 �̻��� ��� ������ ���
create view v_join
as
select ename, job, salary, dname, loc
from emp02 e
    join dept02 d
    on e.dno = d.dno
where salary >= 2500;

select * from v_join;
select * from employee;
select * from department;
-- employee, department ���̺��� �μ����� �ּ� ������ �޴� ��� �̸�, ����� ��å, �μ���, �μ� ��ġ�� ����ϵ�
-- �ּ� ������ 1500 �̻��� ��� ������ ���, �μ� ��ȣ 20�� ����
-- �� �ȿ� ������ �����ϰ� �並 �����ؼ� ���     <- JOIN, group by, where, having, subquery

-- �μ����� �ּ� ������ �޴� ��� ������ ����ϴ� view, 20�� �μ��� ���ܵ�
create view v_emp
as
select ename ����̸�, job ��å, dname �μ���, loc �μ���ġ
    from employee e
    JOIN department d
    on e.dno = d.dno
where salary in(
    select min(salary) from employee
    where dno != 20
    group by dno
    having min(salary) > 900
    );
    
-- �ּҿ��� 900 �̻� �� �־ ������
create or replace view v_emp
as
select ename ����̸�, job ��å, dname �μ���, loc �μ���ġ, d.dno �μ���ȣ
    from employee e
    JOIN department d
    on e.dno = d.dno
where salary in(
    -- �μ����� �ּ� ����
    select min(salary) from employee
    where dno != 20
    group by dno
    having min(salary) > 900
    );

select * from v_emp;
desc v_emp;


create or replace view v_join3
as
select ename ����̸�, job ��å, dname �μ���, loc �μ���ġ, d.dno �μ���ȣ
    from employee e
    JOIN department d
    on e.dno = d.dno
where salary in(
    -- �μ����� �ּ� ����
    select min(salary) from employee
    where dno != 20
    group by dno
    having min(salary) > 900
)                             
order by ename desc;

select * from v_join3

-- view�� as ����� select���� ��
    -- ���� ���� ������ ���� ����. select �ڵ常 �������
    -- ���� ���̺��� �÷��� �� ��Ī�� ���
    -- insert, update, delete�� view�� ���ؼ� �� �� �ִ�. ��, ���� ���̺� �� �÷��� ���� ���ǿ� ���� �� ����
    
select * from emp02;

-- view ����
drop view v_test01;

-- view ����
create view v_test01
as
select eno, ename, dno
from employee
    
-- view ����
select * from v_test01;

-- view�� ���� ���� �� �ִ� -> ���� ���̺� ���� ��
insert into v_test01 (eno, ename, dno)
values (8080, 'HONG', 30);

commit;
    
-- view�� ����ؼ� ���� ����: update     <- where ������ �ݵ�� ���
update v_test01
set ename = 'KIM'
where eno = 8080;

commit;

-- view�� ����ؼ� ���� ����: delete <- where ������ �ݵ�� ����ؾ� �ϰ� �÷����� primary key�� �� �÷�
    
delete v_test01
where eno = 8080;

commit;

select * from emp02;

-- v_test02: insert(�ȵ�), update(����), delete(����) -> ���� ���̺��� ���� ���ǿ� �� �¾ƾ� �Ѵ�.
create view v_test02
as
select eno, ename, salary
from emp02;
    
insert into v_test02 (eno, ename, salary)
values (9090, 'SIM', 3500);

-- ���̺��� Ư�� �÷��� not null ���� ���� �߰�
alter table emp02
modify dno not null;

delete v_test02
where eno = 9090;