-- 한 라인 주석	-- 앞에 공백이 없으면 오류
/*
	여러 라인 주석
*/

-- 1. 사용자 DataBase 생성
create database myDB;

-- 2. 해당 사용자 DataBase에 접속
use myDB;

-- 3. 접속한 DB에서 테이블 생성
create table member (
	idx int not null,
    name varchar(50) not null,
    addr varchar(50) not null
    );

-- 4. 테이블의 내용을 출력: select
select * from member;

-- 5. 생성된 테이블에 값넣기(레코드): 자동 커밋 <- commit; 을 명시하지 않아도 됨
insert into member (idx, name, addr)
values (1, '홍길동', '서울');

insert into member (idx, name, addr)
values (2, '김길동', '부산');
