SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal)sal_rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal)d_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp;

--실습 ana1
SELECT empno, ename, sal, deptno,
       RANK() OVER (ORDER BY sal desc, empno) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal desc, empno) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal desc, empno) sal_row_rank
FROM emp;



--실습 no ana2
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

-- 분석함수를 통한 부서별 직원수
SELECT ename, empno, deptno,
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

SELECT ename, empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno) sum_sal
FROM emp;

--실습 ana2

SELECT empno, ename, sal, deptno, 
       ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) cnt
FROM emp;

--실습 ana3
SELECT empno, ename, sal, deptno, 
       MAX(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

--실습 ana4
SELECT empno, ename, sal, deptno, 
       MIN(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

--부서별 사원번호가 가장 빠른 사람
--부서별 사원본호가 가장 느린 사람
SELECT empno, ename, deptno,
       FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno),
       LAST_VALUE(empno) OVER (PARTITION BY deptno)
FROM emp;

--LAG (이전행)
--현재행
--LEAD (다음행)
--급여가 높은순으로 정렬 했을때 자기보다 한단계 급여가 낮은 사람의 금액
--급여가 높은순으로 정렬 했을때 자기보다 한단계 급여가 높은 사람의 금액

SELECT empno, ename, sal,
       LAG(sal) OVER (ORDER BY sal ) lag_sal,
       LEAD(sal) OVER (ORDER BY sal) lead_sal
FROM emp
ORDER BY sal desc;

-- 실습 ana5
SELECT empno, ename, sal,
       LEAD(sal) OVER (ORDER BY sal desc) lead_sal
FROM emp
ORDER BY sal desc;

--실습 ana6
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal desc, hiredate) lag_sal
FROM emp
ORDER BY job;

--실습 no ana3

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
--UNBOUNDED PRECEDING : 현재 행을 기준으로 이전의 모든행
--CURRENT ROW : 현재 행
--UNBOUNDED FOLLOWING : 현재 행을 기준을 이후의 모든행
--N(정수) PRECEDING : 현재 행을 기준으로 이전의 n개의 행
--N(정수) FOLLOWING : 현재 행을 기준으로 이후의 n개의 행

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




