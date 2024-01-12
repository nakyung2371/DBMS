CREATE TABLE users (
	u_id varchar2(100) NOT NULL constraint PK_USER_U_ID primary key,
	u_password varchar2(100) NOT NULL,
	u_name varchar2(100) NOT NULL,
	u_nickname varchar2(100) NOT NULL,
	phone varchar2(50) NOT NULL,
	gender number(1) NOT NULL
);

select * from review;
drop table review;

CREATE TABLE review (
    r_id number(5) NOT NULL constraint PK_REVIEW_R_ID primary key,
    u_id varchar2(100),
        constraint FK_REVIEW_U_ID foreign key (u_id) references users (u_id),
	r_title varchar2(100) NOT NULL,
	r_content varchar2(1000) NOT NULL,
	img varchar2(1000) NULL,
	r_regdate date default sysdate NULL,
    cnt number(5) default 0
);

CREATE TABLE commentwrite (
    cm_id number(5) NOT NULL constraint PK_COMMENTWRITE_CM_ID primary key,
	u_id varchar2(100),
         constraint FK_COMMENTWRITE_U_ID foreign key (u_id) references users (u_id),
	cm_content varchar2(500) NOT NULL,
	cm_regdate date default sysdate NULL
);

CREATE TABLE admin (
	a_id varchar2(100) NOT NULL constraint PK_ADMIN_A_ID primary key,
	a_password varchar2(100) NOT NULL,
	a_name varchar2(100) NOT NULL,
	aut number(1) NOT NULL
);

CREATE TABLE notice (
	n_id number(5) NOT NULL constraint PK_NOTICE_N_ID primary key,
	a_id varchar2(100),
        constraint FK_ADMIN_A_ID foreign key (a_id) references admin (a_id),
	n_title varchar2(50) NOT NULL,
	n_content varchar2(1000) NOT NULL,
	img varchar2(1000) NULL,
	cnt number(5) NULL,
	n_regdate date default sysdate NULL
);

CREATE TABLE exhibitionInfo (
	e_id number(5) NOT NULL constraint PK_EXHIBITION_E_ID primary key,
	a_id varchar2(100),
        constraint FK_EXHIBITION_E_ID foreign key (a_id) references admin (a_id),
	img varchar2(1000) NULL,
	e_sdate date NOT NULL,
	e_edate date NOT NULL,
	e_place varchar2(500) NOT NULL,
    e_price varchar2(100) NOT NULL,
	e_type varchar2(100)NOT NULL,
	e_title varchar2(100) NOT NULL
);

CREATE TABLE accompany (
	ac_id number(5) NOT NULL constraint PK_ACCOMPANY_AC_ID primary key,
	u_id varchar2(100),
        constraint FK_ACCOMPANY_U_ID foreign key (u_id) references users (u_id),
	ac_content varchar2(1000) NOT NULL,
	img	varchar2(1000) NULL,
	ac_regdate date default sysdate NULL,
	gender number(1) NOT NULL,
	ac_title varchar2(100) NOT NULL
);

CREATE TABLE chat (
	c_id number(5) NOT NULL constraint PK_CHAT_C_ID primary key,
	ac_id number(5),
        constraint FK_CHAT_AC_ID foreign key (ac_id) references accompany (ac_id),
	u_id varchar2(100),
        constraint FK_CHAT_U_ID foreign key (u_id) references users (u_id),
	c_regdate date default sysdate NULL
);

CREATE TABLE message (
	m_id number(5) NOT NULL constraint PK_MESSAGE_M_ID primary key,
	u_id varchar2(100),
        constraint FK_MESSAGE_U_ID foreign key (u_id) references users (u_id),
	c_id number(5),
        constraint FK_MESSAGE_C_ID foreign key (c_id) references chat (c_id),
	ac_id number(5),
        constraint FK_MESSAGE_AC_ID foreign key (ac_id) references accompany (ac_id),
	m_content varchar2(500) NOT NULL,
	m_regdate date default sysdate NULL
);
