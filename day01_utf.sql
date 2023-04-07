select * from tab;
-- 단문 주석
/* 복문 주석
c:/myjava/SQL/day01.sql
*/
-- 인사관리 시스템
select * from dept;
select dname from dept;
select dname,loc,deptno from dept;

select * from emp;
select ename,job,sal from emp;

select * from salgrade;
-- 쇼핑몰 시스템
select * from member; -- 회원
select * from category; -- 카테고리
select * from products; -- 상품
select * from supply_comp; --공급업체

drop table products;
drop table category;

/* 카테고리 저장테이블 */
CREATE TABLE CATEGORY(
  CNUM NUMBER(5) DEFAULT '1' NOT NULL,
  CATEGORY_CODE VARCHAR2(8) NOT NULL,
  CATEGORY_NAME VARCHAR2(30) NOT NULL,
  DELETE_CHK CHAR(1) DEFAULT 'N' NOT NULL,
  PRIMARY KEY(CNUM)
);

/* 카테고리 SEQUENCE */
CREATE SEQUENCE CATEGORY_SEQ
  START WITH 13
  INCREMENT BY 1 ;

/* 카테고리 저장 */
INSERT INTO CATEGORY VALUES('1','00010000','전자제품','N');
INSERT INTO CATEGORY VALUES('2','00010001','TV','N');
INSERT INTO CATEGORY VALUES('3','00010002','컴퓨터','N');
INSERT INTO CATEGORY VALUES('4','00010003','MP3','N');
INSERT INTO CATEGORY VALUES('5','00010004','에어컨','N');
INSERT INTO CATEGORY VALUES('6','00020000','의류','N');
INSERT INTO CATEGORY VALUES('7','00020001','남방','N');
INSERT INTO CATEGORY VALUES('8','00020002','속옷','N');
INSERT INTO CATEGORY VALUES('9','00020003','바지','N');
INSERT INTO CATEGORY VALUES('10','00030000','도서','N');
INSERT INTO CATEGORY VALUES('11','00030001','컴퓨터도서','N');
INSERT INTO CATEGORY VALUES('12','00030002','소설','N');
commit;

select * from category;

/* 상품 상세 정보 테이블 */
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

