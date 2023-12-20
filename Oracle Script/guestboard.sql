create table guestboard(
	name varchar2(200),
	email varchar2(200),
	subject varchar2(200),
	content varchar2(200)
	);
    
select * from guestboard;

insert into guestboard (name, email, subject, content)
values ('홍길동', 'aaa@aaa.com', '제목', '내용입니다');

-- developer에서는 반드시: commit 해야함
-- commit 하기 전까지는 Lock

insert into guestboard (name, email, subject, content)
values ('김길동6', 'bbb@aaa.com6', '제목6', '내용입니다6');
commit;
rollback;