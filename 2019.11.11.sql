--SMITH, WARD가 속하는 부서의 직원들 조회

SELECT*
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM emp
    WHERE ename = 'SMITH'
    OR ename = 'WARD'
);

-- ANY : set 중에 만족하는게 하나라도 있으면 참(크기비교)
--SMITH, WARD의 두 사람의 급여보다 적은 급여를 받는 직원 정보 조회

SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
               FROM emp
               WHERE ename = 'SMITH'
                  OR ename = 'WARD');

--SMITH, WARD 두 사람 보다 급여가 높은 직원
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
               FROM emp
               WHERE ename = 'SMITH'
                  OR ename = 'WARD');
                  
-- NOT IN
-- 1.관리자의 직원정보
--  . mgr 컬럼에 값이 나오는 직원
SELECT *
FROM emp
WHERE empno IN(SELECT mgr 
               FROM emp);
-- 관리자 역할을 하지 않는 사원 정보 조회
-- 단 NOT IN 연산자 사용시 SET에 NULL이 포함될 경우 정상적으로 동작하지 않는다.
-- NULL처리 함수나 WHERE 절을 통해 NULL값을 처리한 이후에 사용
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr 
               FROM emp
               WHERE mgr IS NOT NULL);       
               
--pair wise
--사번 7499, 7782인 직원의 관리자, 부서번호 조회
--직원중에 관리자와 부서번호가 7698,30 이거나 (7839,10)인 사람
-- mgr, eptno 컬럼을 동시에 만족 시키는 직원 정보 조회
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

--SCALAR SUBQUERY : SELECT 절에 등자하는 서브 쿼리(단 값이 하나의 행, 하나의 컬럼)
--직원의 소속 부서명을 JOIN을 사용하지 않고 조회
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
                    
-- EXISTS MAIN쿼리의 컬럼을 사용해서 SUBQUERY에 만족하는 조건이 있는지 체크
-- 만족하는 값이 하나라도 존재하면 더이상 진행하지 않고 멈추기 때문에
-- 성능면에 유리

--MGR이 존재하는 직원                    
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
                FROM emp b
                WHERE b.empno = a.mgr);
                
--MGR이 존재하지 않는 직원                    
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'x'
                FROM emp b
                WHERE b.empno = a.mgr);                

--sub8                
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

-- sub 문제                    
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
                    
--집합연산
-- UNION : 합집합 중복을 제거
--         DBMS에서는 중복을 제거하기위해 데이터를 정렬
--         (대량의 데어텡 대해 정렬시 부하)
-- UNION ALL : UNION과 같은개념
--             중복을 제거하지 않고, 위 아래 집합을 결합
--             위아래 집합에 중복되는 데이터가 없다는 것을 확신하면
--             UNION 연산자보다 성능면에서 유리


--사번이 7566 또는 7698인 사원 조회
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

--사번이 7369 또는 7499인 사원 조회
UNION

SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698;

--사번이 7566 또는 7698인 사원 조회
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

--사번이 7369 또는 7499인 사원 조회
UNION ALL

SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698;

--INTERSECT(교집합)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7499);

--MINUS(차집합 위 집합에서 아래 집합을 제거)

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










