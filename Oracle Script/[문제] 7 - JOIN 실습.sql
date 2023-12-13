create table sale40 (
    sale_date date not null constraint PK_SALE40_SALE_DATE primary key,
    wine_code varchar2(6) not null,
        constraint FK_SALE40_WINE_CODE foreign key (wine_code) references wine40 (wine_code),
    mem_id varchar2(30) not null,
        constraint FK_SALE40_MEM_ID foreign key (mem_id) references member40 (mem_id),
    sale_amount varchar2(5) default 0,
    sale_price varchar2(6) default 0,
    sale_tot_price varchar2(15) default 0
);

create table member40 (
    mem_id varchar2(6) not null constraint PK_MEMBER40_MEM_ID primary key,
    mem_grade varchar2(20),
        constraint FK_MEMBER40_MEM_GRADE foreign key (mem_grade) references grade_pt_rade40 (mem_grade),
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default 0
);

create table grade_pt_rade40 (
    mem_grade varchar2(20) not null constraint PK_GRADE_PT_RADE40_MEM_GRADE primary key,
    grade_pt_rate number (3,2)
);

create table today40 (
    today_code varchar2(6) not null constraint PK_TODAY40_TODAY_CODE primary key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
); 

create table nation40 (
    nation_code varchar2(26) not null constraint PK_NATION40_NATION_CODE primary key,
    nation_name varchar2(50) not null
);

create table wine40 (
    wine_code varchar2(26) not null constraint PK_WINE40_WINE_CODE primary key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
        constraint FK_WINE40_NATION_CODE foreign key (nation_code) references nation40 (nation_code),
    wine_type_code varchar2(6),
        constraint FK_WINE40_WINE_TYPE_CODE foreign key (wine_type_code) references wine_type40 (wine_type_code),
    wine_sugar_code number(2),
    wine_price number(15) default 0,
    wine_vintage date,
    theme_code varchar2(6),
        constraint FK_WINE40_THEME_CODE foreign key (theme_code) references theme40 (theme_code),
    today_code varchar2(6),
        constraint FK_WINE40_TODAY_CODE foreign key (today_code) references today40 (today_code)
);

create table theme40 (
    theme_code varchar2(6) not null constraint PK_THEME40_THEME_CODE primary key,
    theme_name varchar2(50) not null
);

create table stock_mamagement40 (
    stock_code varchar2(6) not null constraint PK_STOCK_MANAGEMENT40_STOCK_CODE primary key,
    wine_code varchar2(6),
        constraint FK_STOCK_MANAGEMENT40_WINE_CODE foreign key (wine_code) references wine40 (wine_code),
    manager_id varchar2(30),
        constraint FK_STOCK_MANAGEMENT40_MANAGER_ID foreign key (manager_id) references manager40 (manager_id),
    ware_date date default sysdate,
    stock_amount number(5) default 0
);

create table manager40 (
    manager_id varchar2(30) not null constraint PK_MANAGER40_MANAGER_ID primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
);

create table wine_type40 (
    wine_type_code varchar2(6) not null constraint PK_WINE_TYPE40_WINE_TYPE_CODE primary key,
    wine_type_name varchar2(50)
);

select * from grade_pt_rade40;
insert into grade_pt_rade40
values ('bronze', 2);
insert into grade_pt_rade40
values ('silver', 4);
insert into grade_pt_rade40
values ('gold', 5);
insert into grade_pt_rade40
values ('vip', 7);
insert into grade_pt_rade40
values ('vvip', 8);
commit;

select * from today40;
insert into today40
values ('111111', 30, 60, 70);
insert into today40
values ('222222', 80, 10, 20);
insert into today40
values ('333333', 20, 40, 50);
insert into today40
values ('444444', 10, 90, 20);
insert into today40
values ('555555', 60, 10, 90);
commit;

select * from nation40;
insert into nation40
values ('1234', '대한민국');
insert into nation40
values ('1454', '일본');
insert into nation40
values ('1123', '미국');
insert into nation40
values ('6744', '영국');
insert into nation40
values ('3264', '호주');
commit;

select * from theme40;
insert into theme40
values ('1', '가');
insert into theme40
values ('2', '나');
insert into theme40
values ('3', '다');
insert into theme40
values ('4', '라');
insert into theme40
values ('5', '마');
commit;

