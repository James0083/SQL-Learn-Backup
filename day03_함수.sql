-- 오라클의 함수
# 단일행 함수##########
[1] 문자형 함수
[2] 숫자형 함수
[3] 날짜형 함수
[4] 변환형 함수
[5] 기타 함수

-----------------------
[1] 문자형 함수

-LOWER()/UPPER()
 소문자/대문자로 바꿔 출력하는 함수
-----------------------------
SELECT LOWER('Happy Birthday to You'), upper('Happy Birthday to You')
from dual;

--dual : 1개의 행만 갖는다
select * from dual;
select 2*7 from dual;

- INITCAP : 첫 문자를 대문자로 나머지는 소문자로 변환
- CONCAT(컬럼1, 컬럼2) : 컬럼1과 컬럼2를 연결한 값을 반환하는 함수
----------------------------
SELECT INITCAP(ENAME) FROM EMP;
SELECT CONCAT('ABCD', '1234') FROM DUAL;
SELECT EMPNO, ENAME, JOB, CONCAT(ENAME, EMPNO), CONCAT(ENAME, JOB)
FROM EMP;


--------------------------------
- SUBSTR(컬럼, N, LEN) - 문자 N에서 시작하여 LEN개 문자 길이만큼 변수를 리턴
SELECT SUBSTR('051224-1012456',1,6) FROM DUAL;

SELECT SUBSTR('051224-1012456', 8) FROM DUAL;

SELECT SUBSTR('051224-1012456',-7) FROM DUAL;

SELECT SUBSTR('ABCDEFG',-4,3) FROM DUAL;

-LENGTH(컬럼) : 문자열의 길이를 반환함


--[문제]
--	  사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--	  사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
--WHERE SUBSTR(ENAME, 1, 1) BETWEEN 'K' AND 'Y' ;
WHERE SUBSTR(ENAME, 1, 1) > 'K' AND SUBSTR(ENAME, 1, 1)< 'Y' ;

--    
--    사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,
--	급여,급여의 자릿수를 출력하세요.	
SELECT EMPNO, ENAME, DEPT, LENGTH(ENAME), SAL, LENGTH(SAL)
FROM EMP
WHERE DEPTNO = 20;
--	
--	사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 
--	이름자릿수를 보여주세요.
SELECT ENAME, LENGTH(ENAME) FROM EMP
WHERE LENGTH(ENAME) >= 6;


- LPAD() / RPAD()
- LPAD(컬럼, N, C) : 컬럼값을 N자리만큼 출력하되, 왼쪽에 남는 공간이 있으면 C값으로 채운다.
- RPAD(컬럼, N, C) : 컬럼값을 N자리만큼 출력하되, 오른쪽에 남는 공간이 있으면 C값으로 채운다.

SELECT ENAME, LPAD(ENAME, 15, ' '), SAL, LPAD(SAL, 10, '#')
FROM EMP;

SELECT DNAME, RPAD(DNAME, 15, '@') FROM DEPT;
SELECT DNAME, RPAD(DNAME, 15, ' ') FROM DEPT;


- LTRIM() / RTRIM()
    왼쪽/오른쪽의 공백을 제거한다
LTRIM(변수1, 변수2) : 변수1 중에 변수2에 해당하는 값이 있으면 삭제한다.

SELECT LTRIM('TTTHello TEST', 'T'), LTRIM('TOPHello TEST', 'T') FROM DUAL;
SELECT RTRIM('TTTHello TEST', 'T') FROM DUAL;

SELECT LTRIM('    ORACLE TEST  '), RTRIM('    ORACLE TEST  ') FROM DUAL;

SELECT LTRIM(RTRIM('    ORACLE TEST  ')) RESULT FROM DUAL;


--------------------------------------------------
- REPLACE(컬럼, 값1, 값2) : 컬럼값 중 값1에 해당하는 값이 있으면 값2로 변경하여 보여줌.(실제값을 변경하는건 아님)

SELECT REPLACE('ORACLE TEST', 'TEST', 'HI') FROM DUAL;


--------------------------------------------------
--[문제]
--	사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--	삭제하고 급여중 우측의 0을 삭제하여 출력하세요. 
SELECT ENAME, RTRIM(JOB,'T'), JOB, RTRIM(SAL, 0), SAL, DEPTNO
FROM EMP;
WHERE DEPTNO=10;
--   
--	  사원테이블 JOB에서 'A'를 '$'로 바꾸어 출력하세요.
SELECT REPLACE(JOB, 'A', '$'), JOB
FROM EMP;
--
--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--	 대학생으로 변경해 출력되게 하세요.
SELECT NAME, JOB, REPLACE(JOB, '학생', '대학생'), ADDR
FROM MEMBER;
--	
--고객 테이블 주소에서 서울시를 서울특별시로 수정하세요 => UPDATE문 사용


