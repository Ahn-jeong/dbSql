
--job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 사람을 조회하라
-- 이거나 --> OR
-- 이후 --> 포함해서
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--ROWNUM 정렬 문제
--ORDER BY절은 SELECT절 이후에 동작
--ROWNUM 가상컬럼이 적용되고나서 정렬되기 때문에
--우리가 원하는대로 첫번째 데이터부터 순차적인 번호 부여가 되질 않는다.
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

--ORDER BY 절을 포함한 인라인 뷰를 구성
SELECT ROWNUM, a.*
FROM
    (SELECT e.*
    FROM emp e
    ORDER BY ename) a;

--ROWNUM : 1부터 읽어야 한다
--WHERE : ROWNUM값을 중간만 읽는건 불가능
--불가능 케이스
--WHERE = 2
--WHERE >= 2

--가능 케이스
--WHERE = 1
--WHERE <= 10

-- 페이징 처리를 위한 팁 ROWNUM에 별칭을 부여, 해당 SQL을 INLINE VIEW로
-- 감싸고 별칭을 통해 페이징 처리
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT e.*
        FROM emp e
        ORDER BY ename) a)
WHERE rn = 2;

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열 (java : String.substring)
--INSTR : 문자열에 특정 문자열이 등장하는 첫번 째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD'),
       SUBSTR('HELLO, WORLD', 0,5) substr,
       SUBSTR('HELLO, WORLD', 1,5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       LPAD('HELLO, WORLD', 15, '*') LPAD,--지정문자열의 길이보다 작을시 문자열의 좌측에 지정문자열을 삽입
       LPAD('HELLO, WORLD', 15) LPAD,
       LPAD('HELLO, WORLD', 15, ' ') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD,
       --REPLACE(원본문자열, 변경대상문자열, 변경내용문자열)
       REPLACE('HELLO, WORLD', 'HELLO', 'hello') REPLACE,
       REPLACE(REPLACE('HELLO, WORLD', 'HELLO', 'hello'), 'WORLD', 'world') REPLACE,
       TRIM(' HELLO, WORLD ') trim,
       TRIM('H' FROM 'HELLO, WORLD')trim2
FROM dual;

--ROUND(대상숫자, 반올림 결과 자리수)
SELECT ROUND(105.54, 1) r1,-- 소수점 둘째 자리에서 반올림
       ROUND(105.55, 1) r2,-- 소수점 둘째 자리에서 반올림
       ROUND(105.55, 0) r3,-- 소수점 첫째 자리에서 반올림
       ROUND(105.55, -1) r4 -- 정수 첫째 자리에서 반올림
FROM dual;

SELECT empno, ename, sal, sal/1000, ROUND(sal/1000) qutient, MOD(sal,1000) reminder --0~999
FROM emp;

SELECT TRUNC(105.54, 1) T1,-- 소수점 둘째 자리에서 절삭
       TRUNC(105.55, 1) T2,-- 소수점 둘째 자리에서 절삭
       TRUNC(105.55, 0) T3,-- 소수점 첫째 자리에서 절삭
       TRUNC(105.55, -1) T4 -- 정수 첫째 자리에서 절삭
FROM dual;

-- SYSDATE : 오라클이 설치된 서버의 현재 날짜 + 시간정보를 리턴
-- 별도의 인자가 없는 함수

--TO_CHAR : DATE 타입을 문자열로 변환
--날짜를 문자열로 변환시에 포맷을 지정
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
--년도 : YYYY, YY, RRRR, RR:두자리일때랑 4자리일때랑 다름
--YYYY, RRRR은 동일
--RR은 50보다 작으면 2000년도, 크면 1900년도로 출력함
--가급적 명시적으로 표현
-- D : 요일을 숫자로 표기 (일요일 - 1 ....... 토요일 -7)
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r1,
       TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'), 'YYYY/MM/DD') r2,
       TO_CHAR(TO_DATE('35/03/01', 'YY/MM/DD'), 'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d,-- 오늘은 월요일 - 2
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

--날짜의 반올림(ROUND), 절삭(TRUNC)
--ROUND(DATE, '포맷') YYYY, MM, DD
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

--날짜 연산 함수
--MONTHS_BETWEEN (DATE, DATE) : 두 날짜 사이의 개월 수
SELECT ename, TO_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
       MONTHS_BETWEEN(TO_DATE('2019/11/17','YYYY/MM/DD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD-MONTH(DATE, 개월수) : DATE에 개월수가 지난 날짜
SELECT ename, TO_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       ADD_MONTHS(hiredate, 467),
       ADD_MONTHS(hiredate, -467)
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, 요일) : DATE 이후 첫번쨰 요일의 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE ,2) first_sat,
       NEXT_DAY(SYSDATE , '토요일') first_sat
FROM dual;

--LAST_DAY(DATE)해당 날짜가 속한 월의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
       LAST_DAY(ADD_MONTHS(SYSDATE, 1)) LAST_DAY_12
FROM dual;

--DATE + 정수 = DATE에서 정수만큼 이후의 DATE
--D1 + 정수 = D2
--양변에서 D2를 차감
--D1 + 정수 - D2 = D2 - D2
--D1 + 정수 - D2 = 0
--D1 + 정수 = D2
--양변에서 D1를 차감
--D1 + 정수 - D1 = D2 -D1
--정수 = D2 - D1
--날짜에서 날짜를 빼면 일자가 나온다.

SELECT TO_DATE('20191104' , 'YYYYMMDD') - TO_DATE('20191101' , 'YYYYMMDD') D1,
       TO_DATE('20191201' , 'YYYYMMDD') - TO_DATE('20191101' , 'YYYYMMDD') D2,
       --201908 : 2019년 8월의 일수 : 31
       ADD_MONTHS(TO_DATE('201602','YYYYMM'),1) - TO_DATE('201602','YYYYMM') D3
FROM dual;
       


