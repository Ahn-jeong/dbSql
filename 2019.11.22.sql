SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd
ORDER BY LEVEL desc;

------------------------------------------------------------
create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT *
FROM h_sum;

--실습 h4
SELECT lpad(' ', (LEVEL - 1) *4, ' ') || s_id s_id, VALUE
FROM h_sum
START WITH ps_id IS NULL
CONNECT BY PRIOR s_id = ps_id;

--실습 h5
create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;

SELECT *
FROM no_emp;

SELECT lpad(' ', (level-1)*4, ' ') || org_cd org_cd, no_emp
FROM no_emp+`

START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch (가지치기)
--계층쿼리에서 [WHERE]절은 START WITH, CONNECT BY 절이 전부 적용된 이후에
--실행된다

--dept_h테이블을 최상위 노드 부터 하향식으로 조회
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--계층쿼리가 완성된 이후 WHERE 절이 적용된다.
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--계층쿼리가 완성되기전 WHERE 절이 적용된다.
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '정보기획부';

--CONNECT_BY_ROOT(col) : col의 최상위 노드 컬럼 값
--SYS_CONNECT_BY_PATH(col, 구분자) : 계층 구조의 경로를 구분자로 나타냄
--  ㄴ  LTRIM(col, 제거할구분자)을 통해 최상위 노드 왼쪽의 구분자를 제거
--CONNECT_BY_ISLEAF : 현재 행이 마지막 노드이면 1, 아니면 0을 리턴
SELECT LPAD(' ', (LEVEL -1)*4, ' ') || org_cd org_cd,
       CONNECT_BY_ROOT(org_cd) root_org_cd,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '->'), '->')path_org_cd,
       CONNECT_BY_ISLEAF ISLEAF
FROM no_emp
START WITH org_cd ='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;



create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;

SELECT *
FROM board_test;

--실습 h6
SELECT seq, lpad(' ', (LEVEL -1)*4, ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--실습 h8
SELECT seq, lpad(' ', (LEVEL -1)*4, ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq desc;

--실습 h9
SELECT *
FROM board_test;


SELECT lpad(' ', (LEVEL -1)*4, ' ') || title title,
       CASE WHEN parent_seq is null THEN seq END x
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY x desc;

SELECT *
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn desc, seq;

------------------------------------


SELECT b.ename, b.sal, b.deptno, d.sal
FROM
(
    SELECT ename,sal ,deptno, ROWNUM rk
    FROM
    (
        SELECT ename, sal, deptno
        FROM emp
        ORDER BY sal desc
    )
)b    
,
(
    SELECT ename,sal ,deptno, ROWNUM rk
    FROM
    (
        SELECT ename, sal, deptno
        FROM emp
        ORDER BY sal desc
    )
)d
WHERE b.rk = d.rk(+) -1;




