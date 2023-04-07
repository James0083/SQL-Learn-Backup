select * from tab;
-- �ܹ� �ּ�
/* ���� �ּ�
c:/myjava/SQL/day01.sql
*/
-- �λ���� �ý���
select * from dept;
select dname from dept;
select dname,loc,deptno from dept;

select * from emp;
select ename,job,sal from emp;

select * from salgrade;
-- ���θ� �ý���
select * from member; -- ȸ��
select * from category; -- ī�װ�
select * from products; -- ��ǰ
select * from supply_comp; --���޾�ü

drop table products;
drop table category;

/* ī�װ� �������̺� */
CREATE TABLE CATEGORY(
  CNUM NUMBER(5) DEFAULT '1' NOT NULL,
  CATEGORY_CODE VARCHAR2(8) NOT NULL,
  CATEGORY_NAME VARCHAR2(30) NOT NULL,
  DELETE_CHK CHAR(1) DEFAULT 'N' NOT NULL,
  PRIMARY KEY(CNUM)
);

/* ī�װ� SEQUENCE */
CREATE SEQUENCE CATEGORY_SEQ
  START WITH 13
  INCREMENT BY 1 ;

/* ī�װ� ���� */
INSERT INTO CATEGORY VALUES('1','00010000','������ǰ','N');
INSERT INTO CATEGORY VALUES('2','00010001','TV','N');
INSERT INTO CATEGORY VALUES('3','00010002','��ǻ��','N');
INSERT INTO CATEGORY VALUES('4','00010003','MP3','N');
INSERT INTO CATEGORY VALUES('5','00010004','������','N');
INSERT INTO CATEGORY VALUES('6','00020000','�Ƿ�','N');
INSERT INTO CATEGORY VALUES('7','00020001','����','N');
INSERT INTO CATEGORY VALUES('8','00020002','�ӿ�','N');
INSERT INTO CATEGORY VALUES('9','00020003','����','N');
INSERT INTO CATEGORY VALUES('10','00030000','����','N');
INSERT INTO CATEGORY VALUES('11','00030001','��ǻ�͵���','N');
INSERT INTO CATEGORY VALUES('12','00030002','�Ҽ�','N');
commit;

select * from category;

/* ��ǰ �� ���� ���̺� */
CREATE TABLE PRODUCTS(
 PNUM NUMBER(11) DEFAULT '1' NOT NULL,
 CATEGORY_FK VARCHAR(8) NOT NULL,
 PRODUCTS_NAME VARCHAR(50) NOT NULL,
 EP_CODE_FK VARCHAR(5) NOT NULL,
 INPUT_PRICE NUMBER(10) DEFAULT '0' NOT NULL,
 OUTPUT_PRICE NUMBER(10) DEFAULT '0' NOT NULL,
 TRANS_COST NUMBER(5) DEFAULT '0' NOT NULL,
 MILEAGE NUMBER(6) DEFAULT '0' NOT NULL,
 COMPANY VARCHAR(30),
 STATUS CHAR(1) DEFAULT '1' NOT NULL,
 PRIMARY KEY(PNUM)
);

