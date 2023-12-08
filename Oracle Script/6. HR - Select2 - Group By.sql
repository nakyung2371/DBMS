/*
    그룹 함수: group by, having
    
    select 컬럼명
    from 테이블명[뷰]
    where 조건
    group by 컬럼명[동일한 값을 그룹핑]
    having 조건[group by 한 결과 값의 조건]
    order by 컬럼명 asc[desc]
*/

/*
    집계 함수: number 타입의 컬럼에 적용    <- NULL이 자동으로 처리됨
    SUM - 컬럼의 모든 값의 합
    AVG - 컬럼의 모든 값의 평균
    MAX - 컬럼의 최대값
    MIN - 컬럼의 최소값
    COUNT(*) - 그룹핑된 레코드 수 출력
    
    주의: 단일 행으로 출력이 되기 때문에 다른 컬럼과 사용 시 오류
        단, group by 절에 grouping 된 컬럼은 출력 가능
*/
desc employee;
--select SUM(salary), ename      <- 다른 컬럼과 같이 출력하면 오류

-- 컬럼에 함수 사용: 주의
-- 월급(salary)
select SUM(salary) 합계, round(AVG(salary), 2) 평균, MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 계산된레코드수
from employee;

-- 보너스(commission)      <- 집계 함수는 NULL을 자동으로 처리
select SUM(commission) 합계, round(AVG(commission), 2) 평균, MAX(commission) 최대값, MIN(commission) 최소값, COUNT(*) 계산된레코드수
from employee;

-- 부서별로 월급의 합계, 평균, 최대월급, 최소월급, 그룹핑된 수를 출력

select dno, SUM(salary) 합계, ROUND(AVG(salary), 2) 평균, MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 계산된레코드수    -- 그룹핑된 컬럼은 출력 가능
from employee
group by dno;        -- dno 컬럼의 동일한 값을 그룹핑해서 집계 함수를 적용

select salary, dno
from employee
order by dno asc;

-- 직책별로 월급의 합계, 평균, 최대값, 최소값, 그룹핑된 수를 출력해보세요
select job 직책, SUM(salary) 합계, ROUND(AVG(salary), 2) 평균, MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 계산된레코드수
from employee
group by job
order by job asc;

/*
    group by 절에서 where[조건] vs having[조건]
        where[조건]: group by 하기 전에 조건을 가져옴       , 별칭 이름을 사용할 수 없다
        having[조건]: group by 해서 나온 결과에 대한 조건   , 별칭 이름을 사용할 수 없다
        
        order by 컬럼명 asc[desc]: 별칭 이름을 사용 가능
*/

-- 직급별로 월급의 합계, 평균, 최대값, 최소값, 그룹핑된 수를 출력하되, 부서 번호 20은 제외하고, 부서별로 평균이 2000 이상인 내용만 출력
select job 직책, SUM(salary) 합계, ROUND(AVG(salary), 2) 평균, MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 계산된레코드수
from employee
where eno != 20
group by job
having ROUND(AVG(salary), 2) >= 2000
order by ROUND(AVG(salary), 2) asc;

-- group by 절에서 컬럼이 2배 이상, 두 컬럼에 걸쳐서 동일한 내용을 그룹핑함
    -- job, dno
select job, dno from employee
order by job asc;

select dno, job,sum(salary) 합한값, count(*)
from employee
group by job, dno;

-- 각 직책(job)에 대해서 월급의 합계, 평균, 최대값, 최소값, 카운트 수를 출력하되, 입사일이 81년도 입사한 사원들만 적용
-- 월급의 평균이 1500만원 이상인 것만 출력하되, 평균을 내림차순 정렬
select job 직책, SUM(salary) 합계, ROUND(AVG(salary), 2) 평균, MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 카운트수
from employee
where hiredate >= '81/01/01'
-- where hiredate like '81%'
group by job
having ROUND(AVG(salary), 2) >= 1500
order by 평균 desc;

