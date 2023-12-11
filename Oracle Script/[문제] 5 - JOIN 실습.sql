/*
    JOIN �ǽ�
        member10: ȸ�� ������ �����ϴ� ���̺�
        zipcode10: �����ȣ�� �����ϴ� ���̺�
        product10: ��ǰ ������ �����ϴ� ���̺�
        order10: �ֹ� ������ �����ϴ� ���̺�
*/

create table zipcode10 (
    zipcode number(6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key,
    si_do varchar2(200) not null,
    gu_gun varchar2(200) not null,
    bungi varchar2(200) not null
)

create table member10 (
    m_id number(4) not null constraint PK_MEMBER10_M_ID Primary key,
    pass varchar(200) not null,
    name varchar(200) not null,
    email varchar(200) not null,
    zipcode number(6) null,
    -- Foreign Key ���� ���� �߰���: member10(zipcode) -> zipcode10(zipcode)
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
    -- Foreign Key 2��
        constraint FK_ORDER10_M_ID foreign key (m_id) references MEMBER10 (m_id),
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references PRODUCT10 (pro_id)
);

-- �� ���̺� ���ڵ� 5���� �ֽ��ϴ�.

-- ANSI JOIN ���� ����ؼ� �ֹ� ����(Order10) ���̺��� ��������
    -- �ֹ��ڸ�, �ֹ��� ���� �ּ�, �ֹ����� ����(�õ�), �ֹ� ��ǰ��, ��ǰ�� ������ ���     order10, member10, zipcode10, producet10

select * from zipcode10;
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (11111, '����Ư����', '��걸', '17����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (22222, '����Ư����', '�߶���', '22����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (33333, '�뱸������', '������', '20����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (44444, '����������', '������', '55����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values (55555, '��õƯ����', '������', '11����');
commit;

select * from member10;
insert into member10 (m_id, pass, name, email, zipcode)
values (1234, 'qwer1234', 'ȫ�浿', '1234@naver.com', 11111);
insert into member10 (m_id, pass, name, email, zipcode)
values (1212, 'abc1234', '�̼���', '1212@naver.com', 22222);
insert into member10 (m_id, pass, name, email, zipcode)
values (4512, 'dongs', '������', '4512@naver.com', 33333);
insert into member10 (m_id, pass, name, email, zipcode)
values (3333, 'aabbcc', '�Ǽ۾�', 'rong@naver.com', 44444);
insert into member10 (m_id, pass, name, email, zipcode)
values (2221, 'nuget', '������', 'nunu@naver.com', 55555);
commit;

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


-- ANSI JOIN ���� ����ؼ� �ֹ� ����(Order10) ���̺��� ��������
    -- �ֹ��ڸ�, �ֹ��� ���� �ּ�, �ֹ����� ����(�õ�), �ֹ� ��ǰ��, ��ǰ�� ������ ���     order10, member10, zipcode10, product10
select name �ֹ��ڸ�, email �ֹ��ڸ����ּ�, si_do �ֹ����ǹ���, pro_name �ֹ���ǰ��, pro_price ��ǰ�ǰ���
from order10 o JOIN member10 m
    on o.m_id = m.m_id
    JOIN product10 p
    on o.pro_id = p.pro_id
    JOIN zipcode10 z
    on m.zipcode = z.zipcode;

