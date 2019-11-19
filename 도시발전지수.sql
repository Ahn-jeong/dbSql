SELECT *
FROM fastfood;

SELECT  a.sido, a.sigungu, kmb, �Ե����� , ROUND(kmb / �Ե�����, 2) ���ù�������
FROM(
SELECT sido, sigungu, count(*) AS kmb
FROM fastfood 
WHERE gb IN ('����ŷ', '�Ƶ�����', 'KFC')
GROUP BY SIDO, sigungu
) a,
(
SELECT sido, sigungu, count(*) �Ե�����
FROM fastfood 
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu
)b
WHERE a.sido =  b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� desc;

SELECT sido, sigungu, sal
FROM tax
ORDER BY sal desc;

-- �õ� �ñ��� ��������, �õ� �ñ��� �������� ���Ծ�
SELECT r1, x.sido, x.sigungu, x.���ù�������, y.r2, y.sido, y.sigungu, y.sal
FROM (
    SELECT ROWNUM r1, c.*
    FROM(
    SELECT a.sido, a.sigungu, kmb, �Ե����� , ROUND(kmb / �Ե�����, 2) ���ù�������
    FROM(
        SELECT sido, sigungu, count(*) AS kmb
        FROM fastfood 
        WHERE gb IN ('����ŷ', '�Ƶ�����', 'KFC')
        GROUP BY SIDO, sigungu
        ) a,
        (
        SELECT sido, sigungu, count(*) �Ե�����
        FROM fastfood 
        WHERE gb = '�Ե�����'
        GROUP BY sido, sigungu
        )b
        WHERE a.sido =  b.sido
        AND a.sigungu = b.sigungu
        ORDER BY ���ù������� desc
    )c
) x,
(
    SELECT ROWNUM r2, d.*
    FROM(
    SELECT sido, sigungu, sal
    FROM tax
    ORDER BY sal desc
    ) d
) y
WHERE x.r1(+)= y.r2
ORDER BY y.r2;

SELECT a.*, b.*
FROM 
    (SELECT a.*, ROWNUM RN 
     FROM
        (SELECT a.sido, a.sigungu, a.cnt kmb, b.cnt l,
               round(a.cnt/b.cnt, 2) point
        FROM 
            --140��
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
            GROUP BY SIDO, SIGUNGU) a,
            
            --188��
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('�Ե�����')
            GROUP BY SIDO, SIGUNGU) b
            WHERE a.sido = b.sido
            AND a.sigungu = b.sigungu
        ORDER BY point DESC )a ) a,
    
    (SELECT b.*, rownum rn
    FROM 
    (SELECT sido, sigungu
    FROM TAX
    ORDER BY sal DESC) b ) b
WHERE b.rn = a.rn(+)
ORDER BY b.rn;
   