-UPDATE 테이블명 SET 컬럼명1=값1, 컬럼명2=값2, .... WHERE 조건절

UPDATE MEMBER SET ADDR='서울특별시 강북' WHERE NAME='홍길동' AND JOB='주부';

SELECT * FROM MEMBER;

ROLLBACK;

UPDATE MEMBER SET ADDR=REPLACE(ADDR, '서울시', '서울특별시');

---------------------------------------------------------------
[2] 숫자형 함수
-ROUND() : 반올림함수
 ROUND(값), ROUND(값, 자리수(디폴트=0))
 
 SELECT ROUND(4567.678), ROUND(4567.678, 0), ROUND(4567.678, 2), ROUND(4567.678, -2)
 FROM DUAL;
 
 자리수가 양수면 소수자리를 반올림하고, 음수면 정수자리를 반올림 한다 
 
 - TRUNC(값), TRUNC(값, 자리수) : 버림 함수. 절삭
 
 SELECT TRUNC(4567.678), TRUNC(4567.678, 0), TRUNC(4567.678, 2), TRUNC(4567.678, -2)
 FROM DUAL;
 
 
 - MOD(값1, 값2) : 값1을 값2로 나눈 나머지값을 반환하는 함수
 SELECT MOD(100, 3) FROM DUAL;
 
 --------
 --[1] MEMBER테이블에서 고객 이름과,마일리지,나이를 출력하고, 마일리지를 나이로 나눈 값을 반올림하여 출력하세요
 SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE) FROM MEMBER;
--
--[2] 상품 테이블의 상품 정보가운데 백원단위까지 버린 배송비를 비교하여 출력하세요.
SELECT PRODUCTS_NAME, TRANS_COST, ROUND(TRANS_COST, -3)
FROM PRODUCTS;
--
--[3] 사원테이블에서 부서번호가 10인 사원의 급여를 	30으로 나눈 나머지를 출력하세요.
SELECT DEPTNO, SAL, ENAME, ROUND(SAL/30), MOD(SAL, 30)
FROM EMP
WHERE DEPTNO=10;


- CEIL()    : 올림함수
- FLOOR()   : 내림함수
SELECT CEIL(12.001), FLOOR(12.001) FROM DUAL;

SELECT NAME, AGE, 40-AGE, ABS(40-AGE) "40살과의 나이 차이" FROM MEMBER;

----------------------------------------------
[3] 날짜형 함수
날짜 연산
SELECT SYSDATE, SYSDATE+3, SYSDATE-3 FROM DUAL;

DATE-DATE => 일수

ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';

SELECT TO_DATE('23/05/05', 'YY/MM/DD') - SYSDATE FROM DUAL;
-- CHAR - DATE

--지금시각에서 2시간 전과 2시간 후 시각을 출력하세요
--
--TO_CHAR(DATE,'포맷문자열')
--년:YY
--월:MM
--일:DD
--시:HH (12시간 기준), HH24 (24시간 기준)
--분:MI
--초:SS

SELECT TO_CHAR(SYSDATE,'YY/MM/DD HH:MI:SS'),
TO_CHAR(SYSDATE-2/24,'YY/MM/DD HH:MI:SS'), TO_CHAR(SYSDATE+2/24,'YY/MM/DD HH24:MI:SS') FROM DUAL;

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE,'CC YEAR-MON-D DAY') FROM DUAL;
--DDD -1년을 기준으로 한 날짜
--DD - 1달을 기준으로 한 날짜
--D - 1주일을 기준으로 한 날짜
-- DAY, DY: 요일정보
------------------------------------------
- MONTHS_BETWEEN(D1, D2) : 두날짜사이의 월수를 계산
- ADD_MONTHS(DATE,NUMBER) : 날짜에 NUMBER월 만큼 더한 날짜를 반환함
- LAST_DAY(DATE) : DATE월의 마지막 일을 반환

SELECT ABS(MONTHS_BETWEEN(SYSDATE,TO_DATE('23/12/24','YY/MM/DD'))) FROM DUAL; 

-- 오늘로부터 5달 뒤의 날짜를 출력하세요
SELECT SYSDATE, ADD_MONTHS(SYSDATE,5) "5달 뒤", ADD_MONTHS(SYSDATE,-5) "5달 전" FROM DUAL;

SELECT LAST_DAY(SYSDATE), LAST_DAY('23/02/01'),LAST_DAY('22/02/01'),
LAST_DAY('20/02/01'),LAST_DAY('24/02/01') FROM DUAL;

