-- SELECT : 조회할 컬럼 명시
--          -전체 컬럼 조회 :  *
--          - 일부 컬럼 : 해당 컬럼명 나열 (, 구분)
-- FROM : 조회할 테이블 명시
-- 쿼리를 여러줄에 나누어서 작성해도 상관 없다.
-- 단 keyword는 붙여서 작성

-- 모든 컬럼을 조회
SELECT * FROM prod;

-- 특정 컬럼만 조회
SELECT prod_id, prod_name
FROM prod;

--1. lprod 테이블의 모든 컬럼 조회
SELECT *
FROM lprod;

--2 buyer 테이블에서 buyer 
SELECT buyer_id, buyer_name 
FROM buyer;

--3
SELECT *
fROM cart;

--4
SELECT mem_id, mem_pass, mem_name
FROM member;

--연산자 / 날짜연산
--date type + 정수 : 일자를 더한다
--null을 포함한 연산의 결과는 항상 null이다.
SELECT userid, usernm, reg_dt,
reg_dt + 5 reg_dt_after5, 
reg_dt - 5 as reg_dt_before5
FROM users;


SELECT prod_id as id, prod_name as name
FROM prod;

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod;

SELECT buyer_id as 바이어아이디, buyer_name as 이름
FROM buyer;

-- 문자열 결함
-- java : + -> sql : ||
-- CONCAT(str, str) 함수
-- users테이블의 userid, usernm
SELECT userid, usernm, userid || usernm,
       CONCAT(userid, usernm)
FROM users;

--문자열 상수 (컬럼에 담긴 데이터가 아닌 개발자가 직접 입력한 문자열)
SELECT '사용자 아이디 : ' || userid,
        concat('사용자 아이디 : ', userid)
FROM users;

-- 실습 sel_con1
SELECT 'SELECT * FROM ' || table_name || ';' as QUERY
FROM user_tables;

--desc table
--테이블의 정의된 컬럼을 알고 싶을 때
-- 1.desc
-- 2.SELECT * .....
desc emp;

SELECT *
FROM emp;

-- WHERE, 조건연산자

SELECT *
FROM users
WHERE userid = 'brown';

--usernm이 샐리인 데이터를 조회하는 쿼리 작성
SELECT *
FROM users
WHERE usernm = '샐리';
