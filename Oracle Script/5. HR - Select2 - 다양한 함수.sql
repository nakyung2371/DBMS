
/*
    Oracle의 다양한 함수 사용하기
    1. 문자를 처리하는 함수
    2. 숫자를 처리하는 함수
    3. 날짜를 처리하는 함수
    4. 변환 함수
    5. 일반 함수
*/
/*
    1. 문자를 처리하는 함수:
     - UPPER: 소문자를 대문자로 변환해주는 함수
     - LOWER: 소문자로 처리해주는 함수
     - INITCAP: 첫글자만 대문자로 처리해주는 함수
     - LENGTH: 글자수 반환(영문: 1byte, 한글: 1byte)
     - LENGTHB: 글자수 반환(영문: 1byte, 한글: 3byte)
     - CONCAT: 문자열을 연결해주는 함수
     - SUBSTR: 글자를 잘라오는 함수
     - INSTR: 특정 문자의 위치값을 출력
     - LPAD: 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움(왼쪽)
     - RPAD: 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움(오른쪽)
     - RTRIM: 오른쪽 공백 제거
     - LTRIM: 왼쪽 공백 제거

    dual: 가상의 테이블
*/

select UPPER ('Oracle') from dual;

select * from employee;

select ename 원본이름, UPPER(ename) 대문자이름, LOWER(ename) 소문자이름, INITCAP(ename) 첫자만대문자
from employee;

-- 검색이 안됨: 컬럼의 값은 대소문자를 구분
select * from employee
where ename = 'smith';

select * from employee
where ename = UPPER('smith');

select LENGTH('Oracle mania') from dual;    -- 12
select LENGTH('오라클 매니아') from dual;     -- 7

select LENGTHB('Oracle mania') from dual;    -- 12
select LENGTHB('오라클 매니아') from dual;     -- 19  한글 1자: 3byte

select ename 원본, LENGTH(ename) 글자수
from employee;
select ename 원본, LENGTHB(ename) 글자수       -- 영문은 차이가 없다
from employee;

-- CONCAT: 문자열과 문자열을 연결해주는 함수
-- || 컬럼을 연결해주는 연산자
select 'Oracle', 'Mania' from dual;
select CONCAT('Oracle', ' Mania') as 연결됨 from dual;

select concat(ename, job) from employee;
select ename || job from employee;

select ename || '     ' || job 이름과직책 from employee;

-- SUBSTR: 문자를 잘라오는 함수, substr(컬럼, 4,3) <- 컬럼에 있는 문자열 중 4번째 자리에서 3자를 잘라와서 출력

select substr('Oracle Mania', 4,3) from dual;   -- index: 1번부터 시작

select ename 원본이름, substr(ename, 2,3) from employee;

select * from employee;

-- employee 테이블에서 이름, 입사월만 출력하세요. substr 함수를 사용
select ename 이름, substr(hiredate, 4,2) 입사월 from employee;

-- employee 테이블에서 이름, 입사월만 출력하세요. substr 함수를 사용 -- 2월달에 입사한 사원 출력
select ename 이름, substr(hiredate, 4,2) 입사월 from employee
where substr(hiredate, 4,2) = '02';

-- 81년도에 입사한 사원의 이름, 입사년, 입사월, 입사일
select ename 이름, substr(hiredate, 1,2) 입사년, substr(hiredate, 4,2)입사월, substr(hiredate, 7,2) 입사일
from employee
where substr(hiredate, 1,2) = '81';

-- INSTR: 특정 문자의 index 번호를 출력   index 번호는 1부터
    -- instr(컬럼명, 'A'): 컬럼에서 문자열 중에 'A'가 있는 index 번호를 출력
    -- instr(컬럼명, 'A', 4): index 4번부터 오른쪽을 A가 들어가 있는 index 번호를 출력
    -- 검색되지 않으면 0으로 출력
    
select instr('Oracle Mania', 'a') from dual;        -- 3 <- a가 위치한 index 번호

select instr('Oracle Mania', 'a', 4) from dual;     -- 9 <- index 4번 이후부터 검색 'a'가 위치한 index 검색

select ename 이름, instr(ename, 'M') M의위치
from employee;

-- 중요한 데이터는 일부를 감추고 출력
-- LPAD: LPAD(컬럼명, 늘릴 자릿수, '*'): 공백 자리에 *를 채움(왼쪽)
-- RPAD: RPAD(컬럼명, 늘릴 자릿수, '*'): 공백 자리에 *를 채움(오른쪽)

