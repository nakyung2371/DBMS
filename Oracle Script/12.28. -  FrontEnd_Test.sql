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
    m_write varchar2(255) not null, -- �ۼ���
    m_cont varchar2 (255) not null, -- �� ����
    regdate date default sysdate,
    cnt number(5) default 0
);

select * from member;
select * from product;
select * from m_board;

insert into member (id, password, phone, addr, role)
values('admin', '1234', '010-111-1111', '����', 'Admin');
insert into member (id, password, phone, email, addr, role)
values('user', '1234', '010-1111-2222', 'user@aaa.com', '����', 'user');

insert into m_board
values ('1', '����-1', '�ۼ��� - 1', '�� ���� - 1', default, 0);

desc m_board;
commit;

insert into m_board (id, m_title, m_write, m_cont)
values (2, '����2', '�ۼ���2', '����2');