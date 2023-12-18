
select * from help;
select * from redo_log;

-- SQL�� �ּ�: ���� �ּ�
/*
    ������ �ּ�
*/

/*
    �Ϲ� ������ ���� �� �Ϲ� �������� ����: ���� ����, ���� �ο�
*/
-- system �������� ������ ����â������ ������ ������ �� �ִ�.

-- 1. hr ������ ����: Oracle 12 ���� �̻���� ���� ���� �� C##������
        -- ������: hr  ��ȣ: 1234
create user C##HR20 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

-- 2. ������ ������ �ο��ϱ�: connect - ����, resource - ��ü ����, ����, ����
grant resource, connect to C##HR20;

-- System �������� HR �������� create view ������ �ο���.
grant create view to C##HR20;

-- 3. ���̺� �����̽����� ��뷮 �Ҵ�
alter user C##HR20 quota unlimited on USERS;

-- 4. ���� ����
drop user C##HR10 cascade


create user C##HR4 identified by 1234
default tablespace USERS
temporary tablespace TEMP;

grant resource, connect to C##HR4;

alter user C##HR4 quota unlimited on USERS;
