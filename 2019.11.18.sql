
SELECT *
FROM USER_Views;

SELECT *
FROM ALL_Views
WHERE OWNER = 'PC06';

SELECT *
FROM pc06.v_emp_dept;

--PC06 계정에서 조회권한을  받은 v_emp_dept view를 hr 계정에서 조회하기
--위해서는 계정명.view이름 형식으로 기술을 해야한다.
-- 매번 계정명을 기술하기 귀찮으므로 Syonoym을 통해 다른 별칭을 생성

CREATE SYNONYM V_EMP_DEPT FOR PC06.V_EMP_DEPT;

SELECT *
FROM v_emp_dept;

--SYNONYM 삭제
DROP SYNONYM v_emp_dept;


--hr 계정의 비밀번호 : java
-- hr 계정의 비밀번호 변경 : hr
ALTER USER hr IDENTIFIED BY hr; 
ALTER USER PC06 IDENTIFIED BY java; 
-- 본인 계정이 아니라 에러

--dictionary
--접두어 : USER : 사용자 소유 객체
--        ALL : 사용자가 사용가능 한 객체
--        DBA : 관리자 관점의 전체 객체(일반 사용자는 사용 불가)
--        V$ : 시스템과 관련된 view (일반 사용자는 사용불가

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABlES
WHERE OWNER IN ('PC06', 'HR');

--오라클에서 동일한 SQL이란?
--문자가 한글자라도 틀리면 안됨
--다른 qul들은 같은결과를 만들어내주지몰라도 DBY에서
SELECT /*bind_test */* FROM emp WHERE empno = 7369;
SELECT /*bind_test */* FROM emp WHERE empno = '7499';
Select /*bind_test */* FROM emp WHERE empno = '7521';
Select /*bind_test */* FROM emp WHERE empno = :empno;


SELECT *
FROM dictionary;
