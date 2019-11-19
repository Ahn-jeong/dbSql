CREATE TABLE emp_test as    
SELECT empno, ename
FROM emp;

--multiple insert�� ���� �׽�Ʈ ���̺� ����
-- empno, ename �ΰ��� �÷��� ���� emp_test, emp_test2 ���̺���
-- emp ���̺�κ��� �����Ѵ�

--�����ʹ� �������� �ʴ´�.

CREATE TABLE emp_test as    ;
CREATE TABLE emp_test2 as    
SELECT empno, ename
FROM emp
WHERE 1 = 2 ;

-- INSERT ALL
-- �ϳ��� INSERT SQL �������� ���� ���̺� �����͸� �Է�
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

--INSERT ALL �÷� ����
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
    ELSE -- ������ ������� ���ϸ� ����
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual
UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test2;

ROLLBACK;

--INSERT FIRST
--���ǿ� �����ϴ� ù��° INSERT ������ ����
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

-- MERGE : ���ǿ� �����ϴ� �����Ͱ� ������ UPDATE
--         ���ǿ� �����ϴ� �����Ͱ� ������ INSERT

--empno�� 7369�� �����͸� emp ���̺�� ���� ����(insert)
SELECT *
FROM emp_test;

INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno = 7369;

--emp ���̺��� �������� emp_test ���̺��� empno�� ���� ���� ���� �����Ͱ� �������
-- emp_teset.ename = ename || '_merge' ������ UPDATE
-- �����Ͱ� ���� ��쿡�� emp_test���̺� insert

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
    
-- �ٸ� ���̺��� ������ �ʰ� ���̺� ��ü�� ������ ���� ���Ƿ�
-- merge�ϴ� ���

-- empno = 1, ename = 'brown'
-- empno�� ���� ���� ������ ename�� 'brown'���� ������Ʈ
-- empno�� ���� ���� ������ �ű� insert

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
--group by �� ���� �׷��� ������
--group by rollup ( col1, col2, ...)
--�÷��� �����ʿ��� ���� �����ذ��鼭 ���� ����׷���
--group by �Ͽ� UNION  �� �Ͱ� ����
-- ex : group by rollup (job, deptno)
-- GROUP BY job, deptno
-- UNION
-- GROUP BY job
-- UNION
-- GROUP BY --> �Ѱ� (group by�� �������� �ʰ� ��� �࿡���� �׷��Լ� ����)

SELECT job, deptno, sum(sal)
FROM emp
GROUP BY ROLLUP(job, deptno);

SELECT deptno, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno);

--GROUPING SETS (COL1, COL2)
--GROUPING SETS�� ������ �׸��� �ϳ��� ����׷����� GROUP BY ���� �̿�ȴ�.
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

