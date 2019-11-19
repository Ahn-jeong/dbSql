SELECT *
FROM fastfood;

SELECT  a.sido, a.sigungu, kmb, 롯데리아 , ROUND(kmb / 롯데리아, 2) 도시발전지수
FROM(
SELECT sido, sigungu, count(*) AS kmb
FROM fastfood 
WHERE gb IN ('버거킹', '맥도날드', 'KFC')
GROUP BY SIDO, sigungu
) a,
(
SELECT sido, sigungu, count(*) 롯데리아
FROM fastfood 
WHERE gb = '롯데리아'
GROUP BY sido, sigungu
)b
WHERE a.sido =  b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 desc;

SELECT sido, sigungu, sal
FROM tax
ORDER BY sal desc;

-- 시도 시군구 버거지수, 시도 시군구 연말정산 납입액
SELECT r1, x.sido, x.sigungu, x.도시발전지수, y.r2, y.sido, y.sigungu, y.sal
FROM (
    SELECT ROWNUM r1, c.*
    FROM(
    SELECT a.sido, a.sigungu, kmb, 롯데리아 , ROUND(kmb / 롯데리아, 2) 도시발전지수
    FROM(
        SELECT sido, sigungu, count(*) AS kmb
        FROM fastfood 
        WHERE gb IN ('버거킹', '맥도날드', 'KFC')
        GROUP BY SIDO, sigungu
        ) a,
        (
        SELECT sido, sigungu, count(*) 롯데리아
        FROM fastfood 
        WHERE gb = '롯데리아'
        GROUP BY sido, sigungu
        )b
        WHERE a.sido =  b.sido
        AND a.sigungu = b.sigungu
        ORDER BY 도시발전지수 desc
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
            --140건
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('KFC', '버거킹', '맥도날드')
            GROUP BY SIDO, SIGUNGU) a,
            
            --188건
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('롯데리아')
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
   