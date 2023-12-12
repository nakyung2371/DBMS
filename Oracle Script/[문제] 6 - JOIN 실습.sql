create table member20 (
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
        constraint FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode20 (zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);
drop table products20;

create table tb_zipcode20 (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

create table products20 (
    product_code varchar2(20) not null constraint PK_products_product_code primary key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);

create table orders20 (
    o_seq number(10) not null constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
        constraint FK_orders_product_code_products foreign key (product_code) references products20 (product_code),
    id varchar2(16),
        constraint FK_orders_id_member foreign key (id) references member20 (id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);

select * from member20;
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values ('aaa', 'aaa', '홍길동', '11111', '서울', '010-1111-1111', '23/12/12');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values ('bbb', 'bbb', '김철수', '22222', '부산', '010-2222-1111', '21/10/2');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values ('ccc', 'ccc', '김영희', '33333', '인천', '010-3333-1111', '23/8/22');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values ('ddd', 'ddd', '권길동', '44444', '대구', '010-4444-1111', '19/4/4');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values ('eee', 'eee', '한영수', '55555', '대전', '010-5555-1111', '18/6/9');
commit;

select * from tb_zipcode20;
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('11111', '서울', '용산구', '효창동', '11번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('22222', '부산', '동래구', '가다동', '22번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('33333', '인천', '부평구', '나다동', '33번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('44444', '대구', '수성구', '이이동', '44번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values ('55555', '대전', '중랑구', '라라동', '55번지');
commit;

select * from products20;
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
    product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('1', '사과', 'a', '2000', '5000', '과일 사과' ,'사과.jpg', '200' ,'200', '50', 'y', '15/12/4');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
    product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('2', '바나나', 'b', '5000', '8000', '과일 바나나' ,'바나나.jpg', '200' ,'200', '50', 'y', '18/11/2');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
    product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('3', '자두', 'c', '2700', '4000', '과일 자두' ,'자두.jpg', '200' ,'200', '50', 'n', '22/3/15');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
    product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('4', '오이', 'd', '3000', '6300', '채소 오이' ,'오이.jpg', '200' ,'200', '50', 'y', '23/12/9');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
    product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('5', '토마토', 'e', '400', '1500', '채소 토마토' ,'토마토.jpg', '200' ,'200', '50', 'y', '21/1/25');
commit;

select * from orders20;
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (10, '1', 'aaa', '100', '500', 'n', '17/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (20, '2', 'bbb', '20', '20', 'y', '19/1/11');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (30, '3', 'ccc', '670', '5200', 'y', '13/6/8');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (40, '4', 'ddd', '40', '54', 'y', '23/12/11');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (50, '5', 'eee', '190', '122', 'y', '22/3/2');
commit;

create view v_join4
as
select *
    from orders20 o
    JOIN member20 m
    on o.id = m.id
    JOIN tb_zipcode20 z
    on m.zipcode = z.zipcode
    JOIN products20 p
    on o.product_code = p.product_code;

select * from v_join4;