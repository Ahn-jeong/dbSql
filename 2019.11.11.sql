--SMITH, WARD�� ���ϴ� �μ��� ������ ��ȸ

SELECT*
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM emp
    WHERE ename = 'SMITH'
    OR ename = 'WARD'
);

-- ANY : set �߿� �����ϴ°� �ϳ��� ������ ��(ũ���)
--SMITH, WARD�� �� ����� �޿����� ���� �޿��� �޴� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
               FROM emp
               WHERE ename = 'SMITH'
                  OR ename = 'WARD');

--SMITH, WARD �� ��� ���� �޿��� ���� ����
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
               FROM emp
               WHERE ename = 'SMITH'
                  OR ename = 'WARD');
                  
-- NOT IN
-- 1.�������� ��������
--  . mgr �÷��� ���� ������ ����
SELECT *
FROM emp
WHERE empno IN(SELECT mgr 
               FROM emp);
-- ������ ������ ���� �ʴ� ��� ���� ��ȸ
-- �� NOT IN ������ ���� SET�� NULL�� ���Ե� ��� ���������� �������� �ʴ´�.
-- NULLó�� �Լ��� WHERE ���� ���� NULL���� ó���� ���Ŀ� ���
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr 
               FROM emp
               WHERE mgr IS NOT NULL);       
               
--pair wise
--��� 7499, 7782�� ������ ������, �μ���ȣ ��ȸ
--�����߿� �����ڿ� �μ���ȣ�� 7698,30 �̰ų� (7839,10)�� ���
-- mgr, eptno �÷��� ���ÿ� ���� ��Ű�� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE (mgr, deptno) IN(SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));
         
SELECT *
FROM emp
WHERE mgr  IN(SELECT mgr
                        FROM emp
                        WHERE empno IN (7499,7782))
AND deptno IN (SELECT deptno
                FROM emp
                WHERE empno IN (7499,7782));

--SCALAR SUBQUERY : SELECT ���� �����ϴ� ���� ����(�� ���� �ϳ��� ��, �ϳ��� �÷�)
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno, (SELECT dname
                                FROM dept
                                WHERE deptno = emp.deptno) dname
FROM emp;


SELECT *
FROM dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--sub4
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                       FROM emp);
                       
-- sub5                       
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                       FROM cycle
                       WHERE cid = 1);                       
-- sub6                       
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid 
            FROM cycle
            WHERE cid = 2);
            
-- sub7
SELECT cycle.cid, cnm, cycle.pid, pnm, day, cnt
FROM cycle JOIN customer ON (cycle.cid = customer.cid)
           JOIN product  ON (cycle.pid = product.pid)
WHERE cycle.cid = 1
AND cycle.pid IN (SELECT pid 
                    FROM cycle
                    WHERE cid = 2);    
                    
-- EXISTS MAIN������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ
-- �����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������
-- ���ɸ鿡 ����

--MGR�� �����ϴ� ����                    
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
                FROM emp b
                WHERE b.empno = a.mgr);
                
--MGR�� �������� �ʴ� ����                    
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'x'
                FROM emp b
                WHERE b.empno = a.mgr);                

--sub8                
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

-- sub ����                    
SELECT *
FROM dept
WHERE EXISTS ( SELECT *
               FROM emp
               WHERE dept.deptno = emp.deptno);
                
SELECT *
FROM dept
WHERE deptno IN ( SELECT deptno
                  FROM emp);                    
--sub 9

SELECT *
FROM  product  
WHERE NOT EXISTS (SELECT *
                    FROM cycle
                    WHERE cid = 1
                    AND product.pid = cycle.pid);
                    
--���տ���
-- UNION : ������ �ߺ��� ����
--         DBMS������ �ߺ��� �����ϱ����� �����͸� ����
--         (�뷮�� ������ ���� ���Ľ� ����)
-- UNION ALL : UNION�� ��������
--             �ߺ��� �������� �ʰ�, �� �Ʒ� ������ ����
--             ���Ʒ� ���տ� �ߺ��Ǵ� �����Ͱ� ���ٴ� ���� Ȯ���ϸ�
--             UNION �����ں��� ���ɸ鿡�� ����


--����� 7566 �Ǵ� 7698�� ��� ��ȸ
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

--����� 7369 �Ǵ� 7499�� ��� ��ȸ
UNION

SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698;

--����� 7566 �Ǵ� 7698�� ��� ��ȸ
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

--����� 7369 �Ǵ� 7499�� ��� ��ȸ
UNION ALL

SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698;

--INTERSECT(������)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7499);

--MINUS(������ �� ���տ��� �Ʒ� ������ ����)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7499);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7499)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369);

SELECT 1 n, 'x' m
FROM dual
UNION
SELECT 2, 'y'
FROM dual
ORDER BY m desc;


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC06'
AND TABLE_NAME IN ('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P', 'R');










