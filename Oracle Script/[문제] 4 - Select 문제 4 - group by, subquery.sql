-- ��� ����� �Ҽ��� 2�ڸ����� ����ϵ� �ݿø� �ؼ� ��� �Ͻÿ�.  

-- 1.  10 �� �μ��� �����ϰ� �� �μ��� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. �μ���ȣ�� �������� ���� �ϼ���.
select dno �μ���ȣ, sum(salary) �������հ�, round(avg(salary), 2) ���������,
    max(salary) �������ִ밪, min(salary) �������ּҰ�
from employee
where dno != 10
group by dno
order by dno asc;

-- 2.  ��å�� SALSMAN, PRESIDENT, CLERK �� ������ �� �μ��� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�.
select dno �μ���ȣ, sum(salary) �������հ�, round(avg(salary), 2) ���������,
    max(salary) �������ִ밪, min(salary) �������ּҰ�
from employee
where job not in('SALESMAN', 'PRESIDENT', 'CLERK')
group by dno;

-- 3. SMITH �� ������ �μ��� �ٹ��ϴ� ����� �� ������ �հ�� ��հ� �ִ밪, �ּҰ��� ���Ͻÿ�. 
select sum(salary) �������հ�, round(avg(salary), 2) ���������,
    max(salary) �������ִ밪, min(salary) �������ּҰ�
from employee
where dno = (
    select dno from employee
    where ename = 'SMITH')
group by dno;

-- 4. group by - �μ��� �ּҿ����� �������� �ּҿ����� 1000 �̻��� �͸� ����ϼ���. 
select dno �μ��̸�, min(salary) �ּҿ���
from employee
group by dno
having min(salary) >= 1000;

-- 5. group by - �μ��� ������ �հ谡 9000 �̻�͸� ���
select dno, sum(salary) �μ����������հ�
from employee
group by dno
having sum(salary) >= 9000;

-- 6. group by - �μ��� ������ ����� 2000 �̻� ��� �ϵ� �μ���ȣ��  ������������ ���
select dno �μ���ȣ, round(avg(salary), 2) �μ������������
from employee
group by dno
having round(avg(salary), 2) >= 2000
order by dno asc;

-- 7. group by - ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ��� �϶�. 
select dno �μ���ȣ, round(avg(salary), 2) �μ������������
from employee
where salary > 1500
group by dno
having round(avg(salary), 2) >= 2500;

-- 8. sub query - �μ����� �ּ� �޿��� �޴� ������� �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 
select ename ����̸�, salary �޿�, job ��å, dno �μ���ȣ
from employee
where salary in (
    select min(salary) from employee
    group by dno
    );

-- 9. sub query - ��ü ��� �޿����� ���� �޴� �������  �̸��� �޿��� ��å�� �μ���ȣ�� ����ϼ���. 
select ename ����̸�, salary �޿�, job ��å, dno �μ���ȣ
from employee
where salary > (
    select round(avg(salary), 2) from employee
    );

-- 10. sub query - �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���� �������� �����Ͻÿ�.
select eno �����ȣ, ename ����̸�, salary �޿�
from employee
where salary > (
    select round(avg(salary), 2) from employee
    )
order by salary asc;