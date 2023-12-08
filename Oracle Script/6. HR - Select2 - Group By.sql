/*
    �׷� �Լ�: group by, having
    
    select �÷���
    from ���̺��[��]
    where ����
    group by �÷���[������ ���� �׷���]
    having ����[group by �� ��� ���� ����]
    order by �÷��� asc[desc]
*/

/*
    ���� �Լ�: number Ÿ���� �÷��� ����    <- NULL�� �ڵ����� ó����
    SUM - �÷��� ��� ���� ��
    AVG - �÷��� ��� ���� ���
    MAX - �÷��� �ִ밪
    MIN - �÷��� �ּҰ�
    COUNT(*) - �׷��ε� ���ڵ� �� ���
    
    ����: ���� ������ ����� �Ǳ� ������ �ٸ� �÷��� ��� �� ����
        ��, group by ���� grouping �� �÷��� ��� ����
*/
desc employee;
--select SUM(salary), ename      <- �ٸ� �÷��� ���� ����ϸ� ����

-- �÷��� �Լ� ���: ����
-- ����(salary)
select SUM(salary) �հ�, round(AVG(salary), 2) ���, MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) ���ȷ��ڵ��
from employee;

-- ���ʽ�(commission)      <- ���� �Լ��� NULL�� �ڵ����� ó��
select SUM(commission) �հ�, round(AVG(commission), 2) ���, MAX(commission) �ִ밪, MIN(commission) �ּҰ�, COUNT(*) ���ȷ��ڵ��
from employee;

-- �μ����� ������ �հ�, ���, �ִ����, �ּҿ���, �׷��ε� ���� ���

select dno, SUM(salary) �հ�, ROUND(AVG(salary), 2) ���, MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) ���ȷ��ڵ��    -- �׷��ε� �÷��� ��� ����
from employee
group by dno;        -- dno �÷��� ������ ���� �׷����ؼ� ���� �Լ��� ����

select salary, dno
from employee
order by dno asc;

-- ��å���� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��ε� ���� ����غ�����
select job ��å, SUM(salary) �հ�, ROUND(AVG(salary), 2) ���, MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) ���ȷ��ڵ��
from employee
group by job
order by job asc;

/*
    group by ������ where[����] vs having[����]
        where[����]: group by �ϱ� ���� ������ ������       , ��Ī �̸��� ����� �� ����
        having[����]: group by �ؼ� ���� ����� ���� ����   , ��Ī �̸��� ����� �� ����
        
        order by �÷��� asc[desc]: ��Ī �̸��� ��� ����
*/

-- ���޺��� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��ε� ���� ����ϵ�, �μ� ��ȣ 20�� �����ϰ�, �μ����� ����� 2000 �̻��� ���븸 ���
select job ��å, SUM(salary) �հ�, ROUND(AVG(salary), 2) ���, MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) ���ȷ��ڵ��
from employee
where eno != 20
group by job
having ROUND(AVG(salary), 2) >= 2000
order by ROUND(AVG(salary), 2) asc;

-- group by ������ �÷��� 2�� �̻�, �� �÷��� ���ļ� ������ ������ �׷�����
    -- job, dno
select job, dno from employee
order by job asc;

select dno, job,sum(salary) ���Ѱ�, count(*)
from employee
group by job, dno;

-- �� ��å(job)�� ���ؼ� ������ �հ�, ���, �ִ밪, �ּҰ�, ī��Ʈ ���� ����ϵ�, �Ի����� 81�⵵ �Ի��� ����鸸 ����
-- ������ ����� 1500���� �̻��� �͸� ����ϵ�, ����� �������� ����
select job ��å, SUM(salary) �հ�, ROUND(AVG(salary), 2) ���, MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) ī��Ʈ��
from employee
where hiredate >= '81/01/01'
-- where hiredate like '81%'
group by job
having ROUND(AVG(salary), 2) >= 1500
order by ��� desc;

/*
    group by ������ ���Ǵ� Ű����
    rollup: group by �÷� <- ��� ������ ���ο� ��ü ����� �� �� �� ���
    cube: �׷��� ������ ���ο� ��� ���, ������ ���ο� ��ü ����� ���������� ���
*/

-- 1. rollup, cube Ű���带 ������� �ʴ� ���: �׷����� ����� ���
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by dno, job
order by count(*) desc;

select dno, job
from employee
order by dno asc;

-- 2. rollup Ű���带 ����ϴ� ���: �׷����� ��� ���, ��ü ���뵵 ���
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by rollup(dno, job)
order by count(*) desc;

-- 3. cube Ű���带 ����ϴ� ���: �׷����� ��� ���, ��ü ���뵵 ���, ���� ���ױ��� ���
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by cube(dno, job)
order by count(*) desc;

/*
    SubQuery: select �� ���� select ����[sub guery], ���� ���� �۾��� �� �������� ó��
        - where ������ ���� ����
*/

-- ename[����̸�]�� SCOTT�� ����� ��å�� ���� ������� ���: ������ 2�� �ۼ� �Ǿ�� ��
-- 1. SCOTT ����� ��å�� �˾ƿ��� ����
select job, ename
from employee
where ename = 'SCOTT';
-- 2. �˾ƿ� ��å�� �������� �ؼ� �̸��� ���
select ename, job
from employee
where job = 'ANALYST';

-- SubQuery�� ����ؼ� �ϳ��� ������ ó����
select ename, job
from employee
where job = (select job from employee where ename = 'ALLEN');

select * from employee;

-- SCOTT�� ALLEN�� ��å�� �ش���� �ʴ� ������� ��� ���
-- 1. SCOTT�� ��å�� ����ϴ� ����
-- 2. ALLEN�� ��å�� ����ϴ� ����
-- 3. WHERE job not in('SCOTT�� ��å', 'ALLEN�� ��å')

-- 1. SCOTT�� ��å�� ����ϴ� ����
select job from employee where ename = 'SCOTT';
-- 2. ALLEN�� ��å�� ����ϴ� ����
select job from employee where ename = 'ALLEN';
-- 3. WHERE job not in('SCOTT�� ��å', 'ALLEN�� ��å')
select ename, job
from employee
where job not in('ANALYST', 'SALESMAN');

-- SubQuery�� �� �� �������� ���
select ename ���, job ��å
from employee
where job not in(
    (select job from employee where ename = 'SCOTT'),
    (select job from employee where ename = 'ALLEN')
    );

select ename ���, job ��å
from employee
where job not in(
    select job from employee
    where ename = 'SCOTT' or ename = 'ALLEN'
    );

select * from employee;

-- 'SCOTT' ���� ���� ������ �޴� ������� ����, ������ ���
select ename ����̸�, salary �޿�
from employee
where salary > 
    (select salary from employee where ename = 'SCOTT');
    
-- �ּ� �޿��� �޴� ������� �̸�, ������, �޿� ���
select ename ����̸�, job ������, salary �޿�
from employee
where salary =
    (select min(salary) from employee);
    
-- �μ����� �ּ� �޿��� �޴� ��� ������ �̸�, ��å, ������ ���: ��Ʈ group by, dno, min, in Ű����
select dno �μ���ȣ, ename ����̸�, job ��å, salary ����
from employee
where salary in
    (select min(salary) �ּұ޿� from employee
    group by dno)
order by dno asc;

select * from employee;

-- �� �μ��� �ּ� �޿��� 30�� �μ��� �ּ� �޿����� ū �μ��� ���
select dno, count(*), min(salary)
from employee
group by dno
having min(salary) > (
    select min(salary) from employee
        where dno = 30
        );





