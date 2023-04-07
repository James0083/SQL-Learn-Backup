-- function
-- 사번을 인 파라미터로 넘기면 해당 사원의 부서명을 반환하는 함수
create or replace function getDname
(pname in emp.ename%type)
return varchar2 --반환타입 지정
is
vdno emp.deptno%type;
vdname dept.dname%type;
begin
    select deptno
    into vdno
    from emp where ename=upper(pname);
    
    select dname
    into vdname
    from dept where deptno=vdno;
    return vdname; --값을 반환한다
    
    exception
    when no_data_found then
        dbms_output.put_line(pname||' 사원은 없습니다');
        return SQLERRM;
    when too_many_rows then
        dbms_output.put_line(pname||' 사원 데이터가 2건 이상 있습니다');
        return sqlerrm;
    when others then
        return sqlerrm;
end;
/
-------------------------------
-- 함수의 반환값을 받기 위한 바인드 변수 선언
set serveroutput on;
var gname varchar2;
exec :gname := getDname('james');
print gname;
-------------------------------------------------
# 패키지
여러 개의 프로시저, 함수, 커서 등을 하나의 패키지로 묶어 관리할 수 있다
[1] 패키지 선언부
[2] 패키지 본문 (package body)
----------------------------------
--[1] 패키지 선언부
create or replace package empInfo as
procedure allEmp;
procedure allSal;
end empInfo;
/
--[2] 패키지 본문 구성
create or replace package body empInfo as
    -- allEmp : 모든 사원의 사번, 이름, 입사일 가져와 출력하는 프로시저
    procedure allEmp
    is
    cursor empCr is
        select empno,ename,hiredate from emp order by 3;    
    begin
        for k in empCr loop
            dbms_output.put_line(k.empno||lpad(k.ename,16,' ')||lpad(k.hiredate,16,' '));
        end loop;
        exception
            when others then 
                dbms_output.put_line(SQLERRM||'에러 발생');
    end allEmp;
    --allSal : 전체 사원의 급여 합계, 사원수, 평균급여, 최대 급여, 최소급여
    procedure allSal
    is
    begin
    dbms_output.put_line('급여총합'||lpad('사원수',10,' ')||lpad('평균급여',10,' ')||
                        lpad('최대급여',10,' ')||lpad('최소급여',10,' '));
        for k in (select sum(sal) sumSal, count(*) empC, round(avg(sal),2) avgSal, 
                max(sal) maxSal, min(sal) minSal from emp ) loop
        dbms_output.put_line(k.sumSal||lpad(k.empC,5,' ')||lpad(k.avgSal,10,' ')||
                        lpad(k.maxSal,10,' ')||lpad(k.minSal,10,' '));
        end loop;
    end allSal;
end empInfo;
/
-------------------------------------------
--exec 패키지명.프로시저명(파라미터값)
exec empInfo.allEmp;
exec empInfo.allSal;
----------------------------------------------------------
--# TRIGGER
--INSERT, UPDATE, DELETE 문이 실행될때 묵시적으로 수행되는 일종의 프로시저

--부서명이 수정될때 이전 부서명과 변경된 부서명을 기록으로 남기는 트리거를 작성해보자
CREATE OR REPLACE TRIGGER TRG_DEPT
BEFORE UPDATE ON DEPT
FOR EACH ROW
DECLARE
    MSG VARCHAR2(20);
BEGIN
    MSG:='HI TRIGGER';
    DBMS_OUTPUT.PUT_LINE(MSG);
    DBMS_OUTPUT.PUT_LINE('변경 전 컬럼값: '||:OLD.DNAME);
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼값: '||:NEW.DNAME);
END;
/
SELECT * FROM DEPT;
UPDATE DEPT SET DNAME='운영부서' WHERE DEPTNO=40;
UPDATE DEPT SET LOC='SEOUL' WHERE DEPTNO=40;
ROLLBACK;

-- 트리거 비활성화
ALTER TRIGGER 트리거명 DISABLE;

-- 트리거 활성화
ALTER TRIGGER 트리거명 ENABLE;

