# 오라클 객체
[1] 시퀀스(sequence)

CREATE SEQUENCE 시퀀스명 
[INCREMENT BY n]
[START WITH n] 
[{MAXVALUE n | NOMAXVALUE}] 
[{MINVALUE n | NOMINVALUE}] 
[{CYCLE | NOCYCLE}] 
[{CACHE | NOCACHE}]
------------------------------------------
DESC DEPT; 
DEPT의 부서번호로 사용할 시퀀스를 생성해보자

시작값 : 50
증가치 : 10
최대값 : 90
최소값 : 50
nocycle
nocache
--------------------------
create sequence dept_seq
start with 50
increment by 10
maxvalue 90
minvalue 50
nocycle
nocache;

- 데이터 사전에서 조회하기
user_objects
user_sequences

select * from user_objects where object_type='SEQUENCE';
SELECT * FROM USER_SEQUENCES;

-- 시퀀스 현재값 조회 : 시퀀스명.CURRVAL
-- 시퀀스 다음값 조회 : 시퀀스명.NEXTVAL
: [주의] NEXTVAL을 하지 않은 채로 CURRVAL을 요구할 수 없다 => 에러발생

SELECT DEPT_SEQ.CURRVAL FROM DUAL;

SELECT DEPT_SEQ.NEXTVAL FROM DUAL;

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES (DEPT_SEQ.NEXTVAL, 'EDUCATION' || DEPT_SEQ.CURRVAL, 'SEOUL');

SELECT * FROM DEPT;

ROLLBACK;

# 시퀀스 수정/ 삭제
[주의] START WITH 는 수정 불가
ALTER SEQUENCE 시퀀스명
INCREMENT BY N
MAXVALUE N | NOMAXVALUE
MINVALUE N | NOMINVALUE
CYCLE | NOCYCLE
CACHE N | NOCACHE

- 삭제
- DROP SEQUENCE 시퀀스명

--DEPT_SEQ를 아래와 같이 수정하세요
--MAXVALUE 99
--MINVALUE 50
--증가치 5
--CYCLE 가능하도록
--CACHE 10
ALTER SEQUENCE DEPT_SEQ
MAXVALUE 99
MINVALUE 50
INCREMENT BY 5
CYCLE
CACHE 10;

SELECT * FROM USER_SEQUENCES;

SELECT DEPT_SEQ.NEXTVAL FROM DUAL;

DROP SEQUENCE DEPT_SEQ;
---------------------------------------
[2] VIEW
-- 
-- CREATE VIEW 뷰이름
--	AS
--	SELECT 컬럼명1, 컬럼명2...
--	FROM 뷰에 사용할 테이블명
--	WHERE 조건

--	[실습]
--	EMP테이블에서 20번 부서의 모든 컬럼을 포함하는 EMP20_VIEW를 생성하라.
CREATE VIEW EMP20_VIEW
AS 
SELECT * FROM EMP
WHERE DEPTNO=20;

=> ERROR발생 INSUFFICIENT PRIVILEGES
뷰 생성권한을 부여해야 생성 가능하다

SYSTEM, SYS 계정으로 접속해서 scott에게 권한을 부여하자
CONN SYSTEM/Abcd1234
SHOW USER;
GRANT CREATE VIEW TO SCOTT;

-- 데이터 사전에서 view 조회하기
-- user_views

SELECT * FROM USER_VIEWS;

SELECT * FROM EMP20_VIEW;

--[1] EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
--	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라.
CREATE VIEW EMP30_VIEW
AS
SELECT EMPNO EMPNO, ENAME NAME, SAL SALARY, DEPTNO DNO FROM EMP
WHERE DEPTNO=30;

SELECT * FROM EMP30_VIEW;
    
--[2] 고객테이블의 고객 정보 중 나이가 19세 이상인
--	고객의 정보를
--	확인하는 뷰를 만들어보세요.
--	단 뷰의 이름은 MEMBER_19로 하세요.
CREATE VIEW MEMBER_19
AS
SELECT * FROM MEMBER
WHERE AGE>=19;

SELECT * FROM MEMBER_19;

UPDATE MEMBER SET AGE=17 WHERE NUM=1;
-- 원본데이터에서 뷰의 조건에 충족되지 않는 데이터가 발생하면 뷰에서 자동으로 빠진다

# VIEW 수정
- OR REPLACE 옵션을 주어 수정한다
CREATE OR REPLACE VIEW MEMBER_19
AS
SELECT * FROM MEMBER WHERE AGE<19;

SELECT * FROM MEMBER_19;

SELECT * FROM EMP;


--[1] 부서별 급여총액, 사원수, 평균급여(소수점2자리까지), 최소급여,최대급여를 출력하는
--view를 만드세요
--뷰이름: emp_statistic
CREATE VIEW emp_statistic
AS
SELECT DEPTNO, SUM(SAL) SUM_SAL, COUNT(EMPNO) CNT, 
ROUND(AVG(SAL), 2) AVG_SAL, MIN(SAL) MIN_SAL, MAX(SAL) MAX_SAL
FROM EMP
GROUP BY DEPTNO;

