--GROUPING (cube, rollup ���� ���� �÷�)
--�ش� �÷��� �Ұ� ��꿡 ���� ��� 1, 
--������ ���� ��� 0

--job�÷�
--case1. GROUPING(job) =1 AND GROUPING(deptno) =1
-- job -> '�Ѱ�'
--case else 
-- job -> job
--�ǽ� GROUP_AD 1, 2
SELECT CASE WHEN GROUPING(job)=1 and
                 GROUPING(deptno) = 1 THEN '�Ѱ�'
            ELSE job
        END job,
        CASE WHEN GROUPING(deptno) = 1 AND
                  GROUPING(job)=0  THEN job || '�Ұ�'
             ELSE  TO_CHAR(deptno)
        END deptno, 
        GROUPING(job), GROUPING(deptno), sum(sal)
FROM emp
GROUP BY ROLLUP(job, deptno);



--�ǽ� GROUP_AD3
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

--�ǽ� GROUP_AD4
SELECT dname, job, sum(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname,job desc;

--�ǽ� GROUP_AD5
SELECT CASE WHEN x = 1 THEN '����'
            ELSE dname
       END dname, job, sa
FROM(
SELECT dname,grouping(dname) x, job, sum(sal) sa
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname,job desc
);


--CUBE (col, col2....)
--CUBE ���� ������ �÷��� ������ ��� ���տ� ���� ���� �׷����� ����
--CUBE�� ������ �÷��� ���� ���⼺�� ����(rollup���� ����)
--GROUP BY CUBE (job, deptno)
--00 : GROUP BY job, detpno
--0x : GROUP BY job
--x0 : GROUP BY detpno
--xx : GROUP BY ��� ������

--GROUP BY CUBE (job, deptno, mgr)
SELECT job, deptno, sum(sal)
FROM emp
GROUP BY CUBE (job,deptno);

SELECT deptno, job, count(*)
FROM emp
GROUP BY (deptno, job)
ORDER BY deptno;


SELECT job, deptno, mgr, sum(sal)
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);


-- subquery�� ���� ������Ʈ
-- emp���̺��� �����͸� �����ؼ� ��� �÷��� �̿��Ͽ� emp_test���̺� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp
WHERE 1 = 1;

SELECT *
FROM emp_test;

--emp_test ���̺��� dept���̺��� �����ǰ� �ִ� dbame�÷��� �߰�
desc detp;
ALTER TABLE emp_test ADD dname VARCHAR2(14);

UPDATE emp_test 
SET dname = (SELECT dname
             FROM dept
             WHERE emp_test.deptno = dept.deptno);
             
SELECT *
FROM emp_test;             

commit;

CREATE table dept_test AS
SELECT *
FROM dept;

SELECT *
FROM dept_test;

ALTER TABLE dept_test ADD empcnt number(4);

UPDATE dept_test 
SET empcnt = (SELECT COUNT(*)
              FROM emp
              WHERE emp.deptno = dept_test.deptno);
        
        
           
SELECT *
FROM dept_test;    

INSERT INTO dept_test VALUES (98, 'ddit1', 'daejeon',0);
INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon',0);

DELETE dept_test
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);
                
DELETE dept_test
WHERE NOT EXISTS (SELECT *
                  FROM emp
                  WHERE deptno = dept_test.deptno);
SELECT *
FROM dept_test;

ROLLBACK;

UPDATE emp_test a
SET sal = sal + 200
WHERE sal < (SELECT avg(sal)
             FROM emp_test b
             WHERE a.deptno = b.deptno
        
             );
 
             
--emp, emp_test empno�÷����� ���������� ��ȸ
--emp.empno, emp.ename, emp.sal, emp_test.sal

SELECT emp.empno, emp.ename, emp.sal, emp_test.sal, emp.deptno,a.sal_avg
FROM emp, emp_test,
(
SELECT deptno, ROUND(avg(sal), 2) sal_avg
FROM emp
GROUP BY (deptno)
) a
WHERE emp.empno = emp_test.empno
AND emp.deptno = a.deptno;