/* ��ǰ ���� ���� */
INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
   VALUES
    ('1','00010001','S ������ TV','00001','5000000','8000000','0','100000','�Ｚ','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,COMPANY,STATUS)
  VALUES
    ('2','00010001','D TV','00002','300000','400000','���','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('3','00010004','S ������','00001','1000000','1100000','5000','10000','�Ｚ','2');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('4','00010000','C ���','00003','200000','200000','5500','0','����','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('5','00010004','L ������','00003','1200000','1300000','0','0','LG','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
    ('6','00020001','��������','00002','100000','150000','2500','0','','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('7','00020001','��������','00002','120000','200000','0','0','3');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('8','00020002','�簢��Ƽ','00002','10000','20000','0','0','���𰡵�','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('9','00020003','�ủ����','00002','5000','8000','0','0','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('10','00030001','������ø���','00001','25000','30000','2000','0','���','1');
commit;

select * from products;

-- �л� ���̺� ����
create table student(
  num number(4) primary key, -- unique + not null
  name varchar2(30) not null,
  addr varchar2(100) not null,
  tel varchar2(15) not null,
  indate date default sysdate, --�ý����� ���� ��¥�� ����Ʈ������ ����
  cname varchar2(50),
  croom number(3)
);
select * from student;
-- �л����� ���
--INSERT INTO ���̺��(�÷���1,�÷���2,...)
--VALUES(��1,��2,...);
INSERT INTO STUDENT(num,name,addr,tel,cname,croom)
values(1,'ȫ�浿','���� ������','010-1111-1111','�鿣�� �����ڹ�',201);
commit; --db�� ������ ����

select * from student;

insert into student(num,addr,name,tel,cname,croom)
values(2,'��õ������ ������','��浿','010-2222-2222','�鿣�� �����ڹ�',201);

rollback; --���

insert into student(num,name,addr,tel)
values(3,'�ֿ���','���� �ϻ굿��','010-3333-3333');

select * from student;

commit;

insert into student
values(4,'�̱���','����',
'010-9999-9999','23/03/21','�����͹�',202);
select * from student;
commit; -- transaction control language TCL

-- �����͹ݿ� 2�� �� ���
insert into student
values(5,'�̱浿','���� ������',
'010-3999-9999','23/03/20','�����͹�',202);
insert into student
values(6,'�ֿ���','������ ����',
'010-9123-9999','23/03/21','�����͹�',202);

-- AI���񽺰����ڹ� 3�� ����ϱ� 203ȣ
insert into student
values(7,'�赿��','���� ������',
'010-5699-1999','23/03/22','AI���� �����ڹ�',203);

insert into student
values(8,'������','���� ������',
'010-7699-1998','23/03/23','AI���� �����ڹ�',203);

insert into student
values(9,'������','���� ������',
'010-5699-1111','23/03/21','AI���� �����ڹ�',203);
commit;

-- ������ ����
--update ���̺�� set �÷���1=��1, �÷���2=��2,...
--where ������
update  student set cname='�鿣�� �����ڹ�', croom=201
where num=3;

select * from student;

-- ȫ�浿�� �л��� ����ó�� 010-1234-5678�� �����ϼ���
update student set tel='010-1234-5678'
where num=1;
--where name='ȫ�浿' and croom=201;
rollback;
commit;

-- ������ ����
--DELETE FROM ���̺�� WHERE ������;
SELECT * FROM STUDENT;

-- DELETE FROM STUDENT;
DELETE FROM STUDENT WHERE NUM=2;
DELETE FROM STUDENT WHERE NAME='������';
ROLLBACK;

INSERT INTO STUDENT
VALUES(10,'���缮','���� ���ϱ�','010-7878-8989',SYSDATE,'�鿣���','301');
COMMIT;

SELECT * FROM STUDENT;

SELECT * FROM STUDENT
WHERE CROOM=201;
-- WHERE CNAME='�鿣�� �����ڹ�';

-- ���̺� ���� : DDL
--DROP TABLE ���̺��;

DROP TABLE STUDENT;

-- �б����̺� (�θ����̺�-MASTER TABLE)

CREATE TABLE SCLASS(
    SNUM NUMBER(4) PRIMARY KEY, -- �б޹�ȣ
    SNAME VARCHAR2(50) NOT NULL, -- �б޸�
    SROOM NUMBER(3)
);
DESC SCLASS;

CREATE TABLE STUDENT(
    NUM NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    ADDR VARCHAR2(100) NOT NULL,
    TEL VARCHAR2(15) NOT NULL,
    INDATE DATE DEFAULT SYSDATE,
    SNUM_FK NUMBER(4) REFERENCES SCLASS(SNUM)
);
DESC STUDENT;

-- �б� �����͸� �����ϼ���
--10 �鿣�尳���ڹ� 201
--20 �����͹� 202
--30 AI���� �����ڹ� 203

INSERT INTO SCLASS(SNUM,SNAME,SROOM)
VALUES(10,'�鿣�� �����ڹ�',201);

INSERT INTO SCLASS
VALUES(20,'�����͹�', 202);

INSERT INTO SCLASS
VALUES(30,'AI���� �����ڹ�', 203);

SELECT * FROM SCLASS;
COMMIT;

-- �л� ������ ����
--10�� �б޿� 3����
--20�� �б޿� 3����
--30�� �б޿� 3����


INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(1,'ȫ�浿','���� ������','010-1111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(2,'��浿','��õ ������','010-2111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(3,'�ֿ���','���� �ϻ굿��','010-3111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(4,'�̱���','���� ������','010-4111-1111',20);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(5,'�̸��','���� ������','010-5111-1111',20);
INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(6,'���ڿ�','���� ������','010-6111-1111',20);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(8,'������','���� ������','010-8111-1111',30);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(9,'���ڿ�','���� ���뱸','010-9111-1111',30);

SELECT * FROM STUDENT;

COMMIT;
-- ���� �̻� ����
INSERT INTO STUDENT
VALUES(10,'�ƹ���','���� ���빮��','011-2323-2222','23-03-21',40);
-- ���� �̻� ����
-- 1�� �л��� �б� �����ϵ� 30���б����� �����ϼ���

 


