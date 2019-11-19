CREATE TABLE emp_test as    
SELECT empno, ename
FROM emp;

--multiple insert를 위한 테스트 테이블 생성
-- empno, ename 두개의 컬럼을 갖는 emp_test, emp_test2 테이블을
-- emp 테이블로부터 생성한다

--데이터는 복제하지 않는다.

CREATE TABLE emp_test as    ;
CREATE TABLE emp_test2 as    
SELECT empno, ename
FROM emp
WHERE 1 = 2 ;

-- INSERT ALL
-- 하나의 INSERT SQL 문장으로 여러 테이블에 데이터를 입력
INSERT ALL 
    INTO emp_test
    INTO emp_test2
SELECT 1, 'brown' FROM dual
UNION ALL
SELECT 2, 'sally' FROM dual;


SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--INSERT ALL 컬럼 정의
ROLLBACK;

INSERT ALL
    INTO emp_test (empno) VALUES (empno)
    INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual
UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;


--multiple insert (conditional insert)
INSERT ALL
    WHEN empno > 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE -- 조건을 통과하지 못하면 실행
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual
UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test2;

ROLLBACK;

--INSERT FIRST
--조건에 만족하는 첫번째 INSERT 구문만 실행
INSERT FIRST
    WHEN empno > 10 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno > 5 THEN 
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual
UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

-- MERGE : 조건에 만족하는 데이터가 있으면 UPDATE
--         조건에 만족하는 데이터가 없으면 INSERT

--empno가 7369인 데이터를 emp 테이블로 부터 복사(insert)
SELECT *
FROM emp_test;

INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno = 7369;

--emp 테이블의 데이터중 emp_test 테이블의 empno와 같은 값을 갖는 데이터가 있을경우
-- emp_teset.ename = ename || '_merge' 값으로 UPDATE
-- 데이터가 없을 경우에는 emp_test테이블에 insert

MERGE INTO emp_test
USING (SELECT empno, ename
        FROM emp
        WHERE empno IN (7369, 7499)) emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN 
    UPDATE SET ename = emp.ename || '_merge'
WHEN NOT MATCHED THEN
    INSERT VALUES(emp.empno, emp.ename);
    
SELECT *
FROM emp_test;
    
-- 다른 테이블을 통하지 않고 테이블 자체의 데이터 존재 유므로
-- merge하는 경우

-- empno = 1, ename = 'brown'
-- empno가 같은 값이 있으면 ename을 'brown'으로 업데이트
-- empno가 같은 값이 없으면 신규 insert

MERGE INTO emp_test
USING dual
ON (emp_test.empno = 1)
WHEN MATCHED THEN 
UPDATE SET ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN 
INSERT VALUES (1, 'brown');

SELECT *
FROM emp_test;





SELECT deptno, sum(sal) sal
FROM emp
GROUP BY deptno
UNION all
SELECT null, sum(sal) sal
FROM emp
ORDER BY deptno;


--rollup
--group by 의 서브 그룹을 생성함
--group by rollup ( col1, col2, ...)
--컬럼을 오른쪽에서 부터 제거해가면서 나온 서브그룹을
--group by 하여 UNION  한 것과 동일
-- ex : group by rollup (job, deptno)
-- GROUP BY job, deptno
-- UNION
-- GROUP BY job
-- UNION
-- GROUP BY --> 총계 (group by를 적용하지 않고 모든 행에대해 그룹함수 적용)

SELECT job, deptno, sum(sal)
FROM emp
GROUP BY ROLLUP(job, deptno);

SELECT deptno, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno);

--GROUPING SETS (COL1, COL2)
--GROUPING SETS의 나열된 항목이 하나의 서브그룹으로 GROUP BY 절에 이용된다.
--GROUP BY COL1
--UNION ALL
--GROUP BY COL2
SELECT null deptno, job , sum(sal)
FROM emp
GROUP BY job

UNION ALL

SELECT deptno, null job, sum(sal)
FROM emp
GROUP BY deptno;
------------------------------------
SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

