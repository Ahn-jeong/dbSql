--조인 복습
--조인 왜???
--RDBMS의 특성상 데이터 중복을 최대 배제한 설계를 한다.
--EMP 테이블에는 직원의 정보가 존재, 해당 직원의 소속 부서정보는
--부서코드만 갖고있고 부서번호를 통해 dept테이블과 조인을 통해
--해당 부서의 정보를 가져올 수 있다.

--직원 번호, 직원이름, 직원의 소속 부서번호, 부서이름
--emp, dept
SELECT emp.empno, emp.ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--부서번호, 부서명, 해당부서의 인원수

SELECT emp.deptno, dname, COUNT(ename)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY emp.deptno, dname;

SELECT COUNT(*),COUNT(empno),COUNT(mgr),COUNT(comm)
FROM emp;

--OUTER JOIN : 조인에 실패해도 기준이 되는 테이블의 데이터는 조회결과가 
--             나오도록 하는 조인 형태
--LEFT OUTER JOIN : JOIN KEYWORD 왼쪽에 위치한 테이블이 조회 기준이 
--                  되도록 하는 조인 형태
--RIGHT OUTER JOIN : JOIN KEYWORD 오른쪽에 위치한 테이블이 조회 기준이 
--                  되도록 하는 조인 형태
--FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - 중복제거

--직원 정보와, 해당 직원의 관리자 정보outer join
--직원 번호, 직원이름, 관리자 번호, 관리자 이름

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno);

--orcle outer join (left, right만 존재 fullouter는 지원하지 않음)
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno;

-- ANSI LEFT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno AND b.deptno = 10);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno)
WHERE b.deptno = 10;

-- oracle outer 문법에서는 outer 테이블이 되는 모든 컬럼에 (+)를 붙여줘야
-- outer join이 정상적으로 동작한다
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+)= 10;

--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON (a.mgr = b.empno);

--outerjoin 1
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod  RIGHT OUTER JOIN PROD ON (buyprod.BUY_PROD = PROD.PROD_ID  AND buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD'));

SELECT NVL(BUY_DATE, TO_DATE('20050125','YYYYMMDD')) buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM PROD LEFT OUTER JOIN  buyprod ON (PROD.PROD_ID = buyprod.BUY_PROD AND buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD'));

SELECT NVL(BUY_DATE, TO_DATE('20050125','YYYYMMDD')) buy_date, buy_prod, prod_id, prod_name, nvl(buy_qty, 0) buy_qty
FROM PROD LEFT OUTER JOIN  buyprod ON (PROD.PROD_ID = buyprod.BUY_PROD AND buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD'));


--join 4
SELECT product.pid, pnm, nvl(cid,1) cid, nvl(day,0) day, nvl(cnt,0)
FROM cycle RIGHT OUTER join PRODUCT ON (cycle.pid = product.pid AND cycle.cid =1)
ORDER BY pid;

SELECT product.pid, pnm, nvl(cid,1) cid, nvl(day,0) day, nvl(cnt,0)
FROM cycle, PRODUCT 
WHERE cycle.pid(+) = product.pid
AND cycle.cid(+) =1
ORDER BY pid;


SELECT a.pid, a.pnm, a.cid, cnm, a.day, a.cnt
FROM
(
SELECT product.pid, pnm, nvl(cid,1) cid, nvl(day,0) day, nvl(cnt,0) cnt
FROM cycle RIGHT join PRODUCT ON (cycle.pid = product.pid AND cycle.cid =1)
)a JOIN customer ON (a.cid = customer.cid)
ORDER BY a.pid desc, day desc;

SELECT *
FROM customer CROSS JOIN product;


-- subquery : main쿼리에 속하는 부분 쿼리
-- 사용되는 위치 : 
-- SELECT - scalar subquery (하나의 행과, 하나의 컬럼만 조회되는 쿼리이어야 한다.)
-- FROM - inline view
-- WHERE - subquery

-- SCALRA subquery
SELECT empno, ename, (SELECT SYSDATE FROM dual) now /*현재날짜*/
FROM emp;


SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;


SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno =(SELECT deptno
             FROM emp
             WHERE ename = 'SMITH');

--sub1
SELECT count(*)
FROM emp
WHERE sal >=(SELECT ROUND(avg(sal),0)
             FROM emp
             );

--sub2
SELECT *
FROM emp
WHERE sal >=(SELECT ROUND(avg(sal),0)
             FROM emp
             );
   
-- sub3           
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
             FROM emp
             WHERE ename = 'SMITH'
             OR ename = 'WARD'
             );    




