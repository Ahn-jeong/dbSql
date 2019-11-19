-- emp 테이블에 empno컬럼을 기준으로 PRIMARY KEY  생성
-- PRIMARY KEY = UNIQUE + NOT NULL
-- UNIQUE -> 해당 컬럼으로 UNIQUE INDEX 자동으로 생성
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

--empno 컬럼으로 인덱스가 존재하는 상황에서 
--다른컬럼 값으로 데이터를 조회하는 경우

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

--인덱스 구성 컬럼만 SELECT 절에 기술한경우
--테이블 접근이 필요 없다.
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--컬럼에 중복이 가능한 non-unique 인덱스 생성후
-- unique index와의 실행계획 비교
-- PRIMARY KEY 제약조건 삭제
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX IDX_emp_01 ON emp(empno);


EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp 테이블에 job 컬럼으로 두번째 인덱스 생성
-- job 컬럼은 다른 로우의 job컬럼과 중복이 가능한 컬럼이다.

CREATE INDEX idx_job_02 ON emp(job);

SELECT *
FROM emp;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE ('%C');

-- emp 테이블에 job, ename 컬럼을 기준으로 non-unique 인덱스 생성

CREATE INDEX idx_emp_03 ON emp(job, ename);
DROP INDEX idx_job_02;



EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE ('C%');

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE ('%C');

SELECT *
FROM TABLE(dbms_xplan.display);

--emp 테이블에 ename , job 컬럼으로 non-unique인덱스 생성
CREATE INDEX idx_emp_04 ON emp(ename, job);


EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--HINT를 사용한 실행계획 제어
EXPLAIN PLAN FOR
SELECT /*+ INDEX (emp idx_emp_04) */ *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE TABLE dept_test AS
SELECT *
FROM dept 
WHERE 1 = 1;

CREATE UNIQUE INDEX idx_dept_test_01 ON dept_test(deptno);
DROP INDEX idx_dept_test_01;
CREATE INDEX idx_dept_test_02 ON dept_test(dname);
DROP INDEX idx_dept_test_02;
CREATE INDEX idx_dept_test_03 ON dept_test(deptno,dname);
DROP INDEX idx_dept_test_03;

--INDEX 실습 3
CREATE INDEX idx_emp_t01 ON emp(ename);
CREATE INDEX idx_emp_t02 ON emp(deptno);
CREATE INDEX idx_emp_t03 ON emp(deptno,ename);
CREATE INDEX idx_emp_t04 ON emp(mgr, deptno);

