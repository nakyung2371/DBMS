
/*
    select: ���̺��� ���� �˻�
    
    select �÷��� from ���̺��(���)
    
    select * from employee:
    
*/

-- employee ���̺��� ��� �÷��� ����ϱ�

select * from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename, job
from employee;

-- Ư�� �÷��� ���� �� ����ϱ�, �÷��� ������ �� �� �ִ�. �÷� �̸��� �ٲ� �� �ִ�.
select eno, ename, salary, ename, ename, salary, salary * 12
from employee;

-- �÷� �̸��� ��Ī���� �ٲٰ� ����ϱ�
select eno as �����ȣ, ename �����, salary as ����, salary * 12 as ����
from employee;

-- employee ���̺��� �� �÷��� �ǹ�
select *
from employee;

select eno �����ȣ, ename �����, job ��å, manager ���ӻ��,
    hiredate �Ի糯¥, salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;

-- ���̺� ������ Ȯ���ϱ�: desc ���̺��, ���� Ŀ����, null ��� ����, �ڷ���(number: ����, �Ǽ�, char, varchar2: ���ڿ�)
desc employee;      -- insert �� �÷��� �ڷ���, NULL ��� ���θ� Ȯ�� �� ���� ����.

select * from employee;

-- ������ ��� - ����: NULL���� ������ ����� NULL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�          -- ���� ���̺� ���
from employee;

-- ���� = ���� * 12 + ���ʽ�
    -- null �÷��� ������ �ϸ� ��� null
    
-- null ó���� �ȵ�
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,          -- ���� ���̺� ���
    salary * 12 + commission ����
from employee;

-- nvl (�÷���, 0): null�� ó���ϴ� �Լ�, �÷��� �� �� null�� 0���� ��ȯ�ϴ� �Լ�
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,          -- ���� ���̺� ���
    nvl (commission, 0) ��ó����, salary * 12 + nvl (commission, 0) ����
from employee;

-- �÷��� �÷��� ������ �� �ִ�. : +, -, *, /   <- number (����, �Ǽ�) Ÿ��
-- number: ����
-- number(7.2): �Ǽ�          ��ü 7�ڸ�, �Ҽ��� ���� 2�ڸ�

select * from employee;
desc employee;

select ename, salary, salary + salary as "+ ����", salary * salary as "* ����", salary * 0.1 as "������10%"
from employee;

--�ߺ� ó�� �� ���: distinct �÷���, �÷����� �ߺ��� ���� �� ���

select * from employee;

-- �츮 ȸ���� �μ��� ���
select distinct dno
from employee;

-- �츮 ȸ���� ��å�� �ߺ� ���� �� ���(CLERK: �繫��, SALESMAN: �������, MANAGER: ������, ANALYST: �м���
    -- PRESIDENT: ����)
    -- ��ҹ��� ������ ���� ����: ����(select, create, from, group by, order by), �÷���, ���̺��
    -- ���̺� ���� ���ڵ��� ���� ��ҹ��ڸ� ������
    
select distinct job
from employee;

select * from employee;

-- JOB(��å)�� MANAGER(������)�� ����� ������ ���

select ename �����, job ��å
from employee
where job = 'MANAGER';

-- �μ� ���̺� Ȯ��: department
select * from department;

select dno �μ���ȣ, dname �μ���, loc �μ���ġ
from department;

-- salgrade: ������ ����� �����ϴ� ���̺�
select * from salgrade;
select grade �����ǵ��, losal ���ϳ�������, hisal ���ϳ�������
from salgrade;

-- SELECT ���� ��ü ����, SQL: ����ȭ�� ���� ���
/*
<������ �� �� ������ ������ �ٲ�� �� ��>

SELECT �÷���
FROM ���̺��[���]
WHERE ����
GROUP BY �÷���            <- �÷��� ������ ���� �׷����ؼ� ó����
HAVING ����                <- GROUP BY ����� ���� ����
ODER BY �÷��� ASC[DESC]   <- �÷��� �����ؼ� ���, ASC: �������� ����, DESC: �������� ����
*/

-- where ���� ����ϱ�: �� ������(NUMBER Ÿ���� �÷����� ���): =: ����, >, <, >=, <=
    -- ���� �ʴ�: <>, !=, ^=
    -- or
    -- and
    -- between
    -- in(   )
    
select * from employee;

select *
from employee
where salary > 1500;

select *
from employee
where salary = 1500;

select *
from employee
where salary ^= 1500;

-- or ������
select *
from employee
where salary = 1500 or salary = 800 or salary = 1600;

-- in Ű����: in (��, ��, ��)
select *
from employee
where salary in (1500, 800, 1600);

-- and ������ ���: �μ� ��ȣ�� 10���� ����� ������ 1500 �̻��� ����ڸ� ���
select *
from employee
where dno = 10 and salary > 1500;

-- ��å�� manager�̸鼭 ������ 2000 �̻��� ����� ��� ��ȣ, �����, ������ ���
select eno �����ȣ, ename �����, salary ����, job ��å
from employee
where job = 'MANAGER' and salary >= 2000;

-- �� �����ڸ� date, varchar, char: 81�⵵ �Ի��� ����� ��� ���
select *
from employee
where hiredate > '81/01/01' and hiredate < '81/06/30';

-- ���ڿ�: char, varchar, nvarchar, nchar: ���ڿ�, ''
select *
from employee
where ename < 'D';

-- like: ���ڿ����� Ư�� ���� �˻�: %: ��� ���� �͵� �������, _: �� ���ڰ� � ���� �͵� �������.
-- �÷��� Ư�� ���� �˻� �� �����

select * from employee
where ename like '%LA%';


