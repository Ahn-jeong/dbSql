SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal)sal_rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal)d_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp;

--�ǽ� ana1
SELECT empno, ename, sal, deptno,
       RANK() OVER (ORDER BY sal desc, empno) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal desc, empno) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal desc, empno) sal_row_rank
FROM emp;



--�ǽ� no ana2
SELECT b.empno, b.ename, b.deptno, a.cnt
FROM
(
    SELECT deptno, COUNT(*) cnt
    FROM emp
    GROUP BY deptno
)a,
emp b
WHERE a.deptno = b.deptno
ORDER BY a.deptno;

-- �м��Լ��� ���� �μ��� ������
SELECT ename, empno, deptno,
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

SELECT ename, empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno) sum_sal
FROM emp;

--�ǽ� ana2

SELECT empno, ename, sal, deptno, 
       ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) cnt
FROM emp;

--�ǽ� ana3
SELECT empno, ename, sal, deptno, 
       MAX(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

--�ǽ� ana4
SELECT empno, ename, sal, deptno, 
       MIN(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

--�μ��� �����ȣ�� ���� ���� ���
--�μ��� �����ȣ�� ���� ���� ���
SELECT empno, ename, deptno,
       FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno),
       LAST_VALUE(empno) OVER (PARTITION BY deptno)
FROM emp;

--LAG (������)
--������
--LEAD (������)
--�޿��� ���������� ���� ������ �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �ݾ�
--�޿��� ���������� ���� ������ �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �ݾ�

SELECT empno, ename, sal,
       LAG(sal) OVER (ORDER BY sal ) lag_sal,
       LEAD(sal) OVER (ORDER BY sal) lead_sal
FROM emp
ORDER BY sal desc;

-- �ǽ� ana5
SELECT empno, ename, sal,
       LEAD(sal) OVER (ORDER BY sal desc) lead_sal
FROM emp
ORDER BY sal desc;

--�ǽ� ana6
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal desc, hiredate) lag_sal
FROM emp
ORDER BY job;

--�ǽ� no ana3

SELECT a.empno, a.ename, a.sal, sum(b.sal) c_cnt
FROM
(
    SELECT ROWNUM rn, a.*
    FROM
    (
        SELECT *
        FROM emp
        ORDER BY sal
    )a
)a
,
(
    SELECT ROWNUM rn, b.*
    FROM
    (
        SELECT *
        FROM emp
        ORDER BY sal
    )b
)b
WHERE a.rn >= b.rn
GROUP BY a.ename, a.empno, a.job, a.sal, a.rn
ORDER BY c_cnt;

--WINDOWING 
--UNBOUNDED PRECEDING : ���� ���� �������� ������ �����
--CURRENT ROW : ���� ��
--UNBOUNDED FOLLOWING : ���� ���� ������ ������ �����
--N(����) PRECEDING : ���� ���� �������� ������ n���� ��
--N(����) FOLLOWING : ���� ���� �������� ������ n���� ��

SELECT empno, ename, sal,
       SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal1,
       SUM(sal) OVER(ORDER BY sal ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) sum_sal2,
       SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sum_sal3
FROM emp;




SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal1
FROM emp;

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum,
       SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum1,
       
       SUM(sal) OVER(ORDER BY sal range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) range_sum,
       SUM(sal) OVER(ORDER BY sal range UNBOUNDED PRECEDING ) range_sum
       
FROM emp