select '770824-123456' 주민번호, LPAD('770824-1', 20, '*') as "LPAD" from dual;

select '770824-123456' 주민번호, RPAD('770824-1', 20, '*') as "RPAD" from dual;

select * from employee;

-- hiredate 컬럼을 년도만 출력하고 나머지는 *로 출력     <- substr, rpad를 사용해서 처리
select ename 이름, RPAD(substr(hiredate, 1,2), 8, '*') 입사년월일
from employee;

-- 공백 처리: RTRIM: 오른쪽의 공백을 제거, LTRIM: 왼쪽의 공백을 제거, TRIM: 왼쪽, 오른쪽 공백을 모두 제거

select '                 Oracle Mania                 '  원본,
    LTRIM('                 Oracle Mania                 ') 왼쪽공백제거,
    RTRIM('                 Oracle Mania                 ') 오른쪽공백제거,
    TRIM('                 Oracle Mania                 ') 모든공백제거
from dual;

select * from employee
where ename = LTRIM('      SMITH');

-- 앞뒤 공백 제거 후 값을 대문자로 변환
select * from employee
where ename = UPPER(TRIM('      smith      '));

-- 2. 숫자를 처리하는 함수: ROUND: 반올림하는 함수, TRUNC: 특정 자리수에서 잘라내는 함수, MOD: 나머지값만 출력

-- ROUND: 특정 자릿수에서 반올림, 5 이상 반올림, 5 미만 잘라냄

/*
    ROUND(실수): 소수점 뒷자리에서 반올림
    ROUND(실수, 소수점 자릿수):
     - 소수점 자리(양수): 소수점 기준으로 오른쪽으로 이동해서 그 뒷자리에서 반올림  <- *주의*
     - 소수점 자리(음수): 소수점 기준으로 왼쪽으로 이동해서 그 자리에서 반올림
*/

select 98.7654 원본,
    round(98.7654) R1,      -- 소수점 뒤에서 반올림
    round(98.7654, 2) R2,   -- 소수점 오른쪽으로 2자리 이동 후 그 뒤에서 반올림   <- *주의*
    round(98.7654, -1) R3,  -- 소수점 왼쪽으로 1자리 이동 후 그 자리에서 반올림
    round(98.7654, -2) R4,
    round(98.7654, -3) R5
from dual;

-- 근로 소득세: 월급의 3.3,        salary * 0.033 소득세
select salary 월급, salary * 0.033 소득세, round(salary * 0.033) R1, Round((salary * 0.033), 2) R2,
    round(salary - (salary * 0.033)) 실수령액
from employee;

-- TRUNC: 특정 자리에서 잘라냄   <- 특정 날짜를 연산(ex. 오늘 날짜에서 100일 이후의 날짜가 언제냐)
select trunc(98.7654) T1, 
       trunc(98.7654, 2) T2,
       trunc(98.7654, -1) T3,
       trunc(98.7654, -2) T4
from dual;

-- MOD: 나머지 값만 출력   MOD(인자1, 인자2)
-- TRUNC: 몫만 출력
select MOD(3, 2),       -- 나머지
       TRUNC(31/2)      -- 몫
from dual;

/*
    날짜 함수:
     - sysdate: 현재 시스템의 날짜를 출력하는 함수
     - months_between: 두 날짜 사이의 개월수를 출력
     - add_months: 특정 날짜에서 개월수를 더해서 출력
     - next_day: 특정 날짜에서 다음에 초래하는 요일을 인자로 받아서 도래하는 날짜를 출력
     - last_day: 달의 마지막 날짜를 출력
     - round(날짜): 날짜를 반올림 - 15일 이상: 반올림, 15일 미만: 삭제
     - trunc(날짜): 날짜를 잘라내는 함수
*/

select sysdate from dual;   -- 23/12/07

-- 날짜에 연산이 가능
select sysdate 현재날짜, sysdate - 1 어제날짜, sysdate + 1 내일날짜 from dual;

-- 오늘을 기준으로 100일 전 날짜는?
select sysdate - 100 as "100일전날짜" from dual;

-- 오늘을 기준으로 1000일 후 날짜는?
select sysdate + 1000 as "1000일후날짜" from dual;

-- 입사일에서 오늘날까지 총 근무일수를 구함 date 컬럼    (sysdate - hiredate)
desc employee;

