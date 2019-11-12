
desc emp;

INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', null);

SELECT *
FROM emp
WHERE  empno = 9999;

rollback;

desc emp;

SELECT *
FROM USER_TAB_columns
WHERE table_name = 'EMP';

EMPNO
ENAME
JOB
MGR
HIREDATE
SAL
COMM
DEPTNO

INSERT INTO emp
VALUES (9999,'brown','ranger',null,SYSDATE,2500,null, 40);

SELECT *
FROM emp
WHERE empno = 9999;

INSERT INTO emp (empno, ename)
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE
-- UPDATE ���̺� SET �÷� =��, �÷� = ��....
-- WHERE condition

UPDATE dept SET dname = '���IT', loc ='ym'
WHERE deptno = 99;

SELECT *
FROM dept;

SELECT *
FROM emp;

-- DELETE ���̺��
-- WHERE condition
--�����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE emp 
WHERE empno = 9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5���� �����͸� ����
DELETE emp
WHERE empno < 100;

rollback;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

DELETE emp
WHERE deptno IN (SELECT deptno
                FROM dept);
commit;

--DDL : AUTO COMMINT , rollback�� �ȉ�.
--CREATE 
CREATE TABLE ranger_new(
--empno
    ranger_no NUMBER, -- ����
    ranger_name VARCHAR2(50), --���� : [VARCHAR2], CHAR
    reg_dt DATE default sysdate --DEFAULT : SYSDATE
);

SELECT *
FROM ranger_new;

--ddl�� rollback�� ������� �ʴ´�.
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');
commit;

--��¥ Ÿ�Կ��� Ư�� �ʵ� ��������
-- ex ;: sysdate���� �⵵�� ��������
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt,
       TO_CHAR(reg_dt, 'MM'),
       extract(YEAR FROM reg_dt)year,
       extract(MONTH FROM reg_dt)month,
       extract(DAY FROM reg_dt)day
FROM ranger_new;

--��������
--dept ����ؼ� dept_test����


CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY, --deptno �÷��� �ĺ��ڷ� ����
    dname varchar2(14),           -- �ĺ��ڷ� ������ �Ǹ� ���� �ߺ��� �� �� ���� null�� �ƴϴ�.
    loc varchar2(13)
);

desc dept_test;

-- primary key���� ���� Ȯ��
-- 1. null�� �� �� ����.
-- 2. deptno�÷��� �ߺ��� ���� �� �� ����.

INSERT INTO dept_test (deptno, dname, loc)
VALUES (NULL, 'ddit', 'daejeon');

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');

INSERT INTO dept_test
VALUES (1, 'ddit2', 'daejeon');

rollback;

-- ����� ���� �������Ǹ��� �ο��� primary key
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno   number(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname varchar2(14),
    loc   varchar2(13)
);

--TABLE CONSTRAINT 
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(13),
    loc   VARCHAR2(14),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test
VALUES (1, 'ddit2', 'daejeon');

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(13) NOT NULL,
    loc VARCHAR2(14)
);

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test
VALUES (2, null, 'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(13) UNIQUE,
    loc VARCHAR2(14)
);

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (2, 'ddit2', 'daejeon');
rollback;