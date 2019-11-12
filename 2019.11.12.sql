
desc emp;

INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', null);

SELECT *
FROM emp
WHERE  empno = 9999;

rollback;

desc emp;

SELECT *
FROM USER_TAB_columns
WHERE table_name = 'EMP';

EMPNO
ENAME
JOB
MGR
HIREDATE
SAL
COMM
DEPTNO

INSERT INTO emp
VALUES (9999,'brown','ranger',null,SYSDATE,2500,null, 40);

SELECT *
FROM emp
WHERE empno = 9999;

INSERT INTO emp (empno, ename)
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE
-- UPDATE 테이블 SET 컬럼 =값, 컬럼 = 값....
-- WHERE condition

UPDATE dept SET dname = '대덕IT', loc ='ym'
WHERE deptno = 99;

SELECT *
FROM dept;

SELECT *
FROM emp;

-- DELETE 테이블명
-- WHERE condition
--사원번호가 9999인 직원을 emp 테이블에서 삭제
DELETE emp 
WHERE empno = 9999;

--부서테이블을 이용해서 emp 테이블에 입력한 5건의 데이터를 삭제
DELETE emp
WHERE empno < 100;

rollback;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

DELETE emp
WHERE deptno IN (SELECT deptno
                FROM dept);
commit;

--DDL : AUTO COMMINT , rollback이 안됌.
--CREATE 
CREATE TABLE ranger_new(
--empno
    ranger_no NUMBER, -- 숫자
    ranger_name VARCHAR2(50), --문자 : [VARCHAR2], CHAR
    reg_dt DATE default sysdate --DEFAULT : SYSDATE
);

SELECT *
FROM ranger_new;

--ddl은 rollback이 적용되지 않는다.
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');
commit;

--날짜 타입에서 특정 필드 가져오기
-- ex ;: sysdate에서 년도만 가져오기
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt,
       TO_CHAR(reg_dt, 'MM'),
       extract(YEAR FROM reg_dt)year,
       extract(MONTH FROM reg_dt)month,
       extract(DAY FROM reg_dt)day
FROM ranger_new;

--제약조건
--dept 모방해서 dept_test생성


CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY, --deptno 컬럼을 식별자로 지정
    dname varchar2(14),           -- 식별자로 지정이 되면 값이 중복이 될 수 없고 null이 아니다.
    loc varchar2(13)
);

desc dept_test;

-- primary key제약 조건 확인
-- 1. null이 들어갈 수 없다.
-- 2. deptno컬럼에 중복된 값이 들어갈 수 없다.

INSERT INTO dept_test (deptno, dname, loc)
VALUES (NULL, 'ddit', 'daejeon');

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');

INSERT INTO dept_test
VALUES (1, 'ddit2', 'daejeon');

rollback;

-- 사용자 지정 제약조건명을 부여한 primary key
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno   number(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname varchar2(14),
    loc   varchar2(13)
);

--TABLE CONSTRAINT 
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(13),
    loc   VARCHAR2(14),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test
VALUES (1, 'ddit2', 'daejeon');

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(13) NOT NULL,
    loc VARCHAR2(14)
);

INSERT INTO dept_test
VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test
VALUES (2, null, 'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(13) UNIQUE,
    loc VARCHAR2(14)
);

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (2, 'ddit2', 'daejeon');
rollback;