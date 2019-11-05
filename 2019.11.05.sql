--��� �Ķ���Ͱ� �־����� �� �ش����� �ϼ��� ���ϴ� ����
-- 201911--> 30 / 201912 -> 31

--�Ѵ� ������ �������� ���� = �ϼ�
--��������¥ ������ --> DD�� ����
SELECT TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')),'DD') AS day_cnt
FROM dual;

SELECT :YYYYMM AS PARAM,TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD') AS DT
FROM dual;

desc emp;

explain plan for
SELECT *
FROM emp
WHERE empno = '7300' + 69;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT empno, ename, sal, TO_CHAR(sal, 'L0999,999.99') AS sal_fmt
FROM emp;

--function null
--nvl(col1, col1�� null�ϰ�� ��ü�� ��)
SELECT empno,ename,sal,comm, nvl(comm, 0) AS nvl_comm, sal + comm,
       sal + nvl(comm,0)
FROM emp;

-- NVL2(col1, col1�� null�� �ƴҰ�� ǥ���Ǵ°�, col1�� null�ϰ�� ǥ���Ǵ°�)

SELECT empno, ename, sal, comm, NVL2(comm,comm,0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 ������ null
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, expr3....)
--�Լ� ������ null�� �ƴ� ù��° ����
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, mgr, 
       NVL(mgr,9999) AS mgr_n,
       NVL2(mgr, mgr, 9999) AS mgr_n,
       COALESCE(mgr, 9999) AS mgr_n
FROM emp;

SELECT userid, usernm, reg_dt, nvl(reg_dt, sysdate) AS n_reg_dt
FROM users;

--case when
SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal * 1
       END case_sal
FROM emp;

--decode(col, search1, return1, search2, return2.....defult)
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal *1.05, 
                   'MANAGER', sal *1.10, 
                   'PRESIDENT', sal*1.20, 
                                sal) AS decode_sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal * 1
       END case_sal                         
FROM emp;

SELECT empno, ename,
       CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
       END  dname     
FROM emp;

SELECT empno, ename,
       DECODE(deptno,10, 'ACCOUNTING', 
                     20, 'RESEARCH', 
                     30, 'SALES',
                     40, 'OPERATIONS',
                                'DDIT') AS dname
FROM emp;                                

SELECT empno, ename, hiredate,
       CASE
            WHEN  MOD(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(hiredate,'YYYY'), 2) = 0 THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'      
       END CONTACT_TO_DOCTOR     
FROM emp;

--���ش� ¦���ΰ�? Ȧ���ΰ�?
-- 1. ���س⵵ ���ϱ� (DATE --> TO_CHAR(DATE, FORMAT))
-- 2. ���س⵵�� ¦������ ���
-- ����� 2�� ������ �������� �׻� 2���� �۴�
-- 2�� ������� �������� 0, 1

SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

-- emp���̺��� �Ի����ڰ� Ȧ�������� ¦�������� Ȯ��
SELECT empno, ename, hiredate, 
       CASE 
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) then '�ǰ����� �����'
            else '�ǰ����� ������'
       END  CONTACT_TO_DOCTOR
FROM emp;

SELECT userid, usernm, alias, reg_dt,
       CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2) then '�ǰ����� �����'
            else '�ǰ����� ������'
       END  CONTACT_TO_DOCTOR
FROM users
ORDER BY userid;

--�׷��Լ� ( AVG, MAX, MIN, SUM, COUNT)
--�׷��Լ��� NULL���� ����󿡼� �����Ѵ�.
--SUM(comm), COUNT(*), COUNT(mgr)�� ���� �ٸ���.
--������ ���� ���� �޿�
--������ ���� ���� �޿�
--������ �޿� ��� (�Ҽ��� ��° �ڸ�������)
--������ �޿� ��ü ��
--������ ��
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--�μ��� ���� ���� �޿��� �޴� ����� �޿�
--GROUP BY ���� ������� ���� �÷��� SELECT ���� ����� ��� ����
--���ڿ�, ����� ��� ����
SELECT deptno, 'test',MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp
GROUP BY DEPTNO;

--�μ��� �ִ�޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;


SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp;

SELECT deptno, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno;


SELECT CASE
            WHEN deptno = 10 then 'ACCOUNTING'
            WHEN deptno = 20 then 'RESEARCH'
            WHEN deptno = 30 then 'SALES'
       END dname,
       MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal) sum_sal,
       COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno
ORDER BY deptno;





