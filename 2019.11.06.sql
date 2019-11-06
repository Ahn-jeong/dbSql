--그룹함수
--multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT 절에는 GROUP BY절에 기술된 COL, express만 표기 가능

--직원중 가장 높은 급여 조회
--14개의 행이 입력으로 들어가 하나의 결과가 도출
SELECT MAX(sal) max_sal
FROM emp;

--부서별로 가장 높은 급여 조회
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

SELECT CASE
            WHEN deptno = 10 then 'ACCOUNTING'
            WHEN deptno = 20 then 'RESEARCH'
            WHEN deptno = 30 then 'SALES'
            ELSE 'DDIT'
       END dname,
       MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY CASE
            WHEN deptno = 10 then 'ACCOUNTING'
            WHEN deptno = 20 then 'RESEARCH'
            WHEN deptno = 30 then 'SALES'
            ELSE 'DDIT'
         END
ORDER BY dname;

--


SELECT TO_CHAR(hiredate, 'YYYYMM') HIRE_YYYYMM, COUNT(hiredate)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

SELECT TO_CHAR(hiredate, 'YYYY') HIRE_YYYYMM, COUNT(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

SELECT COUNT(deptno) cnt
FROM dept;

--JOIN
--emp 테이블에는 dname 컬럼이 없다
desc emp;

--emp테이블에 부서이름을 저장할 수 있는 dname컬럼 추가
ALTER TABLE emp ADD (dname VARCHAR2(14));

UPDATE emp SET dname = 'ACCOUNTING' WHERE DEPTNO = 10;
UPDATE emp SET dname = 'RESEARCH' WHERE DEPTNO = 20;
UPDATE emp SET dname = 'SALES' WHERE DEPTNO = 30;
COMMIT;

SELECT *
FROM emp;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

ALTER TABLE emp DROP COLUMN dname;
COMMIT;

SELECT *
FROM emp;

--ansi natural join : 테이블의 컬럼명이 같은 컬럼을 기준으로 JOIN
SELECT deptno, ename, dname
FROM emp NATURAL JOIN dept;

--ORACLE JOIN
SELECT emp.empno, emp.ename, emp.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI JOING WHITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from 절에 조인 대상 테이블 나열
--where 절에 조인조건 기술
--기존에 사용하던 조건 제약도 기술 가능
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--job이 SALES인 사람만 대상으로 조회

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND   emp.job = 'SALESMAN';

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.job = 'SALESMAN'
AND   emp.deptno = dept.deptno;

--JOIN with ON(개발자가 조인 컬럼을 on절에 직접 기술)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--SELF join : 같은 테이블끼리 조인
--emp테이블의 mgr 정보를 참고하기 위해서 emp 테이블과 조인을 해야한다
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON(a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

--Oracle
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
AND a.empno BETWEEN 7369 AND 7698;

--non-equijoing (등식 조인이 아닌경우)
SELECT *
FROM salgrade;

--직원의 급여 등급은???
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE  emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp join salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr != b.empno
AND a.empno = 7369
ORDER BY b.empno;

SELECT empno, ename, deptno, dname
FROM emp NATURAL JOIN dept
ORDER BY deptno;

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369;

SELECT empno, ename, deptno, dname
FROM emp NATURAL JOIN dept
WHERE deptno IN(10,30);

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno IN(10,30);

SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING (deptno)
WHERE deptno IN(10,30);