--TRG_DEPT를 비활성화하고 UPDATE문을 수행해보세요
ALTER TRIGGER TRG_DEPT DISABLE;
UPDATE DEPT SET DNAME='운영부서' WHERE DEPTNO=40;
ROLLBACK

ALTER TRIGGER TRG_DEPT ENABLE;

-- 데이터 사전에서 조회
-- USER_TRIGGERS
SELECT * FROM USER_TRIGGERS WHERE TRIGGER_NAME='TRG_DEPT';

-- 트리거 삭제
--DROP TRIGGER 트리거명;
DROP TRIGGER TRG_DEPT;
SELECT * FROM USER_TRIGGERS;

--EMP 테이블에 데이터가 INSERT되거나 UPDATE될 경우 (BEFORE)
--전체 사원들의 평균급여를 출력하는 트리거를 작성하세요.
--테스트할때는 전체 사원의 급여를 10% 인상시키세요
-- 신입사원정보 등록하세요(사번,사원명,부서번호,급여)
CREATE OR REPLACE TRIGGER TRG_EMP_AVG
BEFORE
INSERT OR UPDATE ON EMP
--FOR EACH ROW
DECLARE
    AVG_SAL NUMBER;
BEGIN
    SELECT ROUND(AVG(SAL),2) INTO AVG_SAL FROM EMP;
    DBMS_OUTPUT.PUT_LINE('평균급여: '||AVG_SAL);
END;
/
SELECT * FROM USER_TRIGGERS;

INSERT INTO EMP(EMPNO, ENAME, DEPTNO, SAL)
VALUES(9003, 'TOM', 20, 4000);
SELECT * FROM EMP;
ROLLBACK;

SELECT AVG(SAL) FROM EMP;

UPDATE EMP SET SAL=SAL*1.1;

SELECT AVG(SAL) FROM EMP;;
-----------------------------------------------
--[트리거 실습 1] 행 트리거
--입고 테이블에 상품이 입고될 경우
--상품 테이블에 상품 보유수량이 자동으로 변경되는 
--트리거를 작성해봅시다.

입고테이블 : MYINPUT
상품테이블 : MYPRODUCT
CREATE TABLE MYPRODUCT(
    PCODE CHAR(6) PRIMARY KEY,
    PNAME VARCHAR2(20) NOT NULL,
    PCOMPANY VARCHAR2(20),
    PRICE NUMBER(8),
    PQTY NUMBER DEFAULT 0
);

DESC MYPRODUCT;
CREATE SEQUENCE MYPRODUCT_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL, '노트북', 'A사', 800000, 10);

INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL, 'TV', 'B사', 1000000, 20);

INSERT INTO MYPRODUCT
VALUES('A00'||MYPRODUCT_SEQ.NEXTVAL, '킥보드', 'C사', 70000, 30);

SELECT * FROM MYPRODUCT;
COMMIT;

-- 입고 테이블
CREATE TABLE MYINPUT(
    INCODE NUMBER PRIMARY KEY, --입고번호
    PCODE_FK CHAR(6) REFERENCES MYPRODUCT(PCODE), --입고상품코드
    INDATE DATE DEFAULT SYSDATE,
    INQTY NUMBER(6), --입고 수량
    INPRICE NUMBER(8) --입고 가격
);
DESC MYINPUT;

CREATE SEQUENCE MYINPUT_SEQ NOCACHE;

-- 입고 테이블에 상품이 입고되면
-- 상품 테이블의 보유 수량(PQTY)을 변경하는 트리거를 작성해보자
CREATE OR REPLACE TRIGGER TRG_MYPRODUCT
AFTER INSERT ON MYINPUT
FOR EACH ROW
DECLARE
BEGIN
    UPDATE MYPRODUCT SET PQTY=PQTY+:NEW.INQTY
    WHERE PCODE = :NEW.PCODE_FK;
    DBMS_OUTPUT.PUT_LINE(:NEW.PCODE_FK||'번 상품이 추가로 '||:NEW.INQTY||'개 들어옴');
END;
/
----------------------------------------
SELECT * FROM MYPRODUCT;

