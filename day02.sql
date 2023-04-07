-- day02.sql

select * from dept;
select * from emp;

select deptno, dname, loc from dept;

select ename, job, sal, comm, sal*12+NVL(comm,0) as "연  봉" from emp;

SELECT ENAME, MGR, NVL2(MGR, '관리자 있음', '관리자 없음') "관리자 존재 여부" FROM EMP;

-- '||'
-- 문자열 결합 연산자

SELECT ENAME || ' IS A ' || JOB FROM EMP;

--문제] EMP테이블에서 이름과 연봉을 "KING: 1 YEAR SALARY = 60000" 형식으로 출력하라.
SELECT ENAME || ': 1 YEAR SALARY = ' || (SAL*12+NVL(COMM, 0)) AS "사원의 연봉" FROM EMP ORDER BY SAL DESC;

--# DISTINCT : 중복행 제거하고 1번만 보여줌
SELECT JOB FROM EMP;

--EMP에서 사원들이 담당하고 있는 업무의 종류를 보여주세요
SELECT DISTINCT JOB FROM EMP;

SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO ASC;

--2] MEMBER테이블에서 회원의 이름과 나이 직업을 보여주세요.
SELECT NAME, AGE, JOB FROM MEMBER;

--3] CATEGORY 테이블에 저장된 모든 내용을 보여주세요.
SELECT * FROM CATEGORY;

--4] MEMBER테이블에서 회원의 이름과 적립된 마일리지를 보여주되,
--	 마일리지에 13을 곱한 결과를 "MILE_UP"이라는 별칭으로 함께 보여주세요
SELECT NAME, MILEAGE, MILEAGE*13 MILE_UP FROM MEMBER;

--WHERE 절 : 조건절
SELECT * FROM EMP
WHERE SAL >= 3000;


--EMP테이블에서 담당업무가 MANAGER인 사원의
--	정보를 사원번호,이름,업무,급여,부서번호로 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO 
FROM EMP 
WHERE JOB = 'MANAGER';

--	EMP테이블에서 1982년 1월1일 이후에 입사한 사원의 
--	사원번호,성명,업무,급여,입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP
WHERE hiredate > '82/01/01';

--emp테이블에서 급여가 1300에서 1500사이의 사원의 이름,업무,급여,
--	부서번호를 출력하세요.
SELECT ENAME, JOB, SAL, DEPTNO 
FROM EMP 
WHERE sal BETWEEN 1300 AND 1500;
--WHERE sal >= 1300 AND SAL<=1500;
	
--	emp테이블에서 사원번호가 7902,7788,7566인 사원의 사원번호,
--	이름,업무,급여,입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE 
FROM EMP 
WHERE empno IN( 7902, 7788, 7566);
--WHERE EMPNO=7902 OR EMPNO=7788 OR EMPNO=7566;
	
--	10번 부서가 아닌 사원의 이름,업무,부서번호를 출력하세요
SELECT ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO != 10;
--WHERE DEPTNO <> 10;

---------
-- EMP테이블에서 이름이 S로 시작되는 사람의 정보를 보여주세요.
SELECT ENAME FROM EMP WHERE ENAME LIKE 'S%';

--이름 중 S자가 들어가는 사람의 정보를 보여주세요.
SELECT ENAME FROM EMP WHERE ENAME LIKE '%S%';

-- 이름의 두번 째에 O자가 들어가는 사람의 정보를 보여주세요.
SELECT ENAME FROM EMP WHERE ENAME LIKE '_O%';


--------
--	- 고객 테이블 가운데 성이 김씨인 사람의 정보를 보여주세요.
SELECT * FROM MEMBER WHERE NAME LIKE '김%';

--	- 고객 테이블 가운데 '강북구'가 포함된 정보를 보여주세요.
select * from member where addr like '%강북%';

--	- 카테고리 테이블 가운데 category_code가 0000로 끝나는 상품정보를 보여주세요.
select * from category where category_code like '%0000';