SELECT * FROM EMP_STATISTIC ORDER BY DEPTNO;


--[2] 카테고리, 상품을 join하여 보여주는 view를 생성하세요
--뷰이름: products_view
CREATE OR REPLACE VIEW products_view
AS
SELECT CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE, COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK;

SELECT * FROM PRODUCTS_VIEW
WHERE CATEGORY_NAME LIKE '%도서%';

select category_name, products_name, output_price, company
from category c join products p
on c.category_code = p.category_fk
where  category_name like '%도서%';


SELECT * FROM EMP20_VIEW;

UPDATE EMP20_VIEW SET SAL=SAL*1.1 WHERE ENAME=UPPER('scott');

select * from emp;

-- group by 절을 이용해서 생성한 view는 dm1 조작이 불가능하다.

rollback;

# view 의 옵션

<1> with read only : 읽기 전용으로만 view를 사용하고자 할 경우
<2> with check option: view를 생성할때 주었던 조건에 맞지않는 
            데이터가 insert되거나 update되는 것을 허용하지 않는다
------------------------------------------------------------------
create or replace view emp10_view
as
select empno, ename, job, deptno
from emp where deptno=10
with read only;

select * from emp10_view;

update emp set job='ANALYST' where empno=7782;

rollback;

update emp10_view set job='ANALYST' where empno=7782;
--"cannot perform a DML operation on a read-only view"
----------------------------------------------------------
--job이 SALESMAN인 사원 정보만 모아 EMP_SALES_VIEW를 생성하되
--WITH CHECK OPTION을 줘서 생성하세요

CREATE OR REPLACE VIEW EMP_SALES_VIEW
AS
SELECT * FROM EMP
WHERE JOB='SALESMAN'
WITH CHECK OPTION;

SELECT * FROM EMP_SALES_VIEW;
SELECT * FROM EMP;
UPDATE EMP_SALES_VIEW SET COMM=100 WHERE EMPNO=7844; --[O]
UPDATE EMP_SALES_VIEW SET JOB='MANAGER' WHERE EMPNO=7844; --[X]
--ORA-01402: view WITH CHECK OPTION where-clause violation

UPDATE EMP SET JOB='MANAGER' WHERE EMPNO=7844;

ROLLBACK;

# INLINE VIEW
FROM 절에 사용한 SUBQUERY를 INLINE VIEW라고 함
----------------------------------------------------------
RANK() OVER(분석절)   : 분석절을 기준으로 랭킹을 매긴다 -> 공동순위 있음
ROW_NUMBER() OVER(분석절) : 분석절을 기준으로 행번호를 매긴다

분석절
PARTITION BY 컬럼명 : 컬럼명을 기준으로 그룹핑을 한다
ORDER BY 컬럼명 : 컬럼명을 기준으로 정렬한다


SELECT RANK() OVER(ORDER BY SAL DESC) RNK, EMP.*
FROM EMP;

업무별로 급여를 많이 받는 사원의 순위를 매기세요

SELECT RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) RNK, EMP.*
FROM EMP;

SELECT ROW_NUMBER() OVER(PARTITION BY JOB ORDER BY SAL DESC) RNK, EMP.*
FROM EMP;

업무별로 제일 급여가 많은 사람 1명만 출력하세요
SELECT * FROM (
SELECT RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) RNK, EMP.*
FROM EMP
) WHERE RNK=1;

------------------------------------------------------------- 
--03/30
CREATE INDEX 인덱스명 ON 테이블명 (컬럼명)

MEMBER 테이블의 NAME 컬럼에 인덱스를 생성해보자

CREATE INDEX MEMBER_NAME_IDX ON MEMBER (NAME);

- NAME 컬럼값을 다 읽는다
- NAME 컬럼값에 대해 오름차순 정렬을 한다
- ROWID와 NAME값을 저장하기 위한 저장공간을 할당한다
- 할당 후 값을 저장한다

데이터 사전에서 조회
- USER_OBJECTS
- USER_INDEXES
- USER_IND_COLUMNS : 인덱스 컬럼 정보

SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='INDEX';

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='MEMBER';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='MEMBER';
--WHERE INDEX_NAME='MEMBER_NAME_IDX';

SELECT * FROM MEMBER
WHERE NAME LIKE '%동%';

--상품 테이블에서 인덱스를 걸어두면 좋을 컬럼을 찾아 인덱스를 만드세요.
CREATE INDEX PRODUCTS_CATEGORY_FK_INDX ON PRODUCTS (CATEGORY_FK);

CREATE INDEX PRODUCTS_EP_CODE_FK_INDX ON PRODUCTS (EP_CODE_FK);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='PRODUCTS';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='PRODUCTS';

# 인덱스 수정 
수정 불가능. DROP 하고 다시 생성한다

# 인덱스 삭제
DROP INDEX 인덱스명;

DROP INDEX PRODUCTS_CATEGORY_FK_INDX;

-----------------------------------------------
[4] SYNONYM (동의어)
















