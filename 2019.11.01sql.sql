--����
--WHERE
--������
-- �� : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' (% : �ټ��� ���ڿ�, _ : ��Ȯ�� �ѱ���)
-- IS NULL ( != NULL )
-- AND, OR, NOT

--emp���̺��� �Ի����ڰ� 1981�� 6�� 1�Ϻ��� 1986�� 12�� 31�ϱ��� ������ 
--���� ������ȸ

SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('19810601', 'YYYYMMDD') 
                  AND  TO_DATE('19861231', 'YYYYMMDD');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19810601', 'YYYYMMDD')
  AND hiredate <= TO_DATE('19861231', 'YYYYMMDD');
  
--emp ���̺��� ������(mgr)�� �ִ� ������ ��ȸ

SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR  empno = 78
OR  empno BETWEEN 780 AND 789
OR  empno BETWEEN 7800 AND 7899;

SELECT * 
FROM emp
WHERE job = 'SALESMAN' 
OR (empno LIKE ('78%') AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));

--order by �÷��� | ��Ī | �÷��ε��� [ASC | DSEC]
--emp���̺��� ename �������� �������� ����
--order by������ WHERE�� ������ ���, ������ FROM�� ������ ���
SELECT *
FROM emp
ORDER BY ename asc;

--ASC : defualt
--ASC�� �Ⱥٿ��� �� ������ ������
SELECT *
FROM emp
ORDER BY ename;

--�̸�(ename)�� �������� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

--job�� �������� ������������ ����, ���� job�� ������� 
--empno �������� ����
--SALESMAN -PRESIDENT -MANAGER -ANALYST
SELECT *
FROM emp
ORDER BY job DESC, empno;

--��Ī���� �����ϱ�
--��� ��ȣ(empno), �����(ename), ����(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 4;

SELECT *
FROM dept
ORDER BY DNAME;

SELECT *
FROM dept
ORDER BY LOC DESC;

SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm desc, empno;

--orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

SELECT *
FROM emp
WHERE deptno IN(10,30) and sal > 1500
ORDER BY ename DESC;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2;

--emp ���̺��� ���(empno), �̸�(ename)�� �޿��������� �������� �����ϰ�
--���ĵ� ��������� ROWNUM

SELECT ROWNUM, empno, ename, sal
FROM emp
ORDER BY sal;

--row 1
SELECT ROWNUM , A.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) A
WHERE ROWNUM <=10;

SELECT *
FROM
    (SELECT ROWNUM rn, A.*
     FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal) A)
WHERE rn BETWEEN 11 AND 14;

--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--���ڿ� ��ҹ��� ���� �Լ�
--LOWER, UPPER, INITCAP

SELECT LOWER('Hello World'), UPPER('Hello World'), INITCAP('Hello world')
FROM dual;

SELECT LOWER('Hello World'), UPPER('Hello World'), INITCAP('Hello world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--������ SQL ĥ������
--1.�º��� �������� ���ƶ�
--�º�(TABLE �� �÷�)�� �����ϰԵǸ� INDEX�� ���������� ������� ����
--Function Based Index -> FBI

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ� (java : String.substring)
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù�� ° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD'),
       SUBSTR('HELLO, WORLD', 0,5) substr,
       SUBSTR('HELLO, WORLD', 1,5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       LPAD('HELLO, WORLD', 15, '*') LPAD,--�������ڿ��� ���̺��� ������ ���ڿ��� ������ �������ڿ��� ����
       LPAD('HELLO, WORLD', 15) LPAD,
       LPAD('HELLO, WORLD', 15, ' ') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD
FROM dual;


