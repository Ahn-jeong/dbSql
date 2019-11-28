
-- 실습 PRO2
CREATE OR REPLACE PROCEDURE registdept_test 
(p_dt IN dept.deptno%TYPE, p_ddit IN dept.dname%TYPE, p_local IN dept.loc%TYPE)IS

BEGIN
     INSERT INTO dept_test 
     VALUES (p_dt, p_ddit, p_local);
     commit;
END;
/
exec registdept_test(99, 'ddit', 'daejeon');

SELECT *
FROM dept_test;

-- 실습 pro3
CREATE OR REPLACE PROCEDURE UPDATEdept_test 
(p_dt IN dept.deptno%TYPE, p_ddit IN dept.dname%TYPE, p_local IN dept.loc%TYPE)IS

BEGIN
     UPDATE dept_test SET dname = p_ddit, loc = p_local
     WHERE deptno = p_dt;
     commit;
END;
/
exec UPDATEdept_test(99, 'ddit_m', 'daejeon');

SELECT *
FROM dept_test;


--ROWTYPE : 테이블의 한 행의 데이터를 담을 수 있는 참조 타입

set SERVEROUTPUT ON;

DECLARE
    dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO dept_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dept_row : ' || dept_row.deptno || ',' || dept_row.dname || ',' || dept_row.loc);
END;
/

--복합변수 : record

DECLARE
    TYPE dept_row IS RECORD(
        deptno NUMBER(2),
        dname dept.dname%TYPE);
        
        v_dname dept.dname%TYPE;
        v_row dept_row;
BEGIN
    SELECT deptno, dname
    INTO v_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line(v_row.deptno || ', ' || v_row.dname);
    
END;
/

--tableTYPE
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    --java = 타입 변수명;
    --pl/sql = 변수명 타입;    
     v_dept dept_tab;
    
    bi BINARY_INTEGER;
BEGIN
    bi := 100;

    SELECT * 
    BULK COLLECT INTO v_dept
    FROM dept;
    
     dbms_output.put_line(bi);
    
    FOR i IN 1..v_dept.count LOOP
        dbms_output.put_line(v_dept(i).deptno || ', ' || v_dept(i).dname);
    END LOOP;    
END;
/

SELECT *
FROM dept;

--IF
--ELSIF
--END IF;

DECLARE 
    ind BINARY_INTEGER;
BEGIN
    ind :=2;
    
    IF ind = 1 THEN
        dbms_output.put_line(ind);
    ELSIF ind = 2 THEN
        dbms_output.put_line('ELSIF' || ind);
    ELSE 
        dbms_output.put_line('ELSE');
    END IF;    
END;
/

--FOR LOOF : 
--FOR 인덱스 변수 IN 시작값..종료값 LOOP
--END LOOF;
DECLARE

BEGIN
    FOR i IN 0..5 LOOP
        dbms_output.put_line('i : ' || i);
    END LOOP;    
END;
/

--LOOP : 계속 실행 판단 로직을 LOOP 안에서 제어
-- java : while(true)

DECLARE 
    i number;
BEGIN
    i := 0;
    
    LOOP
        dbms_output.put_line(i);
        i := i+1;
        EXIT WHEN i >= 5;
    END LOOP;
END;
/

--간격 평균 : 5일

DECLARE
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt dt_tab;
    i number;
    j number;
BEGIN
    i := 1;
    j := 0;
    SELECT dt
    BULK COLLECT INTO v_dt
    FROM dt
    ORDER BY dt desc;
    LOOP
    j := j+(v_dt(i).dt - v_dt(i+1).dt);
    i := i+1;
    EXIT WHEN i > v_dt.count-1; 
    END LOOP;
    dbms_output.put_line(j/(i-1));
END;
/

desc dt;

SELECT *
FROM dt;


--lead, lag 현재행의 이전, 이후 데이터를 가져 올 수 있다.

SELECT avg(ldt) avg
FROM
(
SELECT dt,
       dt-LEAD(dt) OVER (ORDER BY dt desc) ldt
FROM dt
ORDER BY dt desc
)a;

SELECT avg(a.dt-b.dt) avg
FROM
(
    SELECT a.*, ROWNUM rn
    FROM
    (   SELECT *
        FROM dt
        ORDER BY dt desc
    )a
)a,
(
    SELECT b.*, ROWNUM rn
    FROM
    (   SELECT *
        FROM dt
        ORDER BY dt desc
    )b
)b
WHERE a.rn = b.rn-1;
    

SELECT (MAX(dt)-MIN(dt)) / (COUNT(*)-1) avg
FROM dt;

DECLARE
    -- 커서 선언
    CURSOR dept_cursor IS
        SELECT deptno, dname FROM dept;
    v_deptno dept.deptno%TYPE;    
    v_dname dept.dname%TYPE;
BEGIN
    -- 커서 열기
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_deptno, v_dname;
        dbms_output.put_line(v_deptno || ', ' || v_dname);
        EXIT WHEN dept_cursor%NOTFOUND; -- 더 이상 읽을 데이터가 없을 때 종료
    END LOOP;
END;
/

-- FOR LOOP CURSOR 결합
DECLARE
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept; 
    v_deptno dept.deptno%TYPE;    
    v_dname dept.dname%TYPE;    
        
BEGIN
    FOR rec IN dept_cursor LOOP
        dbms_output.put_line(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/

--파라미터가 있는 명시적 커서
DECLARE
    CURSOR emp_cursor(p_job emp.job%TYPE) IS
        SELECT empno, ename, job
        FROM emp
        WHERE job = p_job;
BEGIN
    FOR emp IN emp_cursor('SALESMAN') LOOP
        dbms_output.put_line(emp.empno || ' | ' || emp.ename || ' | ' || emp.job);
    END LOOP;
END;
/






