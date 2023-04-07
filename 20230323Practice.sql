
=================================
[문제]
	
	1] 사원테이블에서 급여가 3000이상인 사원의 정보를 모두 출력하세요.
    SELECT * FROM EMP WHERE SAL>=3000;

	2] 사원테이블에서 사번이 7788인 사원의 이름과 부서번호를 출력하세요
    SELECT ENAME, DEPTNO FROM EMP WHERE EMPNO=7788;

	3] 사원테이블이서 입사일이 1981 2월20일 ~ 1981 5월1일 사이에
        입사한 사원의 이름,업무 입사일을 출력하되, 입사일 순으로 출력하세요.
    SELECT ENAME, JOB, HIREDATE 
    FROM EMP 
    WHERE HIREDATE BETWEEN '1981-02-20' AND '1981-05-01' 
--    WHERE HIREDATE BETWEEN '81/02/20' AND '81/05/01' 
    ORDER BY HIREDATE ;
    
--ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';


	4] 사원테이블에서 부서번호가 10,20인 사원의 이름,부서번호,업무를 출력하되
	    이름 순으로 정렬하시오.
    SELECT ENAME, DEPTNO, JOB
    FROM EMP
    WHERE DEPTNO IN (10,20)
    ORDER BY ENAME;
	
	5] 사원테이블에서 1982년에 입사한 사원의 모든 정보를 출력하세요.
    SELECT * FROM EMP WHERE HIREDATE LIKE '1982%';
    
	6] 사원테이블에서 보너스가 급여보다 10%가 많은 사원의 이름,급여,보너스를 출력하세요.
    SELECT ENAME, SAL, COMM FROM EMP
    WHERE COMM >= SAL*1.1;
    
	7] 사원테이블에서 업무가 CLERK이거나 ANALYST이고 급여가 1000,3000,5000이 아닌 
        모든 사원의 정보를 출력하세요.
    SELECT * FROM EMP
    WHERE JOB IN ('CLERK', 'ANALYST') AND SAL NOT IN (1000, 3000, 5000);
        
	8] 사원테이블에서 이름에 L이 두자가 있고 부서가 30이거나
	    또는 관리자가 7782번인 사원의 정보를 출력하세요.
    SELECT * FROM EMP
    WHERE ENAME LIKE '%LL%' AND DEPTNO='30' OR MGR='7782';
        
	9] EMP테이블에서 급여가 1000이상 1500이하가 아닌 사원의 정보를 보여주세요
    SELECT * FROM EMP
    WHERE NOT(SAL>=1000 AND SAL<=1500);

    10] EMP테이블에서 이름에 'S'자가 들어가지 않은 사람의 이름을 모두 출력하세요.
    SELECT ENAME FROM EMP
    WHERE ENAME NOT LIKE '%S%';
    
    11] 사원테이블에서 업무가 PRESIDENT이고 급여가 1500이상이거나
	   업무가 SALESMAN인 사원의 사번,이름,업무,급여를 출력하세요.
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE JOB='PRESIDENT' AND SAL>=1500 OR JOB='SALESMAN';

	12] 고객 테이블에서 이름이 홍길동이면서 직업이 학생이 정보를 모두 보여주세요.
    SELECT * FROM MEMBER
    WHERE NAME='홍길동' AND JOB='학생';

	13] 고객 테이블에서 이름이 홍길동이거나 직업이 학생이 정보를 모두 보여주세요.
    SELECT * FROM MEMBER
    WHERE NAME='홍길동' OR JOB='학생';

	14] 상품 테이블에서 제조사가 S사 또는 D사이면서 
	   판매가가 100만원 미만의 상품 목록을 보여주세요.
    SELECT * FROM PRODUCTS
    WHERE COMPANY IN ('삼성', '대우') AND OUTPUT_PRICE<1000000;

--    SELECT * FROM PRODUCTS
--    WHERE (PRODUCTS_NAME LIKE '%S%' OR PRODUCTS_NAME LIKE '%D%') AND OUTPUT_PRICE<1000000;

	15] 상품 테이블에서 배송비의 내림차순으로 정렬하되, 
	    같은 배송비가 있는 경우에는 마일리지의 내림차순으로 정렬하여 보여주세요.
    SELECT *
    FROM PRODUCTS
    ORDER BY TRANS_COST DESC, MILEAGE DESC;

    16] DEPT테이블에서 컬럼의 첫 글자들만 대문자로 변환하여 모든 부서 정보를 출력하라.
    SELECT DEPTNO, INITCAP(DNAME), INITCAP(LOC) FROM DEPT;
    
    
    17]  상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 붙여서 출력하세요.
    SELECT PRODUCTS_NAME, CONCAT(OUTPUT_PRICE, '원') "판매가"
    FROM PRODUCTS;
    
         
    18]	 고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에 보여주세요.
    SELECT CONCAT(NAME, AGE)
    FROM MEMBER