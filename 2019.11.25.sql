--member ���̺��� �̿��Ͽ� member2 ���̺��� ����
--member2 ���̺���
--������ ȸ��(mem_id = 'a001')�� ����(mem_job)�� '����'���� ������
--commit �ϰ� ��ȸ

CREATE TABLE member2 AS
SELECT *
FROM member;

UPDATE member2 SET mem_job = '����'
WHERE mem_id = 'a001';

commit;

SELECT mem_id, mem_name, mem_job
FROM member2;

--��ǰ�� ��ǰ ���ż���(buy_qty)�հ�, ��ǰ ���� �ݾ�(buy_cost)�հ�
--��ǰ�ڵ�, ��ǰ��, �����հ�, �ݾ��հ�
SELECT buy_prod, prod_name, SUM(buy_qty) sum_qty, SUM(buy_cost) sum_cost
FROM buyprod, prod
WHERE buyprod.buy_prod = prod.prod_id
GROUP BY buy_prod, prod_name
ORDER BY buy_prod;
--VW_PROD_BUY(view ����)
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







