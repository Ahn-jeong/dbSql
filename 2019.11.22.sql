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

--�ǽ� h4
SELECT lpad(' ', (LEVEL - 1) *4, ' ') || s_id s_id, VALUE
FROM h_sum
START WITH ps_id IS NULL
CONNECT BY PRIOR s_id = ps_id;

--�ǽ� h5
create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;

SELECT *
FROM no_emp;

SELECT lpad(' ', (level-1)*4, ' ') || org_cd org_cd, no_emp
FROM no_emp+`

START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch (����ġ��)
--������������ [WHERE]���� START WITH, CONNECT BY ���� ���� ����� ���Ŀ�
--����ȴ�

--dept_h���̺��� �ֻ��� ��� ���� ��������� ��ȸ
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--���������� �ϼ��� ���� WHERE ���� ����ȴ�.
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--���������� �ϼ��Ǳ��� WHERE ���� ����ȴ�.
SELECT deptcd, LPAD(' ', (LEVEL -1)*4, ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '������ȹ��';

--CONNECT_BY_ROOT(col) : col�� �ֻ��� ��� �÷� ��
--SYS_CONNECT_BY_PATH(col, ������) : ���� ������ ��θ� �����ڷ� ��Ÿ��
--  ��  LTRIM(col, �����ұ�����)�� ���� �ֻ��� ��� ������ �����ڸ� ����
--CONNECT_BY_ISLEAF : ���� ���� ������ ����̸� 1, �ƴϸ� 0�� ����
SELECT LPAD(' ', (LEVEL -1)*4, ' ') || org_cd org_cd,
       CONNECT_BY_ROOT(org_cd) root_org_cd,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '->'), '->')path_org_cd,
       CONNECT_BY_ISLEAF ISLEAF
FROM no_emp
START WITH org_cd ='XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;



create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;

SELECT *
FROM board_test;

--�ǽ� h6
SELECT seq, lpad(' ', (LEVEL -1)*4, ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--�ǽ� h8
SELECT seq, lpad(' ', (LEVEL -1)*4, ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq desc;

--�ǽ� h9
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




