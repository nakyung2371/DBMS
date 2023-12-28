create table Member(
    id varchar2(255) not null primary key,
    password varchar2(255) not null,
    phone varchar2 (255) not null,
    email varchar2(255) null,
    regdate date default sysdate,
    addr varchar2(255),
    role varchar2(255) default 'user'
);

create table product (
    id number(5)  not null primary key,  
    name varchar2(255) not null,              
    price number(8,2) not null,                    
    content varchar2(2000),                        
    regdate date default sysdate              
);
    
create table m_board (
    id number(5) not null primary key,
    m_title varchar2 (255) not null ,
    m_write varchar2(255) not null, -- 작성자
    m_cont varchar2 (255) not null, -- 글 내용
    regdate date default sysdate,
    cnt number(5) default 0
);

select * from member;
select * from product;
select * from m_board;

insert into member (id, password, phone, addr, role)
values('admin', '1234', '010-111-1111', '서울', 'Admin');
insert into member (id, password, phone, email, addr, role)
values('user', '1234', '010-1111-2222', 'user@aaa.com', '서울', 'user');

insert into m_board
values ('1', '제목-1', '작성자 - 1', '글 내용 - 1', default, 0);

desc m_board;
commit;

insert into m_board (id, m_title, m_write, m_cont)
values (2, '제목2', '작성자2', '내용2');