-- 총 근무일수 = 오늘 날짜 - 입사 날짜
select ename 이름, trunc(sysdate - hiredate) 총근무일수 from employee;

-- 입사일에서 1000일 시점의 날짜의 이름, 1000일 시점의 날짜를 출력
select ename 이름, hiredate 입사날짜, hiredate + 1000 "입사후1000일날짜" from employee;

-- 특정 날짜에서 월만 출력: TRUNC(날짜, 'MONTH'), ROUND(날짜, 'MONTH')
select hiredate 원본날짜, trunc(hiredate, 'MONTH'), round(hiredate, 'MONTH') from employee;

-- 현재까지의 근무 개월수를 출력: months_between(날짜, 날짜) - 두 날짜 사이의 개월수를 출력
select ename 이름, hiredate 원본입사날짜, trunc(months_between(sysdate, hiredate)) 개월수 from employee;

-- 오늘 날짜에서 100개월 이후의 날짜, 100일 후의 날짜
-- date 타입일 때 가능
select sysdate 오늘날짜, add_months(sysdate, 100) "100개월이후", sysdate + 100 "100일후의날짜" from dual;

-- last_day: 그 날짜의 마지막 날짜를 출력
select last_day(sysdate) from dual;

-- 모든 사원의 입사한 날의 마지막 날짜를 출력
select ename 사원, hiredate 입사날짜, last_day(hiredate) 입사한날의마지막날짜 from employee;

/*
    형식 변환 함수
    TO_CHAR: 날짜, 숫자 -> 문자형으로 변환
    TO_DATE: 문자 -> 날짜형식으로 변환
    TO_NUMBER: 문자 -> 숫자형식으로 변환
*/

-- TO_CHAR: 날짜 -> 문자

select sysdate from dual;   -- 23/12/07

-- YYYY: 년도, MM: 월, MON: 월, DD: 일, HH: 시간, MI: 분, SS: 초, DAY: 요일(월요일), DY(월, 화)
select TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS') from dual;    -- 2023-12-07 04:12:04

select hiredate 입사날짜, TO_CHAR(hiredate, 'YYYY-MM-DD HH:MI:SS') 입사날짜2
from employee;

select TO_CHAR(sysdate, 'YYYY-MM-DD MON DAY DY HH:MI:SS') from dual;

-- TO_CHAR: 숫자 -> 문자
/*
    0: 자릿수를 처리함, 자릿수가 많으면 0으로 처리됨
    9: 자릿수를 처리함, 자릿수가 많으면 공백으로 처리됨
    L: 각 지역의 통화를 기호로 표시함
    
    .: 소숫점으로 처리됨
    ,: 천단위 구분자
*/

select TO_CHAR (9876, '000,000') from dual;
select TO_CHAR (9876, 'L999,999') from dual;    

-- 월급을 그 나라의 통화 기록을 붙여서 천단위로 출력
select salary 월급, TO_CHAR(salary, 'L999,999') as "월급(원)"
from employee;

-- TO_DATE: 문자, 숫자 -> 날짜 형식으로 바꿈
    -- 날짜 + 100일
    -- months_between(날짜, 날짜)

select to_date('1998-10-10', 'YYYY-MM-DD') from dual;
select months_between(to_date('12.12', 'MM.DD'), '00/12/12') from dual;

-- 1981월 01월 01일에서 100일 지난 시점의 날짜를 출력, 100개월 지난 시점의 날짜를 출력, add_months(날짜, 개월수)
select to_date('1981-01-01', 'YYYY-MM-DD') 원본날짜,
    ((to_date('1981-01-01', 'YYYY-MM-DD')) + 100) "100일후날짜",
    add_months(to_date('1981-01-01', 'YYYY-MM-DD'), 100) "100개월날짜"
from dual; 

select to_date(770814, 'YYMMDD') from dual;

-- 자신의 생일에서 현재까지 몇개월 살았는지, 며칠 살았는지 출력 <- months_between(현재날짜, 생일): 개월수
select trunc(sysdate - to_date('00/12/12', 'YY/MM/DD')) 일수,
    trunc(months_between(sysdate, to_date('00/12/12', 'YY/MM/DD'))) 개월수
from dual;

-- employee 테이블에서 2050년 12월 24일까지의 날짜(일수)를 출력
select hiredate 원본날짜, to_date('2050-12-24', 'YYYY-MM-DD') - hiredate "2050년 12월 24일까지의 날짜(일)"
from employee;







