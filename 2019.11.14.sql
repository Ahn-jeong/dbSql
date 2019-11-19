--�������� Ȱ��ȭ / ��Ȱ��ȭ
--� ���������� Ȱ��ȭ(��Ȱ��ȭ) ��ų ���??

--emp fk����(dept���̺��� deptno�÷�����)
--FK_EMP_DEPT ��Ȱ��ȭ
ALTER TABLE emp DISABLE CONSTRAINT fk_emp_dept;

--�������ǿ� ����Ǵ� �����Ͱ� ��� ���� ���� ������?

INSERT INTO emp (empno, ename, deptno)
VALUES (9999, 'brown', 80);

--FK_EMP_DEPT Ȱ��ȭ
ALTER TABLE emp ENABLE CONSTRAINT fk_emp_dept;
--�������ǿ� ����Ǵ� ������ (�Ҽ� �μ���ȣ�� 80���� ������)��
--�����Ͽ� �������� Ȱ��ȭ �Ұ�
DELETE emp
WHERE empno = 9999;
commit;

SELECT *
FROM emp;

--���� ������ �����ϴ� ���̺� ��� view : UWER_TABLES
--���� ������ �����ϴ� �������� view : USER_CONSTRAINTS
--���� ������ �����ϴ� ���������� �÷� view : USER_CONS_COLUMNS
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP';

--FK_EMP_DEPT
SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'CYCLE';

--���̺� ������ �������� ��ȸ (view����)
--���̺� ��/ �������� ��/ �÷���/ �÷�������
SELECT a.table_name, a.constraint_name, b.COLUMN_NAME, b.position
FROM user_constraints a, user_cons_columns b
WHERE a.constraint_name = b.constraint_name
AND a.constraint_type = 'P'
ORDER BY a.table_name, b.position; --PRIMARY KEY�� ��ȸ;


--emp ���̺�� 8���� �÷� �ּ��ޱ�
--empno ENAME JOB MGR HIREDATE SAL COMM DEPTNO

--���̺� �ּ� view : USER_TAB_COMMENTS

SELECT *
FROM USER_TAB_COMMENTS
WHERE table_name = 'EMP';

--emp ���̺� �ּ�
COMMENT ON TABLE emp IS '���';

--emp ���̺��� �÷� �ּ�
SELECT *
FROM user_col_comments
WHERE table_name = 'EMP';

--empno ENAME JOB MGR HIREDATE SAL COMM DEPTNO
COMMENT ON COLUMN emp.empno IS '�����ȣ';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '������ ���';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '��';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

--comment1

SELECT a.table_name , table_type, a.comments AS TAB_COMMENT, column_name, b.comments AS COL_COMMENT
FROM user_tab_comments a, user_col_comments  b
WHERE a.table_name = b.table_name
AND a.TABLE_NAME IN('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY'); 

SELECT *
FROM user_tab_comments;

SELECT *
FROM user_col_comments;


--VIEW ���� (emp���̺��� sal, comm�ΰ��� �÷��פ� ����)
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--INLINE VIEW
SELECT *
FROM ( SELECT empno,ename,job,mgr,hiredate,deptno FROM emp);

--VIEW

SELECT *
FROM v_emp;

--���ε� ���� ����� view�� ���� : v_emp_dept
--emp, dept : �μ���, �����ȣ, �����, ������, �Ի�����

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT a.dname, b.empno, b.ename, b.job, b.hiredate
FROM dept a, emp b
WHERE a.deptno = b.deptno;

SELECT *
FROM v_emp_dept;

-- VIEW ����
DROP VIEW v_emp;

--VIEW�� �����ϴ� ���̺��� �����͸� �����ϸ� VIEW���� ������ ����.

SELECT *
FROM dept;

UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno = 30;
ROLLBACK;

--HR �������� v_emp_dept view ��ȸ������ �ش�
GRANT SELECT ON v_emp_dept TO hr;

--SEQUENCE ���� (�Խñ� ��ȣ �ο��� ������)
CREATE SEQUENCE seq_post
INCREMENT BY 1
START WITH 1;

SELECT seq_post.nextval , seq_post.currval
FROM dual;

SELECT seq_post.currval
FROM dual;

--������ ����
--������ : �ߺ����� �ʴ� ���� ���� ���� ���ִ� ��ü
--1, 2, 3, ......

CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(15)
);

CREATE SEQUENCE seq_emp_test;

SELECT *
FROM emp_test;

INSERT INTO emp_test
VALUES (seq_emp_test.nextval, 'brown');


SELECT *
FROM post
WHERE reg_id = 'brown'
AND title = '�������� ����ִ�'
AND reg_dt = TO_DATE('2019/11/14 15:40:15', 'YYYY/MM/DD HH24:MI:SS');

SELECT *
FROM post
WHERE post_id = 1;

--index
--rowid : ���̺� ���� ������ �ּ�, �ش��ּҸ��˸�
-- ������ ���̺� �����ϴ� ���� �����ϴ�.
SELECT product.*, ROWID
FROM product
WHERE ROWID = 'AAAFC0AAFAAAAFOAAD';

--table : pid, pnm
--pk_product : pid
SELECT pid
FROM product;

--�����ȹ�� ���� �ε��� ��뿩�� Ȯ��
--emp ���̺� empno �÷��� �������� �ε����� ���� ��
ALTER TABLE emp DROP CONSTRAINT pk_emp;
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

--�ε����� ���� ������ empno�� 7369�� �����͸� ã�����ؼ� 
-- emp ���̺� ��ü�� ã�ƺ��� �Ѵ�. -> TABLE FULL SCAN

SELECT *
FROM TABLE(dbms_xplan.display);

SELECT *
FROM lprod;

ALTER TABLE lprod LOGGING;
