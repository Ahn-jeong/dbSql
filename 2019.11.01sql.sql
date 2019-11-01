--복습
--WHERE
--연산자
-- 비교 : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' (% : 다수의 문자열, _ : 정확히 한글자)
-- IS NULL ( != NULL )
-- AND, OR, NOT

--emp테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일까지 사이의 
--직원 정보조회

SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('19810601', 'YYYYMMDD') 
                  AND  TO_DATE('19861231', 'YYYYMMDD');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19810601', 'YYYYMMDD')
  AND hiredate <= TO_DATE('19861231', 'YYYYMMDD');
  
--emp 테이블에서 관리자(mgr)이 있는 직원만 조회

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

--order by 컬럼명 | 별칭 | 컬럼인덱스 [ASC | DSEC]
--emp테이블을 ename 기준으로 오름차순 정렬
--order by구문은 WHERE절 다음에 기술, 없을시 FROM절 다음에 기술
SELECT *
FROM emp
ORDER BY ename asc;

--ASC : defualt
--ASC를 안붙여도 위 쿼리와 동일한
SELECT *
FROM emp
ORDER BY ename;

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename DESC;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을경우 
--empno 오름차순 정렬
--SALESMAN -PRESIDENT -MANAGER -ANALYST
SELECT *
FROM emp
ORDER BY job DESC, empno;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
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

--emp 테이블에서 사번(empno), 이름(ename)을 급여기준으로 오름차순 정렬하고
--정렬된 결과순으로 ROWNUM

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
--DUAL 테이블 조회
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--문자열 대소문자 관련 함수
--LOWER, UPPER, INITCAP

SELECT LOWER('Hello World'), UPPER('Hello World'), INITCAP('Hello world')
FROM dual;

SELECT LOWER('Hello World'), UPPER('Hello World'), INITCAP('Hello world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--개발자 SQL 칠거지악
--1.좌변을 가공하지 말아라
--좌변(TABLE 의 컬럼)을 가공하게되면 INDEX룰 정상적으로 사용하지 못함
--Function Based Index -> FBI

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열 (java : String.substring)
--INSTR : 문자열에 특정 문자열이 등장하는 첫번 째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD'),
       SUBSTR('HELLO, WORLD', 0,5) substr,
       SUBSTR('HELLO, WORLD', 1,5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       LPAD('HELLO, WORLD', 15, '*') LPAD,--지정문자열의 길이보다 작을시 문자열의 좌측에 지정문자열을 삽입
       LPAD('HELLO, WORLD', 15) LPAD,
       LPAD('HELLO, WORLD', 15, ' ') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD
FROM dual;


