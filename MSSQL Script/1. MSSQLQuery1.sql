
-- ���� �ּ�

/*
	���� �� �ּ�
*/

-- 1. ����� DB ����
create database myDB;

-- 2. ����� DB�� ����
use myDB;

-- 3. myDB���� ���̺� ����
/*
	Oracle: ����(number(4)), �Ǽ�(number(7,2)), ����: varchar2(50)
	MSSQL, MySQL: ����(int), �Ǽ�(float), ����: varchar(50)
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
	��ü�� ��ü �̸�: DB, ���̺��, ���, �������ν�����, �Լ�
	dbo: ���� ����

	DB��.��Ű����.��ü�̸�
*/

select * from myDB.dbo.emp01;

select * from emp01;

/*
	Oracle: ������ ����(user_*)�� ���� �ý����� ������ ���, sp_*

	sp_helpdb: �ý����� ��� DB ������ ��� <- MSSQL
	sp_help '��Ű����.���̺��'; <- ���̺��� ������ ���
*/

sp_helpdb;
sp_help 'dbo.emp01';		-- desc emp01, select * from user_constraint where table_name in ('EMP01')

-- 3. �� �ֱ�: MSSQL�� �ڵ� Ŀ�� Ʈ�����(insert, update, delete)
insert into emp01 (eno, ename, salary, hiredate, dno)
values (1, 'ȫ�浿', 500, '81-01-01',10);

insert into emp01 (eno, ename, salary, hiredate, dno)
values (2, '��浿', 1000, '71-01-01',20);

-- 4. �� ���� �� ��������� Ʈ�����: ALL or Nothing
	-- ȫ�浿 ���޿��� 30�� ����ؼ� ��浿 �������� �Ա�
begin transaction;

-- ȫ�浿 ���¿��� 30�� ���
update emp01
set salary = salary - 30
where eno = 1;

-- ��浿 ���¿��� 30�� �Ա�
update emp01
set salary = salary + 30
where eno = 2;

rollback;
commit;

select * from emp01;

-- delete
delete emp01
where eno = 1;

rollback;		-- ��������� Ʈ������� �����ؾ� commit, rollback �� �� �ִ�.


-- �μ� ���̺�: dept01
create table dept01 (
	dno int not null constraint PK_DEPT01_DNO primary key,
	dname varchar(50) not null,
	loc varchar(50) null
);

select * from dept01;
sp_help 'dbo.dept01';

insert into dept01
values (10, '�λ��', '����');

insert into dept01
values (20, '������', '�λ�');

insert into dept01
values (30, '������', '����');

select * from emp01;
select * from dept01;

-- alter table�� ����ؼ� emp01(dno): FK -> dept01(dno)

alter table emp01
add constraint FK_EMP01_DNO foreign key (dno) references dept01 (dno);

sp_help 'dbo.emp01';

-- JOIN: AMSI JOIN: INNER JOIN	<- ERD(DB ���� ���̺�� ���̺��� ����)

select *
from emp01 e
	JOIN dept01 d
	on e.dno = d.dno;

insert into emp01
values (3, '���浿', 2000, '22-03-10', 30);

-- �μ��� ����Ǿ� ���� �ʴ� �μ��� ���: Right Outer JOIN
select *
from emp01 e
	RIGHT OUTER JOIN dept01 d
	on e.dno = d.dno;