/*
    group by 절에서 사용되는 키워드
    rollup: group by 컬럼 <- 결과 마지막 라인에 전체 결과도 한 번 더 출력
    cube: 그룹핑 마지막 라인에 결과 출력, 마지막 라인에 전체 결과도 세부적으로 출력
*/

-- 1. rollup, cube 키워드를 사용하지 않는 경우: 그룹핑한 결과만 출력
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by dno, job
order by count(*) desc;

select dno, job
from employee
order by dno asc;

-- 2. rollup 키워드를 사용하는 경우: 그룹핑한 결과 출력, 전체 내용도 출력
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by rollup(dno, job)
order by count(*) desc;

-- 3. cube 키워드를 사용하는 경우: 그룹핑한 결과 출력, 전체 내용도 출력, 세부 사항까지 출력
select dno, job, count(*), SUM(salary), ROUND(AVG(salary), 2), MAX(salary), MIN(salary)
from employee
group by cube(dno, job)
order by count(*) desc;

/*
    SubQuery: select 문 내의 select 쿼리[sub guery], 여러 번의 작업을 한 구문에서 처리
        - where 절에서 많이 사용됨
*/

-- ename[사원이름]이 SCOTT인 사원의 직책과 같은 사원들을 출력: 쿼리가 2번 작성 되어야 함
-- 1. SCOTT 사원의 직책을 알아오는 쿼리
select job, ename
from employee
where ename = 'SCOTT';
-- 2. 알아온 직책을 조건으로 해서 이름을 출력
select ename, job
from employee
where job = 'ANALYST';

-- SubQuery를 사용해서 하나의 쿼리로 처리함
select ename, job
from employee
where job = (select job from employee where ename = 'ALLEN');

select * from employee;

-- SCOTT과 ALLEN의 직책에 해당되지 않는 사원들을 모두 출력
-- 1. SCOTT의 직책을 출력하는 쿼리
-- 2. ALLEN의 직책을 출력하는 쿼리
-- 3. WHERE job not in('SCOTT의 직책', 'ALLEN의 직책')

-- 1. SCOTT의 직책을 출력하는 쿼리
select job from employee where ename = 'SCOTT';
-- 2. ALLEN의 직책을 출력하는 쿼리
select job from employee where ename = 'ALLEN';
-- 3. WHERE job not in('SCOTT의 직책', 'ALLEN의 직책')
select ename, job
from employee
where job not in('ANALYST', 'SALESMAN');

-- SubQuery로 한 한 라인으로 출력
select ename 사원, job 직책
from employee
where job not in(
    (select job from employee where ename = 'SCOTT'),
    (select job from employee where ename = 'ALLEN')
    );

select ename 사원, job 직책
from employee
where job not in(
    select job from employee
    where ename = 'SCOTT' or ename = 'ALLEN'
    );

select * from employee;

-- 'SCOTT' 보다 많은 월급을 받는 사원들의 정보, 월급을 출력
select ename 사원이름, salary 급여
from employee
where salary > 
    (select salary from employee where ename = 'SCOTT');
    
-- 최소 급여를 받는 사원들의 이름, 담당업무, 급여 출력
select ename 사원이름, job 담당업무, salary 급여
from employee
where salary =
    (select min(salary) from employee);
    
-- 부서별로 최소 급여를 받는 사원 정보의 이름, 직책, 월급을 출력: 힌트 group by, dno, min, in 키워드
select dno 부서번호, ename 사원이름, job 직책, salary 월급
from employee
where salary in
    (select min(salary) 최소급여 from employee
    group by dno)
order by dno asc;

select * from employee;

-- 각 부서의 최소 급여가 30번 부서의 최소 급여보다 큰 부서를 출력
select dno, count(*), min(salary)
from employee
group by dno
having min(salary) > (
    select min(salary) from employee
        where dno = 30
        );





