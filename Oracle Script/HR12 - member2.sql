select * from board;

-- title �÷����� �˻��ϴ� ����
select * from board
where title like '%�Խ���%';

-- write �÷����� �˻��ϴ� ����
select * from board
where write like '%user%';

-- content �÷����� �˻��ϴ� ����
select * from board
where content like '%MVC%';

-- regdate �÷����� �˻��ϴ� ����
select * from board
where regdate like '%23/12/28%';

select * from board
where cnt > 3;

create table member2 (
    id varchar2(200) not null primary key,
    name varchar2(100) not null,
    pass1 varchar2(200) not null,
    sex varchar2(200) not null,
    hobby1 varchar2(200) null,
    hobby2 varchar2(200) null,
    hobby3 varchar2(200) null,
    hobby4 varchar2(200) null,
    nation varchar2(200) not null,
    zone varchar2(200) not null,
    phone1 varchar2(5) not null,
    phone2 varchar2(5) not null,
    profile varchar2(200)
);

drop table member2;

select * from member2;
desc board;

insert into member2 (id, name, pass1, sex, hobby1, hobby2, hobby3, hobby4, nation, zone, phone1, phone2, profile)
values ('aaa', 'aaa', '1234', '��', null, null, null, null, '082', '010', '1111', '1111',  '�ȳ��ϼ���');
commit;