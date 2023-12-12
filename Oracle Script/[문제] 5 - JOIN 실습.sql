/*
    JOIN 실습
        member10: 회원 정보를 저장하는 테이블
        zipcode10: 우편번호를 저장하는 테이블
        product10: 제품 정보를 저장하는 테이블
        order10: 주문 정보를 저장하는 테이블
*/

-- 테이블 삭제: Foreign Key가 참조하는 테이블은 삭제되지 않는다: cascade constraints
    -- 1. 참조하는 테이블을 먼저 삭제 후 삭제해야 한다.
    -- 2. 테이블 삭제 시 cascade constraints 옵션을 사용해서 강제 삭제


-- Member10 테이블에서 참조되는 테이블이므로 삭제가 안된다.
drop table zipcode10;
-- Order10 테이블에서 참조되기 때문에 삭제할 수 없다.
drop table member10;

-- select * from user_constraints where table_name = 'MEMBER10';
drop table order10;
drop table product10;

-- 2. 테이블 삭제 시 cascade constraints 옵션을 사용해서 강제 삭제
    -- zipcode10 테이블을 참조하는 테이블을 강제로 먼저 삭제 후 해당 테이블을 삭제함.
drop table zipcode10 cascade constraints;
drop table member10 cascade constraints;
drop table order10 cascade constraints;
drop table product10 cascade constraints;


