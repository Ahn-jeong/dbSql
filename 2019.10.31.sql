-- 테이블에서 데이터 조회
/*
SELECT 컬럼 | express (문자열 상수) [as] 별칭
FROM 데이터를 조회할 테이블(VIEW)
WHERE 조건 (condeition)

*/
DESC user_tables;

SELECT table_name, 'SELECT * FROM '  || table_name || ';' AS select_query
FROM user_tables
WHERE TABLE_NAME != 'EMP';

--숫자 비교연산
--부서 번호가 30번보다 크거나 같은 부서에 속한 직원
SELECT *
FROM emp
WHERE deptno >= 30;

--부서번호가 30번보다 작은 부서에 속한 직원 조회
SELECT *
FROM dept;

SELECT *
FROM emp
WHERE deptno < 30;

--입사일자가 1982년 1월 1일 이후의 직원 조회
SELECT *
FROM emp
WHERE hiredate < TO_DATE('01011982', 'MMDDYYYY');
WHERE hiredate <= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate < TO_DATE('19820101', 'YYYYMMDD');

-- col BETWEEN X AND Y 연산
-- 컬럼의 값이 X보다 크거나 같고, Y보다 작거나 같은 데이터
-- 급여(sal)가 1000보다 크거나 같고, Y보다 작거나 같은 데이터

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000
AND deptno = 30;

SELECT ename, hiredate
FROM emp
WHERE  hiredate BETWEEN TO_DATE('19820101', 'YYYYMMDD') AND TO_DATE('19830101', 'YYYYMMDD');

SELECT ename, hiredate
FROM emp
WHERE  hiredate >= TO_DATE('19820101', 'YYYYMMDD') 
AND hiredate <= TO_DATE('19830101', 'YYYYMMDD');

-- IN 연산자
-- COL IN (values...)
-- 부서번호가 10 혹은 20인 직원 조회

SELECT *
FROM emp
WHERE deptno IN (10,20);

--IN 연산자는 OR 연산자로 표현 할 수 있다.
SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 20;

SELECT userid AS 아이디, usernm AS 이름
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

-- COL LIKE 's%'
-- COL의 값이 대문자 S로 시작하는 모든값
-- COL LIKE 'S____'
-- COL의 값이 대문자 S로 시작하고 이어서 4개의 문자열이 존재하는 값

--emp 테이블에서 직원이름이 S로 시작하는 모든 직원 조회

SELECT *
FROM emp
WHERE ename LIKE('S%');

SELECT *
FROM emp
WHERE ename LIKE('S____');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('신%');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%이%');

--NULL 비교
-- COL IS NULL
-- EMP 테이블에서 MGR 정보가 없는 사람(NULL) 호출
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE MGR != NULL; -- null비교가 실패한다.

--소속 부서가 10번이 아닌 직원들

SELECT *
FROM emp
WHERE deptno != '10';
--( = , !=)
-- in null, is not null

SELECT *
FROM emp
WHERE comm IS NOT NULL;

-- AND / OR
SELECT *
FROM emp
WHERE mgr = 7698
AND sal >= 1000;

-- emp 테이블에서 관리자(mgr) 사번이 7698 이거나
-- 급여(sal)가 1000 이상인 직원 조회
SELECT *
FROM emp
WHERE mgr = 7698
OR sal >= 1000;

-- emp 테이블에서 관리자(mgr) 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

-- 위의 쿼리를 AND/OR 연산자로 변환
SELECT *
FROM emp
WHERE mgr != 7698 
AND mgr !=7839;

-- IN, NOT IN 연산자의 NULL 처리
-- emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839, NULL);
--  IN 연산자에서 결과값에 NULL이 있을 경우 의도하지 않은 동작을 한다.

SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839)
AND mgr IS NOT NULL;

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno != 10
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno NOT IN(10)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN(20,30)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR  empno BETWEEN 7800 AND 7899;

