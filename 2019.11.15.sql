-- emp ���̺� empno�÷��� �������� PRIMARY KEY  ����
-- PRIMARY KEY = UNIQUE + NOT NULL
-- UNIQUE -> �ش� �÷����� UNIQUE INDEX �ڵ����� ����
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

--empno �÷����� �ε����� �����ϴ� ��Ȳ���� 
--�ٸ��÷� ������ �����͸� ��ȸ�ϴ� ���

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

--�ε��� ���� �÷��� SELECT ���� ����Ѱ��
--���̺� ������ �ʿ� ����.
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--�÷��� �ߺ��� ������ non-unique �ε��� ������
-- unique index���� �����ȹ ��
-- PRIMARY KEY �������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX IDX_emp_01 ON emp(empno);


EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp ���̺� job �÷����� �ι�° �ε��� ����
-- job �÷��� �ٸ� �ο��� job�÷��� �ߺ��� ������ �÷��̴�.

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

-- emp ���̺� job, ename �÷��� �������� non-unique �ε��� ����

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

--emp ���̺� ename , job �÷����� non-unique�ε��� ����
CREATE INDEX idx_emp_04 ON emp(ename, job);


EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--HINT�� ����� �����ȹ ����
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

--INDEX �ǽ� 3
CREATE INDEX idx_emp_t01 ON emp(ename);
CREATE INDEX idx_emp_t02 ON emp(deptno);
CREATE INDEX idx_emp_t03 ON emp(deptno,ename);
CREATE INDEX idx_emp_t04 ON emp(mgr, deptno);

