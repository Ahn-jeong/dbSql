SELECT *
FROM
(
SELECT deptno, ROUND(avg(sal),2) AS avg_sal
FROM emp
GROUP BY deptno
)
WHERE avg_sal > (SELECT ROUND(avg(sal),2)
                 FROM emp);

--쿼리 블럭을 WITH절에 선언하여
--쿼리를 간단하게 표현한다.
WITH dept_avg_sal AS(
    SELECT deptno, ROUND(avg(sal),2) AS d_avgsal
    FROM emp
    GROUP BY deptno
)
SELECT *
FROM dept_avg_sal
WHERE d_avgsal > (SELECT ROUND(AVG(sal),2) FROM emp);

--달력 만들기
--STEP1. 해당 년월의 일자 만들기
--CONNECT BY LEVEL 

SELECT decode(d, 1, a.iw+1, a.iw) iw,
        MAX(DECODE(D, 1, dt)) sun,
        MAX(DECODE(D, 2, dt)) mon,
        MAX(DECODE(D, 3, dt)) tue,
        MAX(DECODE(D, 4, dt)) wed,
        MAX(DECODE(D, 5, dt)) thu,
        MAX(DECODE(D, 6, dt)) fri,
        MAX(DECODE(D, 7, dt)) sat    
FROM 
(
    SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL -1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL -1),'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL -1),'d') d
    FROM dual a
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')
) a
GROUP BY decode(d, 1, a.iw+1, a.iw)
ORDER BY decode(d, 1, a.iw+1, a.iw);


create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;


SELECT NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),1,sum(sales))),0) jan,
       NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),2,sum(sales))),0) feb,
       NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),3,sum(sales))),0) mar,
       NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),4,sum(sales))),0) apr,
       NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),5,sum(sales))),0) may,
       NVL(MIN(DECODE(TO_CHAR(dt, 'MM'),6,sum(sales))),0) jun
FROM sales
GROUP BY TO_CHAR(dt, 'MM');

SELECT *
FROM emp;







create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;


--START WITH : 계층의 시작부분을 정의
--CONNECT BY : 계층간의 연결조건을 정의

--하향식 계층쿼리(가장 최상위 조지겡서부터 모든 조직을 탐색)
SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*4, ' ') || dept_h.deptnm deptnm
FROM dept_h
START WITH p_DEPTCD is null
CONNECT BY PRIOR DEPTCD = P_DEPTCD; --PRIOR 현재 읽은 데이터(XX회사)

--실습 h2
SELECT LEVEL, deptcd, LPAD(' ',(LEVEL-1)*4, ' ') || dept_h.deptnm deptnm, p_deptcd
FROM dept_h
START WITH DEPTCD = 'dept0_02'
CONNECT BY PRIOR DEPTCD = P_DEPTCD; 