--사원테이블에서 현재까지의 근무 일수가 몇 주 몇일인가를 출력하세요.
--	단 근무일수가 많은 사람순으로 출려하세요.

SELECT ENAME,HIREDATE, TRUNC(SYSDATE -HIREDATE) "근무일수",
TRUNC((SYSDATE-HIREDATE)/365) "근속년수",
TRUNC((SYSDATE-HIREDATE)/7) WEEKS, 
TRUNC(MOD(SYSDATE-HIREDATE,7)) DAYS
FROM EMP 
ORDER BY 3;
------------------------------------------------------------------
[4] 변환형 함수
- TO_CHAR()
- TO_DATE()
- TO_NUMBER()

TO_CHAR(날짜,출력형식) : DATE유형을 문자열로 변환하는 함수
TO_CHAR(숫자,출력형식) : NUMBER유형을 문자열로 변환하는 함수

SELECT TO_CHAR(SYSDATE) FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH12:MI:SS') FROM DUAL;

SELECT TO_CHAR(25000,'999,999') FROM DUAL;
SELECT TO_CHAR(25000,'$999,999') FROM DUAL;


--1] 상품 테이블에서 상품의 공급 금액을 가격 표시 방법으로 표시하세요.
--	  천자리 마다 , 를 표시합니다.

SELECT PRODUCTS_NAME, INPUT_PRICE, TO_CHAR(INPUT_PRICE,'L9G999G999') "공급가격"
FROM PRODUCTS
ORDER BY 2;

--2] 상품 테이블에서 상품의 판매가를 출력하되 주화를 표시할 때 사용하는 방법을
--	  사용하여 출력하세요.[예: \10,000]      

SELECT PRODUCTS_NAME, OUTPUT_PRICE, TO_CHAR(OUTPUT_PRICE,'L9,999,999') "판매가격"
FROM PRODUCTS
ORDER BY 2;

SELECT TO_CHAR(TRANS_COST,'C09999.99') FROM PRODUCTS;

- TO_DATE(문자열,출력포맷): 문자열을 DATE유형으로 변환하는 함수

SELECT SYSDATE-TO_DATE('20220531','YYYYMMDD') FROM DUAL;


--고객테이블의 고객 정보 중 등록일자가 2013년 6월1일 이후 등록한 고객의 정보를
--	      보여 주세요
SELECT * FROM MEMBER
WHERE REG_DATE >TO_DATE('20130601','YYYYMMDD');

-- 고객테이블에 있는 고객 정보 중 등록연도가 2013년인 
--	 고객의 정보를 보여주세요.
SELECT NAME,REG_DATE FROM MEMBER
WHERE TO_CHAR(REG_DATE,'YYYY')='2013';
----------------------------------------------------
- TO_NUMBER(CHAR|VARCHAR2) : 문자열을 숫자로 변환하는 함수
- TO_NUMBER(변수,출력형식)

-- SELECT '\25,000' *5 FROM DUAL; --[X]

SELECT TO_NUMBER('$25,000','$99,999')*2  FROM DUAL;

--------------------------------------------------------
SELECT * FROM DEPT;
# 기타 함수
- DECODE(변수,값1,'출력값1',...): 변수값이 값1과 같으면 출력값1을 출력,...

SELECT ENAME, DEPTNO, 
    DECODE(DEPTNO,10,'회계부서(ACCOUNTING)',
            20,'연구부서(RESEARCH)',
            30,'영업부서(SALES)',
            '기타부서')
FROM EMP ORDER BY DEPTNO;



- RANK() OVER(분석절) : 분석절을 기준으로 랭킹을 매기는 함수

SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC;
-- FROM 절에서 사용된 별칭은 어디서든 참조 가능
-- SELECT 절에서 사용된 별칭은 SELECT 안에서만 사용 가능
SELECT * FROM (
SELECT ROW_NUMBER() OVER(ORDER BY HIREDATE) RNUM, EMP.*
FROM EMP)
WHERE RNUM BETWEEN 11 AND 20;

--------------------------------------------------------------
# 그룹함수
GROUP BY절과 함께 사용될 때가 많다
여러 행 또는 테이블 전체에 대해 함수가 적용되어 하나의 결과를 반환하는 함수
- COUNT() : 카운트 한 값을 반환 
- AVG() : 평균값 (NULL값을 제외함)
- SUM() : 합계값 (NULL값을 제외함)
- MAX() : 최대값
- MIN() : 최소값
- STDDEV() : 표준편차
- VARIANCE() : 분산 

SELECT COUNT(EMPNO) FROM EMP;

SELECT COUNT(MGR) FROM EMP; -- NULL값을 제외하고 카운팅을 함
--(KING은 MGR값이 NULL)

SELECT COUNT(DISTINCT MGR) FROM EMP;
--중복되지 않는 값만 반환

