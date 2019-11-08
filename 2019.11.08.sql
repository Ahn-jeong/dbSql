--���� ����
--���� ��???
--RDBMS�� Ư���� ������ �ߺ��� �ִ� ������ ���踦 �Ѵ�.
--EMP ���̺��� ������ ������ ����, �ش� ������ �Ҽ� �μ�������
--�μ��ڵ常 �����ְ� �μ���ȣ�� ���� dept���̺�� ������ ����
--�ش� �μ��� ������ ������ �� �ִ�.

--���� ��ȣ, �����̸�, ������ �Ҽ� �μ���ȣ, �μ��̸�
--emp, dept
SELECT emp.empno, emp.ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�μ���ȣ, �μ���, �ش�μ��� �ο���

SELECT emp.deptno, dname, COUNT(ename)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY emp.deptno, dname;

SELECT COUNT(*),COUNT(empno),COUNT(mgr),COUNT(comm)
FROM emp;

--OUTER JOIN : ���ο� �����ص� ������ �Ǵ� ���̺��� �����ʹ� ��ȸ����� 
--             �������� �ϴ� ���� ����
--LEFT OUTER JOIN : JOIN KEYWORD ���ʿ� ��ġ�� ���̺��� ��ȸ ������ 
--                  �ǵ��� �ϴ� ���� ����
--RIGHT OUTER JOIN : JOIN KEYWORD �����ʿ� ��ġ�� ���̺��� ��ȸ ������ 
--                  �ǵ��� �ϴ� ���� ����
--FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - �ߺ�����

--���� ������, �ش� ������ ������ ����outer join
--���� ��ȣ, �����̸�, ������ ��ȣ, ������ �̸�

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno);

--orcle outer join (left, right�� ���� fullouter�� �������� ����)
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

-- oracle outer ���������� outer ���̺��� �Ǵ� ��� �÷��� (+)�� �ٿ����
-- outer join�� ���������� �����Ѵ�
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


-- subquery : main������ ���ϴ� �κ� ����
-- ���Ǵ� ��ġ : 
-- SELECT - scalar subquery (�ϳ��� ���, �ϳ��� �÷��� ��ȸ�Ǵ� �����̾�� �Ѵ�.)
-- FROM - inline view
-- WHERE - subquery

-- SCALRA subquery
SELECT empno, ename, (SELECT SYSDATE FROM dual) now /*���糯¥*/
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




