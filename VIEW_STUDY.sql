
-- VIEW (뷰) : 가상 테이블
-- 뷰가 유용하게 사용되는 경우
--    (1) 테이블의 데이터 조회 시 조인이 지속 반복되는 경우
--    (2) 테이블의 특정 데이터의 보안성을 확보하기 위함

SELECT * FROM emp;

-- emp 테이블에 대한 첫번째 뷰 생성
CREATE VIEW EMP_VIEW_1
AS
SELECT EMPNO, ENAME, JOB
FROM emp;

SELECT * FROM EMP_VIEW_1;
-- --------------------------------
CREATE OR REPLACE VIEW EMP_VIEW_2
AS
SELECT EMPNO, ENAME, SAL, COMM
FROM emp
WHERE SAL >= 350;

SELECT * FROM EMP_VIEW_2;
DROP VIEW EMP_VIEW_2;
-- --------------------------------