SELECT COUNT(*) FROM EMP;
--NULL값도 카운팅을 함

CREATE TABLE MYTAB(
    A NUMBER, 
    B NUMBER,
    C NUMBER
);
DESC MYTAB;

INSERT INTO MYTAB(A,B,C)
VALUES(NULL, NULL, NULL);
COMMIT;

SELECT * FROM MYTAB;

SELECT COUNT(A) FROM MYTAB;
-- => 0
SELECT COUNT(*) FROM MYTAB;
-- => 3

--[1] emp테이블에서 모든 SALESMAN에 대하여 급여의 평균,
--		 최고액,최저액,합계를 구하여 출력하세요.
SELECT AVG(SAL) AVG_SAL, MAX(SAL) MX_SAL, MIN(SAL) MN_SAL, SUM(SAL) SM_SAL
FROM EMP
WHERE JOB='SALESMAN';

--
--[2] EMP테이블에 등록되어 있는 인원수, 보너스에 NULL이 아닌 인원수,
--		보너스의 평균,등록되어 있는 부서의 수를 구하여 출력하세요.
SELECT COUNT(EMPNO), COUNT(COMM), AVG(COMM), COUNT(DISTINCT DEPTNO)
FROM EMP;

SELECT MIN(ENAME), MAX(ENAME), 
MIN(HIREDATE), MAX(HIREDATE),
MIN(SAL), MAX(SAL)
FROM EMP;

--------------------------------------------------------------
--GROUP BY: 특정 컬럼이나 값을 기준으로 레코드를 묶어서
--데이터를 관리할때 사용하는 문장. 그룹함수와 함께 사용함.
--
--SELECT 그룹바에서 사용된 컬럼명, 그룹함수
--FROM 테이블명
--GROUP BY 컬럼명;

--[1] 고객 테이블에서 직업의 종류와 각 직업에 속한 사람의 수를 보여주시오.
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
ORDER BY 2 ASC;

--         
--[2] 고객 테이블에서 직업의 종류, 각 직업에 속한 최대 마일리지 정보를 보여주세요.
SELECT JOB, MAX(MILEAGE)
FROM MEMBER
GROUP BY JOB;

--3] 상품 테이블에서 각 상품카테고리별로 총 몇 개의 상품이 있는지 보여주세요.
SELECT CATEGORY_FK, COUNT(*)
FROM PRODUCTS
GROUP BY CATEGORY_FK
ORDER BY 1;
--
--		또한 최대 판매가와 최소 판매가를 함께 보여주세요.
SELECT CATEGORY_FK, COUNT(*), MIN(OUTPUT_PRICE), MAX(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY CATEGORY_FK
ORDER BY 1;
--
--	4 상품 테이블에서 각 공급업체 코드별로 공급한 상품의 평균입고가를 보여주세요.
SELECT EP_CODE_FK, ROUND(AVG(INPUT_PRICE))
FROM PRODUCTS
GROUP BY EP_CODE_FK;
--	
--
--	5] 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도", COUNT(EMPNO)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY 1;
--	
--
--	6] 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년도", COUNT(EMPNO)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
ORDER BY 1;

--
--	7] 사원 테이블에서 업무별 최대 연봉, 최소 연봉을 출력하세요
SELECT JOB, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY JOB;

----------------------------------------------------------------
- HAVING절 
- GROUP BY와 항상 함께 사용하는 구문.
- GROUP BY 의 결과에 조건을 주어 제한할 때 사용한다.

SELECT JOB, COUNT(*)
FROM MEMBER
GROUP BY JOB
HAVING COUNT(*)>=2;
--
--1] 고객 테이블에서 직업의 종류와 각 직업에 속한 최대 마일리지 정보를 보여주세요.
--	      단, 직업군의 최대 마일리지가 0인 경우는 제외시킵시다.
SELECT JOB, MAX(MILEAGE)
FROM MEMBER
GROUP BY JOB
HAVING MAX(MILEAGE)<>0;
--
--
--	2] 상품 테이블에서 각 카테고리별로 상품을 묶은 경우, 해당 카테고리의 상품이 2개인 
--	      상품군의 정보를 보여주세요.
SELECT CATEGORY_FK, COUNT(*)
FROM PRODUCTS
GROUP BY CATEGORY_FK
HAVING COUNT(*)=2;
--	      
--
--	3] 상품 테이블에서 각 공급업체 코드별로 상품 판매가의 평균값 중 단위가 100단위로 떨어
--	      지는 항목의 정보를 보여주세요
SELECT EP_CODE_FK, AVG(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY EP_CODE_FK
HAVING MOD(AVG(OUTPUT_PRICE), 100)=0;