select * from manager40;
insert into manager40
values ('aaa', 'aaa', '010-1111-1111');
insert into manager40
values ('bbb', 'bbb', '010-1111-2222');
insert into manager40
values ('ccc', 'ccc', '010-1111-3333');
insert into manager40
values ('ddd', 'ddd', '010-1111-4444');
insert into manager40
values ('eee', 'eee', '010-1111-5555');
commit;

select * from wine_type40;
insert into wine_type40
values ('11', '레드');
insert into wine_type40
values ('22', '화이트');
insert into wine_type40
values ('33', '스파클링');
insert into wine_type40
values ('44', '로제');
insert into wine_type40
values ('55', '내추럴');
commit;

select * from member40;
insert into member40
values ('a1', 'silver', 'a1', '00/12/12', '010-1111-2222', '600');
insert into member40
values ('b1', 'silver', 'b1', '99/1/3', '010-2222-2222', '680');
insert into member40
values ('c1', 'silver', 'c1', '97/8/3', '010-3333-2222', '890');
insert into member40
values ('d1', 'silver', 'd1', '80/7/22', '010-4444-2222', '10');
insert into member40
values ('e1', 'silver', 'e1', '93/11/1', '010-5555-2222', '6');
commit;

select * from wine40;
insert into wine40  (wine_code, wine_name, nation_code, wine_type_code, wine_sugar_code, wine_price,
    wine_vintage, theme_code, today_code)
values ('324', '셀렉티드 빈야드', '1234', '11', 13, 36000,
    '19/5/7', '1', '111111'); 
insert into wine40  (wine_code, wine_name, nation_code, wine_type_code, wine_sugar_code, wine_price,
    wine_vintage, theme_code, today_code)
values ('222', '부숑 스킨', '1454', '22', 64, 77000,
    '06/2/15', '2', '222222');
insert into wine40  (wine_code, wine_name, nation_code, wine_type_code, wine_sugar_code, wine_price,
    wine_vintage, theme_code, today_code)
values ('543', '버니니 클래식', '1123', '33', 43, 23000,
    '12/5/7', '3', '333333');
insert into wine40  (wine_code, wine_name, nation_code, wine_type_code, wine_sugar_code, wine_price,
    wine_vintage, theme_code, today_code)
values ('123', '칸티 브레케토', '6744', '44', 4, 63000,
    '88/4/12', '4', '444444');
insert into wine40  (wine_code, wine_name, nation_code, wine_type_code, wine_sugar_code, wine_price,
    wine_vintage, theme_code, today_code)
values ('577', '쁠랑 쉬드', '3264', '55', 77, 58000,
    '15/11/25', '5', '555555');
commit;  

select * from sale40;
insert into sale40
values ('23/1/1', '324', 'a1', '6', '4000', '6000');
insert into sale40
values ('23/4/8', '222', 'b1', '1', '3000', '7800');
insert into sale40
values ('22/9/11', '543', 'c1', '5', '24300', '30000');
insert into sale40
values ('21/2/26', '123', 'd1', '12', '34440', '40000');
insert into sale40
values ('23/10/21', '577', 'e1', '8', '56000', '62000');
commit;  

select * from stock_mamagement40;
insert into stock_mamagement40
values ('7789', '324', 'aaa', '20/6/7', 50);
insert into stock_mamagement40
values ('3221', '222', 'bbb', '21/12/8', 50);
insert into stock_mamagement40
values ('8853', '543', 'ccc', '22/9/20', 50);
insert into stock_mamagement40
values ('2319', '123', 'ddd', '23/1/1', 50);
insert into stock_mamagement40
values ('4426', '577', 'eee', '23/2/16', 50);
commit; 

select * from sale40;
select * from member40;
select * from grade_pt_rade40;
select * from today40;
select * from nation40;
select * from theme40;  
select * from wine40;
select * from stock_mamagement40;
select * from manager40;
select * from wine_type40;

select *
    from sale40 s
    JOIN member40 m
    on s.mem_id = m.mem_id
    JOIN wine40 w
    on s.wine_code = w.wine_code
    JOIN grade_pt_rade40 g
    on m.mem_grade = g.mem_grade
    JOIN nation40 n
    on w.nation_code = n.nation_code
    JOIN wine_type40 wt
    on w.wine_type_code = wt.wine_type_code
    JOIN theme40 t
    on w.theme_code = t.theme_code
    JOIN today40 td
    on w.today_code = td.today_code
    JOIN stock_mamagement40 sm
    on w.wine_code = sm.wine_code
    JOIN manager40 mg
    on sm.manager_id = mg.manager_id;
    


    
    
    