--82년도에 입사한 사원정보를 보여주세요
SELECT * FROM EMP WHERE HIREDATE LIKE '82%';


--------
--날짜 형식 바꿔보기
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--SELECT * FROM EMP WHERE HIREDATE LIKE '%82%';
SELECT * FROM EMP WHERE HIREDATE LIKE '1982%';


ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YY';
SELECT HIREDATE FROM EMP;


--COMM이 NULL인 사원의 이름, 업무, 급여, 보너스를 출력하세요
SELECT ENAME, JOB, SAL, COMM 
FROM EMP 
WHERE COMM IS NULL;

--NULL값은 EQUAL(=)로 비교하면 안된다
--IS NULL 로 비교해야 한다
--IS NOT NULL
--논리연산자
--AND
--OR
--NOT


--- EMP테이블에서 급여가 1100이상이고 JOB이 MANAGER인 사원의
--	사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP
WHERE sal>1100 AND job='MANAGER';

--	- EMP테이블에서 급여가 1100이상이거나 JOB이 MANAGER인 사원의
--	사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP
WHERE sal>1100 OR job='MANAGER';

	
--	- EMP테이블에서 JOB이 MANAGER,CLERK,ANALYST가 아닌
--	  사원의 사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP
WHERE JOB NOT IN ('MANAGER', 'CLERK', 'ANALYST');
--WHERE JOB != 'MANAGER' AND JOB <> 'CLERK' AND JOB != 'ANALYST';


----------------
--# ORDER BY 절
--오름차순 정렬: ASC(디폴트)
--내림차순 정렬: DESC
    -- WGHO순서
    
    
-- 	사원테이블에서 입사일자 순으로 정렬하여 사번,이름,업무,급여,
--	입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE 
FROM EMP ORDER BY HIREDATE;

SELECT EMPNO, ENAME, JOB, SAL, HIREDATE 
FROM EMP ORDER BY HIREDATE DESC;

SELECT EMPNO, ENAME, JOB, SAL, SAL*12 ANNSAL
FROM EMP
--ORDER BY SAL*12 ASC;
--ORDER BY ANNSAL DESC;
ORDER BY 5 ASC;


---------------
-- 사원 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우
--	급여가 많은 순으로 정렬하여 사번,이름,업무,부서번호,급여를
--	출력하세요.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL 
FROM EMP ORDER BY DEPTNO ASC, SAL DESC;

--	사원 테이블에서 첫번째 정렬은 부서번호로, 두번째 정렬은
--	업무로, 세번째 정렬은 급여가 많은 순으로 정렬하여
--	사번,이름,입사일자,부서번호,업무,급여를 출력하세요

SELECT EMPNO, ENAME, HIREDATE, DEPTNO, JOB, SAL 
FROM EMP ORDER BY DEPTNO, JOB, SAL DESC;



---------------
--1] 상품 테이블에서 판매 가격이 저렴한 순서대로 상품을 정렬해서 
--	    보여주세요.
SELECT * FROM products ORDER BY output_price;

--	2] 고객 테이블의 정보를 이름의 가나다 순으로 정렬해서 보여주세요.
--	      단, 이름이 같을 경우에는 나이가 많은 순서대로 보여주세요.
SELECT * FROM MEMBER ORDER BY name ASC, age DESC;

--3] 고객 테이블에서 직업의 종류와 각 직업에 속한 사람의 수가 많은 순서대로 보여주세요.
SELECT job, count(*)
FROM member
GROUP BY job
ORDER BY count(*) DESC;

--	 4]	상품테이블에서 공급업체별로 평균판매가를 구하되 
--		평균판매가 오름차순으로 보여주세요
SELECT EP_CODE_FK, ROUND(AVG(OUTPUT_PRICE))
FROM PRODUCTS
GROUP BY EP_CODE_FK
--ORDER BY ROUND(AVG(OUTPUT_PRICE)) ASC;
ORDER BY 2 ASC;
