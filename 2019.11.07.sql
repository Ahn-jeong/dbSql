--emp 테이블에는 부서번호(deptno)만 존재
--emp 테이블에서 부서명을 조회하기 위해서는
--dept 테이블과 조인을 통해 부서명 조회

--조인문법
--ANSI : 테이블 JOIN 테이블2 ON(테이블.COL = 테이블2.COL)
--       emp JOIN dept ON (emp.deptno = dept.deptno)
--ORACLE : FROM 테이블, 테이블2, WHERE 테이블.COL = 테이블2.COL
--         FROM emp, dept WHERE emp.deptno = dept.deptno

--사원번호, 사원명, 부서번호, 부서명
SELECT empno, ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT empno, ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal >2500
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp join dept on(emp.deptno = dept.deptno)
WHERE sal >2500
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal >2500
AND empno>7600
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp join dept on(emp.deptno = dept.deptno)
WHERE sal >2500
AND empno>7600
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND sal >2500
AND empno>7600
AND dname = 'RESEARCH'
ORDER by deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp join dept on(emp.deptno = dept.deptno)
WHERE sal >2500
AND empno>7600
AND dname = 'RESEARCH'
ORDER by deptno;


SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu
ORDER BY prod_id;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu)
ORDER BY prod_id;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id
ORDER BY prod_id;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id)
ORDER BY prod_id;


SELECT mem_id, mem_name, prod_name, cart_qty 
FROM member, cart, prod
WHERE mem_id = cart_member
and cart_prod = prod.prod_id
ORDER BY mem_id;

SELECT mem_id, mem_name, prod_name, cart_qty 
FROM member JOIN cart ON (mem_id = cart_member) 
            JOIN prod ON (cart_prod = prod_id)
ORDER BY mem_id;

SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND cnm IN('brown','sally');

SELECT customer.cid, cnm, pid, day, cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
WHERE cnm IN('brown','sally');


SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND cnm IN('brown','sally');

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
              JOIN product ON (cycle.pid = product.pid)
WHERE cnm IN('brown','sally');

--JOIN 6


SELECT a.cid, cnm, a.pid, pnm, a.cnt
FROM 
(
    SELECT CID, PID, SUM(cnt) cnt
    FROM cycle
    GROUP BY cid, pid
)a 
JOIN customer ON (customer.cid = a.CID)
JOIN product ON (a.pid = product.pid);

SELECT a.pid, pnm, a.cnt
FROM
(
    SELECT pid, SUM(cnt) cnt
    FROM cycle
    GROUP BY pid
)a 
JOIN product ON(a.pid = product.pid);

SELECT cycle.pid, pnm, SUM(cnt)
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, product.pnm;

