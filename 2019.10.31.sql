-- ���̺��� ������ ��ȸ
/*
SELECT �÷� | express (���ڿ� ���) [as] ��Ī
FROM �����͸� ��ȸ�� ���̺�(VIEW)
WHERE ���� (condeition)

*/
DESC user_tables;

SELECT table_name, 'SELECT * FROM '  || table_name || ';' AS select_query
FROM user_tables
WHERE TABLE_NAME != 'EMP';

--���� �񱳿���
--�μ� ��ȣ�� 30������ ũ�ų� ���� �μ��� ���� ����
SELECT *
FROM emp
WHERE deptno >= 30;

--�μ���ȣ�� 30������ ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM dept;

SELECT *
FROM emp
WHERE deptno < 30;

--�Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate < TO_DATE('01011982', 'MMDDYYYY');
WHERE hiredate <= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate < TO_DATE('19820101', 'YYYYMMDD');

-- col BETWEEN X AND Y ����
-- �÷��� ���� X���� ũ�ų� ����, Y���� �۰ų� ���� ������
-- �޿�(sal)�� 1000���� ũ�ų� ����, Y���� �۰ų� ���� ������

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--���� BETWEEN AND �����ڴ� �Ʒ��� <=, >= ���հ� ����
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

-- IN ������
-- COL IN (values...)
-- �μ���ȣ�� 10 Ȥ�� 20�� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno IN (10,20);

--IN �����ڴ� OR �����ڷ� ǥ�� �� �� �ִ�.
SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 20;

SELECT userid AS ���̵�, usernm AS �̸�
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

-- COL LIKE 's%'
-- COL�� ���� �빮�� S�� �����ϴ� ��簪
-- COL LIKE 'S____'
-- COL�� ���� �빮�� S�� �����ϰ� �̾ 4���� ���ڿ��� �����ϴ� ��

--emp ���̺��� �����̸��� S�� �����ϴ� ��� ���� ��ȸ

SELECT *
FROM emp
WHERE ename LIKE('S%');

SELECT *
FROM emp
WHERE ename LIKE('S____');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('��%');

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%��%');

--NULL ��
-- COL IS NULL
-- EMP ���̺��� MGR ������ ���� ���(NULL) ȣ��
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE MGR != NULL; -- null�񱳰� �����Ѵ�.

--�Ҽ� �μ��� 10���� �ƴ� ������

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

-- emp ���̺��� ������(mgr) ����� 7698 �̰ų�
-- �޿�(sal)�� 1000 �̻��� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr = 7698
OR sal >= 1000;

-- emp ���̺��� ������(mgr) ����� 7698�� �ƴϰ�, 7839�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

-- ���� ������ AND/OR �����ڷ� ��ȯ
SELECT *
FROM emp
WHERE mgr != 7698 
AND mgr !=7839;

-- IN, NOT IN �������� NULL ó��
-- emp ���̺��� ������(mgr) ����� 7698, 7839 �Ǵ� null�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839, NULL);
--  IN �����ڿ��� ������� NULL�� ���� ��� �ǵ����� ���� ������ �Ѵ�.

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

