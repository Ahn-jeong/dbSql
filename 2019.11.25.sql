--member 테이블을 이용하여 member2 테이블을 생성
--member2 테이블에서
--김은대 회원(mem_id = 'a001')의 직업(mem_job)을 '군인'으로 변경후
--commit 하고 조회

CREATE TABLE member2 AS
SELECT *
FROM member;

UPDATE member2 SET mem_job = '군인'
WHERE mem_id = 'a001';

commit;

SELECT mem_id, mem_name, mem_job
FROM member2;

--제품별 제품 구매수량(buy_qty)합계, 제품 구입 금액(buy_cost)합계
--제품코드, 제품명, 수량합계, 금액합계
SELECT buy_prod, prod_name, SUM(buy_qty) sum_qty, SUM(buy_cost) sum_cost
FROM buyprod, prod
WHERE buyprod.buy_prod = prod.prod_id
GROUP BY buy_prod, prod_name
ORDER BY buy_prod;
--VW_PROD_BUY(view 생성)
CREATE OR REPLACE VIEW VW_PROD_BUY AS
SELECT buy_prod, prod_name, SUM(buy_qty) sum_qty, SUM(buy_cost) sum_cost
FROM buyprod, prod
WHERE buyprod.buy_prod = prod.prod_id
GROUP BY buy_prod, prod_name
ORDER BY buy_prod;
SELECT *
FROM USER_VIEWS;






SELECT a.ename, a.sal, a.deptno, b.rn
FROM
(
    SELECT a.ename, a.sal, a.deptno, ROWNUM j_rn
    FROM
    (
        SELECT ename, sal, deptno
        FROM emp
        ORDER BY deptno, sal
    )a
)a,
(
    SELECT b.rn, ROWNUM j_rn
    FROM
    (
        SELECT *
        FROM
        (
            SELECT deptno, count(*) cnt
            FROM emp
            GROUP BY deptno
        )a,
        (
            SELECT ROWNUM rn -- 1 ~ 14
            FROM emp
        )b
        WHERE a.cnt >= b.rn
        ORDER BY deptno, rn
    )b
)b
WHERE a.j_rn = b.j_rn;



SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal ) rank
FROM emp
ORDER BY deptno, sal;







