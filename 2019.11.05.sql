--년월 파라미터가 주어졌을 때 해당년월의 일수를 구하는 문제
-- 201911--> 30 / 201912 -> 31

--한달 더한후 원래값을 빼면 = 일수
--마지막날짜 구한후 --> DD만 추출
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
--nvl(col1, col1이 null일경우 대체할 값)
SELECT empno,ename,sal,comm, nvl(comm, 0) AS nvl_comm, sal + comm,
       sal + nvl(comm,0)
FROM emp;

-- NVL2(col1, col1이 null이 아닐경우 표현되는값, col1이 null일경우 표현되는값)

SELECT empno, ename, sal, comm, NVL2(comm,comm,0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 같으면 null
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, expr3....)
--함수 인자중 null이 아닌 첫번째 인자
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
            WHEN  MOD(TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(hiredate,'YYYY'), 2) = 0 THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'      
       END CONTACT_TO_DOCTOR     
FROM emp;

--올해는 짝수인가? 홀수인가?
-- 1. 올해년도 구하기 (DATE --> TO_CHAR(DATE, FORMAT))
-- 2. 올해년도가 짝수인지 계산
-- 어떤수를 2로 나누면 나머지는 항상 2보다 작다
-- 2로 나눌경우 나머지는 0, 1

SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

-- emp테이블에서 입사일자가 홀수년인지 짝수년인지 확인
SELECT empno, ename, hiredate, 
       CASE 
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) then '건강검진 대상자'
            else '건강검진 비대상자'
       END  CONTACT_TO_DOCTOR
FROM emp;

SELECT userid, usernm, alias, reg_dt,
       CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2) then '건강검진 대상자'
            else '건강검진 비대상자'
       END  CONTACT_TO_DOCTOR
FROM users
ORDER BY userid;

--그룹함수 ( AVG, MAX, MIN, SUM, COUNT)
--그룹함수는 NULL값을 계산대상에서 제외한다.
--SUM(comm), COUNT(*), COUNT(mgr)은 값이 다르다.
--직원중 가장 높은 급여
--직원중 가장 낮은 급여
--직원의 급여 평균 (소수점 둘째 자리까지만)
--직원의 급여 전체 합
--직원의 수
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--부서별 가장 높은 급여를 받는 사람의 급여
--GROUP BY 절에 기술되지 않은 컬럼이 SELECT 절에 기술될 경우 에러
--문자열, 상수는 기술 가능
SELECT deptno, 'test',MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp
GROUP BY DEPTNO;

--부서별 최대급여
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





