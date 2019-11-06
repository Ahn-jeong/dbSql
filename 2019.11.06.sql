--�׷��Լ�
--multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT ������ GROUP BY���� ����� COL, express�� ǥ�� ����

--������ ���� ���� �޿� ��ȸ
--14���� ���� �Է����� �� �ϳ��� ����� ����
SELECT MAX(sal) max_sal
FROM emp;

--�μ����� ���� ���� �޿� ��ȸ
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
--emp ���̺��� dname �÷��� ����
desc emp;

--emp���̺� �μ��̸��� ������ �� �ִ� dname�÷� �߰�
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

--ansi natural join : ���̺��� �÷����� ���� �÷��� �������� JOIN
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

--from ���� ���� ��� ���̺� ����
--where ���� �������� ���
--������ ����ϴ� ���� ���൵ ��� ����
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--job�� SALES�� ����� ������� ��ȸ

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND   emp.job = 'SALESMAN';

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.job = 'SALESMAN'
AND   emp.deptno = dept.deptno;

--JOIN with ON(�����ڰ� ���� �÷��� on���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--SELF join : ���� ���̺��� ����
--emp���̺��� mgr ������ �����ϱ� ���ؼ� emp ���̺�� ������ �ؾ��Ѵ�
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON(a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

--Oracle
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
AND a.empno BETWEEN 7369 AND 7698;

--non-equijoing (��� ������ �ƴѰ��)
SELECT *
FROM salgrade;

--������ �޿� �����???
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
