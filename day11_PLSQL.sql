변수유형
1. scalar 유형: number, char, varchar2, boolean, date, long, binary_integer
2. reference 유형
    - %type : 테이블명.컬럼명%type
    - %rowtype : 테이블명%rowtype
3. composite 유형
    - 복합자료형
4. lob유형
-----------------------------------------------------------
-- 사번을 인 파라미터로 넘기면 해당 사원의 정보를 가져와 출력하는 프로시저
CREATE OR REPLACE PROCEDURE emp_info
(pno IN emp.empno%type)
IS
    --vename varchar2(30):='아무개';
    vename emp.ename%type;
    vjob emp.job%type;
    vsal emp.sal%type;
BEGIN
 -- select 컬럼1,컬럼2
 -- into 변수1,변수2
 -- from 테이블명;
    SELECT ename,job,sal
    INTO vename,vjob,vsal
    FROM emp
    WHERE empno=pno;
    dbms_output.put_line('사  번: '||pno);
    dbms_output.put_line('사원명: '||vename);
    dbms_output.put_line('업  무: '||vjob);
    dbms_output.put_line('급  여: '||vsal);
END;
/
SET SERVEROUTPUT ON
EXEC emp_info(7369);
EXEC emp_info(7788);
------------------------------------------
-- 사번을 in 파라미터로 넘기면
-- 사원의 이름과 입사일, 부서번호, 부서명을 가져오는 프로시저를 작성해보자
create or replace procedure emp_rowtype
(pno in emp.empno%type)
is
    vemp    emp%rowtype;
    vdname  dept.dname%type;
begin
    select ename, hiredate, deptno
    into vemp.ename, vemp.hiredate, vemp.deptno
    from emp
    where empno=pno;
    
    select dname
    into vdname
    from dept
    where deptno=vemp.deptno;
    
    dbms_output.put_line('---------------------------------');
    dbms_output.put_line('부서번호  부서명     사원명     입사일');
    dbms_output.put_line('---------------------------------');
    dbms_output.put_line(vemp.deptno||chr(9)||chr(9)||vdname||' '||vemp.ename||' '||vemp.hiredate);
    dbms_output.put_line('---------------------------------');
    --예외처리부
    exception
        when no_data_found then
            dbms_output.put_line(pno||'번 사원은 존재하지 않습니다');
end;
/
---------------------------------------------

EXEC emp_rowtype(7521);
EXEC emp_rowtype(7499);
EXEC emp_rowtype(8499);
---------------------------------------------
-- 프로시저 소스 확인
select * from user_source;

select * from user_source
where name='MEMO_ADD';
---------------------------------------------
# COMPOSITE TYPE (복합 데이터 타입)
- TABLE 타입  ==> 자바의 배열과 유사
- RECORD 타입 ==> 자바의 CLASS와 유사
---------------------------------------------
-- 테이블 타입
-- 부서번호를 IN 파라미터로 넘기면 해당 부서에 소속된
-- 사원의 이름과 담당업무를 가져와 출력하는 프로시저
CREATE OR REPLACE PROCEDURE TABLE_TYPE
(PDNO IN DEPT.DEPTNO%TYPE)
IS
-- 테이블 선언
-- ENAME들을 저장할 TABLE유형 선언
TYPE ENAME_TABLE IS TABLE OF EMP.ENAME%TYPE
INDEX BY BINARY_INTEGER;
-- JOB들을 저장할 TABLE 유형 선언
TYPE JOB_TABLE IS TABLE OF EMP.JOB%TYPE
INDEX BY BINARY_INTEGER;

-- 테이블 타입의 변수 선언
ENAME_ARR ENAME_TABLE;
JOB_ARR JOB_TABLE;

-- 인덱스로 사용할 변수 선언
I BINARY_INTEGER := 0;
BEGIN
    -- 반복문 돌면서 EMP에서 데이터를 가져와서 ENAME_ARR에 저장한다
    FOR K IN (SELECT ENAME, JOB FROM EMP WHERE DEPTNO=PDNO) LOOP
    I := I+1;
    ENAME_ARR(I) := K.ENAME;
    JOB_ARR(I) := K.JOB;
    --JOB도 저장
    END LOOP;
    
    --테이블 타입 변수에 저장된 값 출력하기
    FOR J IN 1 .. I LOOP  -- 1부터 I값까지 1씩 증가하면서 반복문을 실행한다.
        DBMS_OUTPUT.PUT_LINE( RPAD(ENAME_ARR(J), 16, ' ') || JOB_ARR(J));
    END LOOP; 
