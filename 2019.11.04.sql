
--job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ����� ��ȸ�϶�
-- �̰ų� --> OR
-- ���� --> �����ؼ�
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--ROWNUM ���� ����
--ORDER BY���� SELECT�� ���Ŀ� ����
--ROWNUM �����÷��� ����ǰ��� ���ĵǱ� ������
--�츮�� ���ϴ´�� ù��° �����ͺ��� �������� ��ȣ �ο��� ���� �ʴ´�.
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

--ORDER BY ���� ������ �ζ��� �並 ����
SELECT ROWNUM, a.*
FROM
    (SELECT e.*
    FROM emp e
    ORDER BY ename) a;

--ROWNUM : 1���� �о�� �Ѵ�
--WHERE : ROWNUM���� �߰��� �д°� �Ұ���
--�Ұ��� ���̽�
--WHERE = 2
--WHERE >= 2

--���� ���̽�
--WHERE = 1
--WHERE <= 10

-- ����¡ ó���� ���� �� ROWNUM�� ��Ī�� �ο�, �ش� SQL�� INLINE VIEW��
-- ���ΰ� ��Ī�� ���� ����¡ ó��
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT e.*
        FROM emp e
        ORDER BY ename) a)
WHERE rn = 2;

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ� (java : String.substring)
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù�� ° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD'),
       SUBSTR('HELLO, WORLD', 0,5) substr,
       SUBSTR('HELLO, WORLD', 1,5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       LPAD('HELLO, WORLD', 15, '*') LPAD,--�������ڿ��� ���̺��� ������ ���ڿ��� ������ �������ڿ��� ����
       LPAD('HELLO, WORLD', 15) LPAD,
       LPAD('HELLO, WORLD', 15, ' ') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD,
       --REPLACE(�������ڿ�, �������ڿ�, ���泻�빮�ڿ�)
       REPLACE('HELLO, WORLD', 'HELLO', 'hello') REPLACE,
       REPLACE(REPLACE('HELLO, WORLD', 'HELLO', 'hello'), 'WORLD', 'world') REPLACE,
       TRIM(' HELLO, WORLD ') trim,
       TRIM('H' FROM 'HELLO, WORLD')trim2
FROM dual;

--ROUND(������, �ݿø� ��� �ڸ���)
SELECT ROUND(105.54, 1) r1,-- �Ҽ��� ��° �ڸ����� �ݿø�
       ROUND(105.55, 1) r2,-- �Ҽ��� ��° �ڸ����� �ݿø�
       ROUND(105.55, 0) r3,-- �Ҽ��� ù° �ڸ����� �ݿø�
       ROUND(105.55, -1) r4 -- ���� ù° �ڸ����� �ݿø�
FROM dual;

SELECT empno, ename, sal, sal/1000, ROUND(sal/1000) qutient, MOD(sal,1000) reminder --0~999
FROM emp;

SELECT TRUNC(105.54, 1) T1,-- �Ҽ��� ��° �ڸ����� ����
       TRUNC(105.55, 1) T2,-- �Ҽ��� ��° �ڸ����� ����
       TRUNC(105.55, 0) T3,-- �Ҽ��� ù° �ڸ����� ����
       TRUNC(105.55, -1) T4 -- ���� ù° �ڸ����� ����
FROM dual;

-- SYSDATE : ����Ŭ�� ��ġ�� ������ ���� ��¥ + �ð������� ����
-- ������ ���ڰ� ���� �Լ�

--TO_CHAR : DATE Ÿ���� ���ڿ��� ��ȯ
--��¥�� ���ڿ��� ��ȯ�ÿ� ������ ����
SELECT TO_CHAR(SYSDATE + 5, 'YYYY/MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE + (1/24/60)*30, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') AS LASTDAY,
       TO_DATE('2019/12/31', 'YYYY/MM/DD')-5 AS LASTDAY_BEFORE5,
       SYSDATE AS NOW,
       SYSDATE - 3 AS NOW_BEFORE3
FROM dual;

SELECT LASTDAY, LASTDAY -5 AS LASTDAY_BEFORE5, NOW, NOW-3 AS NOW_BEFORE3
FROM
    (SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') AS LASTDAY,
            SYSDATE AS NOW
     FROM dual);

--date format
--�⵵ : YYYY, YY, RRRR, RR:���ڸ��϶��� 4�ڸ��϶��� �ٸ�
--YYYY, RRRR�� ����
--RR�� 50���� ������ 2000�⵵, ũ�� 1900�⵵�� �����
--������ ��������� ǥ��
-- D : ������ ���ڷ� ǥ�� (�Ͽ��� - 1 ....... ����� -7)
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r1,
       TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r2,
       TO_CHAR(TO_DATE('35/03/01', 'YY/MM/DD'), 'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d,-- ������ ������ - 2
       TO_CHAR(SYSDATE, 'IW') iw,
       TO_CHAR(TO_DATE('20191228', 'YYYYMMDD'), 'IW') this_year,
       TO_CHAR(TO_DATE('20191229', 'YYYYMMDD'), 'IW') this_year,
       TO_CHAR(TO_DATE('20191230', 'YYYYMMDD'), 'IW') this_year,
       TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'IW') this_year
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS DT_DD_MM_YYYY
FROM dual;

--��¥�� �ݿø�(ROUND), ����(TRUNC)
--ROUND(DATE, '����') YYYY, MM, DD
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') AS hiredate,
       TO_CHAR(ROUND(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as round_yyyy,
       TO_CHAR(ROUND(hiredate, 'mm'), 'YYYY/MM/DD HH24:MI:SS') as round_mm,
       TO_CHAR(ROUND(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as round_DD,
       TO_CHAR(ROUND(hiredate-2, 'mm'), 'YYYY/MM/DD HH24:MI:SS') as round_mm
FROM emp
WHERE ename = 'SMITH';

SELECT ename, 
       TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') AS hiredate,
       TO_CHAR(TRUNC(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as TRUNC_yyyy,
       TO_CHAR(TRUNC(hiredate, 'mm'), 'YYYY/MM/DD HH24:MI:SS') as TRUNC_mm,
       TO_CHAR(TRUNC(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as TRUNC_DD
FROM emp
WHERE ename = 'SMITH';

--��¥ ���� �Լ�
--MONTHS_BETWEEN (DATE, DATE) : �� ��¥ ������ ���� ��
SELECT ename, TO_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
       MONTHS_BETWEEN(TO_DATE('2019/11/17','YYYY/MM/DD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD-MONTH(DATE, ������) : DATE�� �������� ���� ��¥
SELECT ename, TO_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       ADD_MONTHS(hiredate, 467),
       ADD_MONTHS(hiredate, -467)
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, ����) : DATE ���� ù���� ������ ��¥
SELECT SYSDATE, NEXT_DAY(SYSDATE ,2) first_sat,
       NEXT_DAY(SYSDATE , '�����') first_sat
FROM dual;

--LAST_DAY(DATE)�ش� ��¥�� ���� ���� ������ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
       LAST_DAY(ADD_MONTHS(SYSDATE, 1)) LAST_DAY_12
FROM dual;

--DATE + ���� = DATE���� ������ŭ ������ DATE
--D1 + ���� = D2
--�纯���� D2�� ����
--D1 + ���� - D2 = D2 - D2
--D1 + ���� - D2 = 0
--D1 + ���� = D2
--�纯���� D1�� ����
--D1 + ���� - D1 = D2 -D1
--���� = D2 - D1
--��¥���� ��¥�� ���� ���ڰ� ���´�.

SELECT TO_DATE('20191104' , 'YYYYMMDD') - TO_DATE('20191101' , 'YYYYMMDD') D1,
       TO_DATE('20191201' , 'YYYYMMDD') - TO_DATE('20191101' , 'YYYYMMDD') D2,
       --201908 : 2019�� 8���� �ϼ� : 31
       ADD_MONTHS(TO_DATE('201602','YYYYMM'),1) - TO_DATE('201602','YYYYMM') D3
FROM dual;
       