-- A001상품이 추가로 15개 들어옴
INSERT INTO MYINPUT(INCODE,PCODE_FK,INQTY, INPRICE)
VALUES(MYINPUT_SEQ.NEXTVAL,'A001',15,500000);

SELECT * FROM MYPRODUCT;
--A002 추가로 8개 700000
INSERT INTO MYINPUT
VALUES(MYINPUT_SEQ.NEXTVAL,'A002',SYSDATE,8,700000);
COMMIT;
SELECT * FROM MYINPUT;
SELECT * FROM MYPRODUCT;
--------------------------------------
--[실습1] 입고 테이블의 수량이 변경될 경우-UPDATE문이 실행될 때 
--상품 테이블의 수량을 수정하는 트리거를 작성하세요
-- :OLD.INQTY 차감하고, :NEW.INQTY 더하는
CREATE OR REPLACE TRIGGER TRG_MYPRODUCT_UPDATE
AFTER UPDATE ON MYINPUT
FOR EACH ROW
DECLARE
BEGIN
    UPDATE MYPRODUCT SET PQTY = PQTY - :OLD.INQTY + :NEW.INQTY 
    WHERE PCODE = :NEW.PCODE_FK;
    DBMS_OUTPUT.PUT_LINE(:NEW.PCODE_FK||'번 상품의 개수가 수정됨');
    DBMS_OUTPUT.PUT_LINE('NEW: '||:NEW.INQTY||', OLD: '||:OLD.INQTY||', GAP: '||:NEW.INQTY-:OLD.INQTY);
END;
/

SELECT * FROM MYINPUT;
SELECT * FROM MYPRODUCT;
UPDATE MYINPUT SET INQTY=7 WHERE INCODE=1;

--[실습2] 입고 테이블에 데이터가 삭제될 경우-DELETE문이 실행될 때
--상품 테이블의 수량을 수정하는 트리거를 작성하세요
-- :OLD.INQTY를 차감함
CREATE OR REPLACE TRIGGER TRG_MYPRODUCT_DELETE
AFTER DELETE ON MYINPUT
FOR EACH ROW
DECLARE
BEGIN
    UPDATE MYPRODUCT SET PQTY=PQTY-:OLD.INQTY
    WHERE PCODE= :OLD.PCODE_FK;
    DBMS_OUTPUT.PUT_LINE(:OLD.PCODE_FK||'번 상품이 '||:OLD.INQTY||'개 삭제됨');
END;
/

SELECT * FROM MYINPUT;
SELECT * FROM MYPRODUCT;

DELETE FROM MYINPUT WHERE INCODE=3;
SELECT * FROM MYPRODUCT;

COMMIT;
------------------------------------------
--[트리거 실습2] - 문장 트리거
--EMP 테이블에 신입사원이 들어오면(INSERT) 로그 기록을 남기자
--어떤 DML문장을 실행했는지, DML이 수행된 시점의 시간, USER 데이터를
--EMP_LOG테이블에 기록하자.
CREATE TABLE EMP_LOG(
    LOG_CODE NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30),
    LOG_DATE DATE DEFAULT SYSDATE,
    BEHAVIOR VARCHAR2(20)
);

CREATE SEQUENCE EMP_LOG_SEQ NOCACHE;
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL;
----------------------------------------
CREATE OR REPLACE TRIGGER TRG_EMP_LOG
BEFORE INSERT ON EMP
DECLARE
BEGIN
    IF(TO_CHAR(SYSDATE,'DY')) IN ('목', '금', '토','일') then
        raise_application_error(-20001,'목,금,토,일요일에는 입력작업을 할 수 없어요');
    else
        insert into emp_log(log_code,user_id,log_date,behavior)
        values(emp_log_seq.nextval,user,sysdate,'insert');
    end if;
END;
/
------------------------------------
-- emp에 사번, 사원명, 부서번호, 입사일을 새로 insert하세요
insert into emp(empno,ename,deptno,hiredate)
values(9032,'THOMAS',30,SYSDATE);

SELECT * FROM EMP;

SELECT * FROM EMP_LOG;