END;
/
----------------------------------------------------

EXEC TABLE_TYPE(10);
EXEC TABLE_TYPE(20);
EXEC TABLE_TYPE(30);
----------------------------------------------------
-- RECORD 타입
-- 사원명을 IN 파라미터로 전달하면 해당 사원 정보를 출력하는 프로시저
-- 사번, 업무, 급여
CREATE OR REPLACE PROCEDURE RECORD_TYPE
(PNAME IN EMP.ENAME%TYPE)
IS
    -- 레코드 타입 선언
    TYPE EMP_RECORD IS RECORD(
        VNO EMP.EMPNO%TYPE,
        VNAME EMP.ENAME%TYPE,
        VJOB EMP.JOB%TYPE,
        VMGR EMP.MGR%TYPE,
        VDATE EMP.HIREDATE%TYPE,
        VSAL EMP.SAL%TYPE,
        VCOMM EMP.COMM%TYPE,
        VDNO EMP.DEPTNO%TYPE
    );
    -- 레코드 타입의 변수 선언
    EMP_REC EMP_RECORD;
BEGIN
    SELECT * INTO EMP_REC FROM EMP WHERE ENAME=UPPER(PNAME);
    --출력하기
    DBMS_OUTPUT.PUT_LINE('---'||PNAME||'님 정보---');
    DBMS_OUTPUT.PUT_LINE('사번 : '||EMP_REC.VNO);
    DBMS_OUTPUT.PUT_LINE('이름 : '||EMP_REC.VNAME);
    DBMS_OUTPUT.PUT_LINE('업무 : '||EMP_REC.VJOB);
    DBMS_OUTPUT.PUT_LINE('급여 : '||EMP_REC.VSAL);
    
-- 예외 처리하기
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(PNAME||'사원은 없습니다');
END;
/

EXEC RECORD_TYPE('KING');
EXEC RECORD_TYPE('BLAKE');
EXEC RECORD_TYPE('QUEEN');
---------------------------------------
# BIND 변수
VARIABLE 변수명 자료형
----------------------------------------
VARIABLE MYVAR NUMBER;

DECLARE
BEGIN
    --바인드 변수를 참조할 때는 앞에 콜론(:)을 접두어로 붙인다
    :MYVAR := 500;
END;
/

PRINT MYVAR
----------------------------------------
# 프로시저 파라미터 종류
[1] IN PARAMETER : 
[2] OUT PARAMETER
[3] IN OUT PARAMETER
----------------------------------------
-- IN PARAMETER


CREATE OR REPLACE PROCEDURE DEPT_ADD
(VNO IN NUMBER DEFAULT 99,
 VNAME IN DEPT.DNAME%TYPE,
 VLOC IN DEPT.LOC%TYPE)
IS
BEGIN
    INSERT INTO DEPT(DEPTNO, DNAME, LOC)
    VALUES(VNO, VNAME, VLOC);
END;
/

EXEC DEPT_ADD(51, 'EDUCATION', 'SEOUL');
EXEC DEPT_ADD(VNAME=>'PLANNING', VLOC=>'SUWON');
SELECT * FROM DEPT;
ROLLBACK;
--------------------------------------------
-- OUT PARAMETER
-- 프로시저가 호출자에게 넘겨주는 값
-- 디폴트값 지정 불가

-- 사번을 인 파라미터로 넘기면 해당 사원의 이름을 아웃 파라미터로
-- 내보내는 프로시저

CREATE OR REPLACE PROCEDURE ENAME_FIND
(
    PNO IN EMP.EMPNO%TYPE,
    ONAME OUT EMP.ENAME%TYPE
)
IS
BEGIN
    SELECT ENAME INTO ONAME
    FROM EMP
    WHERE EMPNO=PNO;
END;
/
------------------
-- OUT 파라미터를 받아줄 바인드 변수를 선언하자
var fname varchar2(30);

execute ename_find(7499, :fname);

