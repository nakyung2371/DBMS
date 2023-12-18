use mydb;

/*
DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;
*/

CREATE TABLE DEPARTMENT
        (DNO int,
         DNAME VARCHAR(14),
	 LOC   VARCHAR(13),
     CONSTRAINT PK_DEPT PRIMARY KEY (dno)
    ); 
      
CREATE TABLE EMPLOYEE 
        (ENO int,
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  int,
	 HIREDATE DATE,
	 SALARY int,
	 COMMISSION int,
	 DNO int REFERENCES DEPARTMENT,
     CONSTRAINT PK_EMP PRIMARY KEY (eno),
     CONSTRAINT FK_EMP foreign key (dno) references DEPARTMENT (dno)
     );
     
CREATE TABLE SALGRADE
        (GRADE int,
	 LOSAL int,
	 HISAL int );

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK', 7902, cast('1980-12-17' as DATE),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698, cast('1981-2-20' as DATE),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,cast('1981-2-22' as DATE),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,cast('1981-4-2' as DATE),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,cast('1981-9-28' as DATE),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,cast('1981-5-1' as DATE),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,cast('1981-6-9' as DATE),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,cast('1987-7-13' as DATE),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,cast('1981-11-17' as DATE),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,cast('1981-9-8' as DATE),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,cast('1987-7-13' as DATE),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,cast('1981-12-3' as DATE),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,cast('1981-12-3' as DATE),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,cast('1982-1-23' as DATE),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

select * from employee;
select * from department;
select * from salgrade;


sp_help 'dbo.employee';
sp_help 'dbo.department';
sp_help 'dbo.salgrade';