create table zipcode10 (
    zipcode number(6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,
    si_do varchar2(200) not null,
    gu_gun varchar2(200) not null,
    bungi varchar2(200) not null
);

create table member10 (
    m_id number(4) not null constraint PK_MEMBER10_M_ID Primary key,
    pass varchar(200) not null,
    name varchar(200) not null,
    email varchar(200) not null,
    zipcode number(6) null,
    -- Foreign Key 제약 조건 추가함: member10(zipcode) -> zipcode10(zipcode)
        constraint FK_MEMBER10_ZIPCODE Foreign key (zipcode) references ZIPCODE10(zipcode)
);

create table product10 (
    pro_id number(6) not null constraint PK_PRODUCT10_PRO_ID primary key,
    pro_name varchar2(200) not null,
    pro_price number(7,2) not null,
    pro_cnt number(4) default 0 not null
);

create table order10 (
    ord_id number(6) not null constraint PK_ORDER10_ORD_ID primary key,
    m_id number(4) not null,        -- FK: MEMBER10(m_id)
    pro_id number(6) not null,      -- FK: PRODUCT10(pro_id)
    -- Foreign Key 2개
        constraint FK_ORDER10_M_ID foreign key (m_id) references MEMBER10 (m_id),
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references PRODUCT10 (pro_id)
);

-- 각 테이블에 레코드 5개씩 넣습니다.

-- ANSI JOIN 문을 사용해서 주문 정보(Order10) 테이블을 기준으로
    -- 주문자명, 주문자 메일 주소, 주문자의 번지(시도), 주문 제품명, 제품의 가격을 출력     order10, member10, zipcode10, producet10

select * from zipcode10;
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (11111, '서울특별시', '용산구', '17번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (22222, '서울특별시', '중랑구', '22번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (33333, '대구광역시', '수성구', '20번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (44444, '대전광역시', '유성구', '55번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (55555, '인천특별시', '남동구', '11번지');
commit;

-- member10 테이블에는 참조되지 않지만 zipcode10 테이블에는 존재함  <- RIGHT OUTER JOIN
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (66666, '강릉', '유성구', '55번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (77777, '울산', '남동구', '11번지');


select * from member10;
insert into member10 (m_id, pass, name, email, zipcode)
values (1234, 'qwer1234', '홍길동', '1234@naver.com', 11111);
insert into member10 (m_id, pass, name, email, zipcode)
values (1212, 'abc1234', '이성민', '1212@naver.com', 22222);
insert into member10 (m_id, pass, name, email, zipcode)
values (4512, 'dongs', '이지아', '4512@naver.com', 33333);
insert into member10 (m_id, pass, name, email, zipcode)
values (3333, 'aabbcc', '권송아', 'rong@naver.com', 44444);
insert into member10 (m_id, pass, name, email, zipcode)
values (2221, 'nuget', '김윤경', 'nunu@naver.com', 55555);
commit;

-- member10 테이블에는 존재하지만 주문 정보에는 없는 회원   <- LEFT OUTER JOIN
insert into member10 (m_id, pass, name, email, zipcode)
values (6666, 'aabbcc', '김송아', 'rong@naver.com', 44444);
insert into member10 (m_id, pass, name, email, zipcode)
values (7777, 'nuget', '권윤경', 'nunu@naver.com', 55555);


select * from product10;
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0042, 'handcream', 8000, 4);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0001, 'apple', 3000, 2);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (0214, 'milk', 2900, 7);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (3012, 'orange', 4000, 12);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (6132, 'bag', 25000, 3);
commit;

-- 주문 정보에는 없는 제품(주문되지 않는 제품), <- RIGHT OUTER JOIN
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (6412, 'mango', 4000, 12);
insert into product10 (pro_id, pro_name, pro_price, pro_cnt)
values (9381, 'shoes', 25000, 3);


select * from order10;
insert into order10 (ord_id, m_id, pro_id)
values (111111, 3333, 0001);
insert into order10 (ord_id, m_id, pro_id)
values (222222, 4512, 6132);
insert into order10 (ord_id, m_id, pro_id)
values (333333, 1234, 0042);
insert into order10 (ord_id, m_id, pro_id)
values (444444, 2221, 0214);
insert into order10 (ord_id, m_id, pro_id)
values (555555, 1212, 3012);
commit;


-- ANSI JOIN 문을 사용해서 주문 정보(Order10) 테이블을 기준으로
    -- 주문자명, 주문자 메일 주소, 주문자의 번지(시도), 주문 제품명, 제품의 가격을 출력     order10, member10, zipcode10, product10
select name 주문자명, email 주문자메일주소, si_do 주문자의번지, pro_name 주문제품명, pro_price 제품의가격
from order10 o JOIN member10 m
    on o.m_id = m.m_id
    JOIN product10 p
    on o.pro_id = p.pro_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode;


-- 모델링 되지 않는 주문 테이블 <- order11
create table order11 (
    o_id number(6) not null primary key,
    
    m_name varchar2(200) not null,          -- 주문자 이름
    m_phone varchar2(200) not null,         -- 주문자 핸드폰 번호
    m_addr varchar2(200) not null,          -- 주문자의 배송 주소
    m_email varchar2(200) null,             -- 주문자의 메일 주소
    
    p_id number(6) not null,                -- 제품 번호
    p_name varchar2(200) not null,          -- 제품 이름
    p_price number(7,2) not null,           -- 제품 가격
    p_cnt number(6) null                    -- 제품 수량
    );
    
insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
values (10, '홍길동', '010-1111-1111', '서울', 'aaa@naver.com', 0001, 'apple', 3000, 200);

insert into order11 (o_id, m_name, m_phone, m_addr, m_email, p_id, p_name, p_price, p_cnt)
values (30, '김길동', '010-2222-1111', '서울', 'bbb@naver.com', 0214, 'milk', 2900, 7);

commit;
    
select * from order11;
    

-- JOIN: ANSI JOIN
    -- INNER JOIN: on 절에 공통의 값만 출력한다.
    -- LEFT OUTER JOIN: 왼쪽 테이블의 모든 내용 출력
    -- RIGHT OUTER JOIN: 오른쪽 테이블의 모든 내용 출력

-- member10(다), zipcode(1) 테이블: 
select *
from member10 m JOIN zipcode10 z
    on m.zipcode = z.zipcode;

-- member10에는 on 절에 매칭되지 않더라도 오른쪽 테이블의 모든 값을 출력: RIGHT OUTER JOIN
select *
from member10 m RIGHT OUTER JOIN zipcode10 z
    on m.zipcode = z.zipcode;

-- 주문 테이블(order10), 주문자 정보(member10)    <- on m_id

select * from order10;

select *
from order10 o JOIN member10 m
    on o.m_id = m.m_id;

-- 주문 정보에 없는 사용자 출력(주문하지 않는 사용자): RIGHT OUTER JOIN
select *
from order10 o RIGHT OUTER JOIN member10 m
    on o.m_id = m.m_id;
    
select *
from order10 o LEFT OUTER JOIN member10 m
    on o.m_id = m.m_id;    

-- 3개 테이블 조인: order10, member10, zipcode10
select *
from order10 o JOIN member10 m
    on o.m_id = m.m_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode;

-- 4개 테이블 조인: order10, member10, zipcode10, product10
select *
from order10 o JOIN member10 m
    on o.m_id = m.m_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode
    JOIN product10 p
    on o.pro_id = p.pro_id;
    
-- FULL OUTER JOIN
select *
from order10 o FULL OUTER JOIN member10 m
    on o.m_id = m.m_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode
    JOIN product10 p
    on o.pro_id = p.pro_id;   
    
-- 주문하지 않는 사용자 정보도 출력, 판매되지 않는 제품도 OUTER JOIN을 사용해서 출력
select *
from order10 o JOIN member10 m
    on o.m_id = m.m_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode
    RIGHT OUTER JOIN product10 p
    on o.pro_id = p.pro_id;       

-- LEFT OUTER JOIN
select *
from member10 m LEFT OUTER JOIN order10 o
    on o.m_id = m.m_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode
    LEFT OUTER JOIN product10 p
    on o.pro_id = p.pro_id;      
