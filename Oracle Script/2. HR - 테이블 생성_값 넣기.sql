
/*
    CRUD: Create, Read, Update, Delete
          생성     검색   수정    삭제
*/

-- 간단한 테이블 생성
Create Table member (
    idx number not null,
    name varchar2(50) not null,
    id varchar2(50) not null,
    pw varchar2(50) not null,
    addr varchar2(50) null
    );
    
-- 검색: select
select * from member;

-- 입력: 테이블에 값을 넣음
insert into member (idx, name, id, pw, addr)
values (1, '홍길동', 'knk', '1234', '서울');
commit;     -- DB에 영구히 저장

insert into member (idx, name, id, pw, addr)
values (2, '김길동', 'knk1', '1234', '부산');
commit; 

-- C##HR3 계정을 생성하고, HR3 계정으로 접속, member 테이블 생성 후 레코드 2개 넣기

    
    