print fname;
--------------------------------
-- IN OUT PROCEDURE : IN도 하고 OUT도 하는 파라미터
CREATE OR REPLACE PROCEDURE INOUT_TEST
(
A1 IN NUMBER,
A2 IN VARCHAR2,
A3 IN OUT VARCHAR2,
A4 OUT VARCHAR2
)
IS
    MSG VARCHAR2(30) := ' ';
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------');
    DBMS_OUTPUT.PUT_LINE('프로시저 시작 전 ');
    DBMS_OUTPUT.PUT_LINE('--------------------');
    DBMS_OUTPUT.PUT_LINE('A1 : '||TO_CHAR(A1, '999,999')); -- IN
    DBMS_OUTPUT.PUT_LINE('A2 : '||A2);  -- IN
    DBMS_OUTPUT.PUT_LINE('A3 : '||A3);  -- IN OUT
    DBMS_OUTPUT.PUT_LINE('A4 : '||A4);  -- OUT
    A3 := '프로시저 바깥에서 이 값을 받을 수 있을까?';
    MSG:= '당연하지!!';
    A4 := MSG;
    
    DBMS_OUTPUT.PUT_LINE('--------------------');
    DBMS_OUTPUT.PUT_LINE('프로시저 시작 후 ');
    DBMS_OUTPUT.PUT_LINE('--------------------');
    DBMS_OUTPUT.PUT_LINE('A1 : '||TO_CHAR(A1, '999,999'));  -- IN
    DBMS_OUTPUT.PUT_LINE('A2 : '||A2);  -- IN
    DBMS_OUTPUT.PUT_LINE('A3 : '||A3);  -- IN OUT
    DBMS_OUTPUT.PUT_LINE('A4 : '||A4);  -- OUT
END;
/

VAR C VARCHAR2(100);
VAR D VARCHAR2(100);
exec :c := 'in test';
print c;

EXEC INOUT_TEST(750000, 'Hello', :c, :d);

print c;
print d;
----------------------------------------------
--# select문을 수행하는 프로시저
--인 파라미터로 job을 넘기면
--해당 업무를 수행하는 사원정보를 가져오는 프로시저

-- 프로시저명: emp_job_info
-- 사원정보를 받을 변수: %rowtype

CREATE OR REPLACE PROCEDURE emp_job_info
( pjob in emp.job%type )
IS
pemp emp%rowtype;
BEGIN
    select * into pemp
    from emp
    where job=upper(pjob);
    dbms_output.put_line('---'||pjob||'----');
    dbms_output.put_line('이름: '||pemp.ename);
END;
/
exec emp_job_info('manager');

-- ORA-01422: exact fetch returns more than requested number of rows
-- 결과값이 다중행을 반환할 때는 커서를 이용해야 한다
----------------------------------------------
CREATE OR REPLACE PROCEDURE emp_job_info
( pjob in emp.job%type )
IS
vemp emp%rowtype;
--커서 선언
cursor emp_cr is
select * from emp where job=upper(pjob);
BEGIN
    --커서 열기 open
    open emp_cr;
    --반복문 돌면서 데이터 인출(fetch)
    dbms_output.put_line('---'||upper(pjob)||'----');
    loop
    --데이터 인출
    fetch emp_cr into vemp;
    exit when emp_cr%notfound; --반복문을 벗어난다
    dbms_output.put_line(rpad(vemp.ename, 14,' ')||vemp.sal);
    end loop;
    --커서 닫기 close
    close emp_cr;
    dbms_output.put_line('이름: '||vemp.ename);
END;
/
---------------------------------------
exec emp_job_info('manager');
exec emp_job_info('salesman');
---------------------------------------------------------
--부서번호를 in 파라미터로 전달하면
--해당 부서의 사원정보를 out파라미터로 내보내는 프로시저 작성해서
--java와 연동해봅시다
--이름, 업무, 부서명, 근무지, 입사일

create or replace procedure emp_forjava
(
    pdno in emp.deptno%type,
    mycr out sys_refcursor
)
is
begin
    /*
    open mycr for
    select ename, job, dname, loc, hiredate
    from dept d join emp e
    on d.deptno=e.deptno and e.deptno=pdno;
    */
    open mycr for
    select ename, job, dname, loc, hiredate from 
    (select * from emp where deptno=pdno) A join dept d
    on a.deptno=d.deptno;
end;
/
--------------------------------------
--//검색어를 입력하면 해당 검색어를 갖는 메모글을 가져오는 프로시저를 작성하고
--//자바와 연동시키세요
create or replace procedure memo_find
(
    fstr in memo.msg%type,
    mycr out sys_refcursor
)
is
begin
    open mycr for 
    select no, name, msg, wdate
    from memo where msg like '%'||fstr||'%';
end;
/


select * from memo;














