
SELECT *
FROM USER_Views;

SELECT *
FROM ALL_Views
WHERE OWNER = 'PC06';

SELECT *
FROM pc06.v_emp_dept;

--PC06 �������� ��ȸ������  ���� v_emp_dept view�� hr �������� ��ȸ�ϱ�
--���ؼ��� ������.view�̸� �������� ����� �ؾ��Ѵ�.
-- �Ź� �������� ����ϱ� �������Ƿ� Syonoym�� ���� �ٸ� ��Ī�� ����

CREATE SYNONYM V_EMP_DEPT FOR PC06.V_EMP_DEPT;

SELECT *
FROM v_emp_dept;

--SYNONYM ����
DROP SYNONYM v_emp_dept;


--hr ������ ��й�ȣ : java
-- hr ������ ��й�ȣ ���� : hr
ALTER USER hr IDENTIFIED BY hr; 
ALTER USER PC06 IDENTIFIED BY java; 
-- ���� ������ �ƴ϶� ����

--dictionary
--���ξ� : USER : ����� ���� ��ü
--        ALL : ����ڰ� ��밡�� �� ��ü
--        DBA : ������ ������ ��ü ��ü(�Ϲ� ����ڴ� ��� �Ұ�)
--        V$ : �ý��۰� ���õ� view (�Ϲ� ����ڴ� ���Ұ�

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABlES
WHERE OWNER IN ('PC06', 'HR');

--����Ŭ���� ������ SQL�̶�?
--���ڰ� �ѱ��ڶ� Ʋ���� �ȵ�
--�ٸ� qul���� ��������� ������������ DBY����
SELECT /*bind_test */* FROM emp WHERE empno = 7369;
SELECT /*bind_test */* FROM emp WHERE empno = '7499';
Select /*bind_test */* FROM emp WHERE empno = '7521';
Select /*bind_test */* FROM emp WHERE empno = :empno;


SELECT *
FROM dictionary;