/* 상품 내용 저장 */
INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
   VALUES
    ('1','00010001','S 벽걸이 TV','00001','5000000','8000000','0','100000','삼성','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,COMPANY,STATUS)
  VALUES
    ('2','00010001','D TV','00002','300000','400000','대우','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('3','00010004','S 에어컨','00001','1000000','1100000','5000','10000','삼성','2');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('4','00010000','C 밥솥','00003','200000','200000','5500','0','현대','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('5','00010004','L 에어컨','00003','1200000','1300000','0','0','LG','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
    ('6','00020001','남성남방','00002','100000','150000','2500','0','','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('7','00020001','여성남방','00002','120000','200000','0','0','3');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
   OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('8','00020002','사각팬티','00002','10000','20000','0','0','보디가드','1');

INSERT INTO PRODUCTS
   (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
    OUTPUT_PRICE,TRANS_COST,MILEAGE,STATUS)
  VALUES
   ('9','00020003','멜빵바지','00002','5000','8000','0','0','1');

INSERT INTO PRODUCTS
    (PNUM,CATEGORY_FK,PRODUCTS_NAME,EP_CODE_FK,INPUT_PRICE,
     OUTPUT_PRICE,TRANS_COST,MILEAGE,COMPANY,STATUS)
  VALUES
   ('10','00030001','무따기시리즈','00001','25000','30000','2000','0','길벗','1');
commit;

select * from products;

-- 학생 테이블 생성
create table student(
  num number(4) primary key, -- unique + not null
  name varchar2(30) not null,
  addr varchar2(100) not null,
  tel varchar2(15) not null,
  indate date default sysdate, --시스템의 현재 날짜를 디폴트값으로 설정
  cname varchar2(50),
  croom number(3)
);
select * from student;
-- 학생정보 등록
--INSERT INTO 테이블명(컬럼명1,컬럼명2,...)
--VALUES(값1,값2,...);
INSERT INTO STUDENT(num,name,addr,tel,cname,croom)
values(1,'홍길동','서울 마포구','010-1111-1111','백엔드 개발자반',201);
commit; --db에 영구히 저장

select * from student;

insert into student(num,addr,name,tel,cname,croom)
values(2,'인천광역시 남동구','김길동','010-2222-2222','백엔드 개발자반',201);

rollback; --취소

insert into student(num,name,addr,tel)
values(3,'최영자','고양시 일산동구','010-3333-3333');

select * from student;

commit;

insert into student
values(4,'이길자','수원',
'010-9999-9999','23/03/21','빅데이터반',202);
select * from student;
commit; -- transaction control language TCL

-- 빅데이터반에 2명 더 등록
insert into student
values(5,'이길동','서울 성동구',
'010-3999-9999','23/03/20','빅데이터반',202);
insert into student
values(6,'최영미','수원시 광교',
'010-9123-9999','23/03/21','빅데이터반',202);

-- AI서비스개발자반 3명 등록하기 203호
insert into student
values(7,'김동원','서울 강서구',
'010-5699-1999','23/03/22','AI서비스 개발자반',203);

insert into student
values(8,'김지연','서울 강동구',
'010-7699-1998','23/03/23','AI서비스 개발자반',203);

insert into student
values(9,'강동원','서울 강남구',
'010-5699-1111','23/03/21','AI서비스 개발자반',203);
commit;

-- 데이터 수정
--update 테이블명 set 컬럼명1=값1, 컬럼명2=값2,...
--where 조건절
update  student set cname='백엔드 개발자반', croom=201
where num=3;

select * from student;

-- 홍길동인 학생의 연락처를 010-1234-5678로 수정하세요
update student set tel='010-1234-5678'
where num=1;
--where name='홍길동' and croom=201;
rollback;
commit;

-- 데이터 삭제
--DELETE FROM 테이블명 WHERE 조건절;
SELECT * FROM STUDENT;

-- DELETE FROM STUDENT;
DELETE FROM STUDENT WHERE NUM=2;
DELETE FROM STUDENT WHERE NAME='김지연';
ROLLBACK;

INSERT INTO STUDENT
VALUES(10,'유재석','서울 강북구','010-7878-8989',SYSDATE,'백엔드반','301');
COMMIT;

SELECT * FROM STUDENT;

SELECT * FROM STUDENT
WHERE CROOM=201;
-- WHERE CNAME='백엔드 개발자반';

-- 테이블 삭제 : DDL
--DROP TABLE 테이블명;

DROP TABLE STUDENT;

-- 학급테이블 (부모테이블-MASTER TABLE)

CREATE TABLE SCLASS(
    SNUM NUMBER(4) PRIMARY KEY, -- 학급번호
    SNAME VARCHAR2(50) NOT NULL, -- 학급명
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

-- 학급 데이터를 삽입하세요
--10 백엔드개발자반 201
--20 빅데이터반 202
--30 AI서비스 개발자반 203

INSERT INTO SCLASS(SNUM,SNAME,SROOM)
VALUES(10,'백엔드 개발자반',201);

INSERT INTO SCLASS
VALUES(20,'빅데이터반', 202);

INSERT INTO SCLASS
VALUES(30,'AI서비스 개발자반', 203);

SELECT * FROM SCLASS;
COMMIT;

-- 학생 데이터 삽입
--10번 학급에 3명등록
--20번 학급에 3명등록
--30번 학급에 3명등록


INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(1,'홍길동','서울 마포구','010-1111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(2,'김길동','인천 남동구','010-2111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(3,'최영자','고양시 일산동구','010-3111-1111',10);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(4,'이길자','서울 강남구','010-4111-1111',20);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(5,'이명길','서울 강동구','010-5111-1111',20);
INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(6,'김자영','서울 강서구','010-6111-1111',20);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(8,'동길자','서울 성동구','010-8111-1111',30);

INSERT INTO STUDENT(NUM,NAME,ADDR,TEL,SNUM_FK)
VALUES(9,'이자영','수원 영통구','010-9111-1111',30);

SELECT * FROM STUDENT;

COMMIT;
-- 삽입 이상 방지
INSERT INTO STUDENT
VALUES(10,'아무개','서울 서대문구','011-2323-2222','23-03-21',40);
-- 수정 이상 방지
-- 1번 학생의 학급 변경하되 30번학급으로 변경하세요
UPDATE STUDENT SET SNUM_FK=30 WHERE NUM=1;

-- 2번 학생의 학급 변경하되 40번학급으로 변경하세요
UPDATE STUDENT SET SNUM_FK=40 WHERE NUM=2;

SELECT * FROM STUDENT;

-- 삭제이상 방지
SELECT COUNT(*) FROM STUDENT WHERE SNUM_FK=10;

DELETE FROM SCLASS WHERE SNUM=10;
-- 외래키로 참조하는 데이터가 자식테이블에 있다면 삭제할 수 없음

SELECT * FROM STUDENT;

-- JOIN 문
SELECT SNUM,SNAME,NAME, TEL, INDATE,SNUM_FK
FROM SCLASS JOIN STUDENT
ON SCLASS.SNUM = STUDENT.SNUM_FK
ORDER BY SNUM ASC;

-- 단문 주석
/* 복문 주석
*/

--사원은 부서에 소속되어 있다.
SELECT * FROM dept; -- 부모테이블 : deptno: PK (Unique + not null)
SELECT * FROM emp;  -- 자식테이블 : deptno: FK



select empno, ename, sal from emp;

select empno, ename, sal, sal+300 as sal_up from emp;
-- alias : 별칭

-- emp에서 사번, 사원명, 급여, 보너스(comm), 급여*12+보너스 year_sal (실습)
select empno, ename, sal, comm, sal*12+comm as year_sal from emp;

--NVL(컬럼명, 값)함수
--컬럼이 null일 경우 주어진 값으로 대체해서 반환한다

--NVL2(EXPR, EXPR1, EXPR2)
--EXPR값이 NULL이 아닐 경우에는 EXPR1값을 반환하고,
--        NULL일 경우에는 EXPR일2값을 반환한다
        
select empno, ename, sal, comm, sal*12+nvl(comm,0) as year_sal from emp;

 
SELECT ENAME, JOB, SAL FROM EMP
WHERE ENAME=UPPER('scott');

--EMP테이블에서 관리자(MGR)가 있을 경우에는 1, 없으면 0이 출력되도록 하세요(실습)
SELECT EMPNO, ENAME, MGR, NVL2(MGR, 1, 0) "관리자 존재 여부" FROM EMP;


