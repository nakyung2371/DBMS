create table guestboard(
	name varchar2(200),
	email varchar2(200),
	subject varchar2(200),
	content varchar2(200)
	);
    
select * from guestboard;

insert into guestboard (name, email, subject, content)
values ('ȫ�浿', 'aaa@aaa.com', '����', '�����Դϴ�');

-- developer������ �ݵ��: commit �ؾ���
-- commit �ϱ� �������� Lock

insert into guestboard (name, email, subject, content)
values ('��浿6', 'bbb@aaa.com6', '����6', '�����Դϴ�6');
commit;
rollback;