# 이것도 주석
-- 데이터 조회

-- 데이터 조회 (1)
-- SELECT 컬럼명들 FROM 테이블명;
-- 1. EMP 테이블에서 모든 사원의 사번, 이름, 급여 정보 조회
SELECT EMPNO, ENAME, SAL FROM emp;

-- 모든 사원의 이름, 직급, 입사일, 부서번호 조회
SELECT ENAME, JOB, HIREDATE, DEPTNO FROM emp;

-- 모든 사원의 모든 정보를 조회
-- * (에스테리스크) : ALL
SELECT * FROM emp;

-- 조건을 통해 조회
-- 급여가 300 이상인 사원들의 사번, 사원명, 급여 조회
SELECT EMPNO, ENAME, SAL FROM emp
WHERE SAL >= 300;

-- 직급이 대리인 사원들의 사원명, 직급, 급여를 조회
SELECT ENAME, JOB, SAL FROM emp
WHERE JOB = '대리';

-- 직급이 과장이고 급여가 400 이상인 사원들의 모든 정보 조회
SELECT * FROM emp
WHERE JOB = '과장' AND SAL >=400;  -- 같지않다 : !=(느낌표,이꼴) , <>

-- COMM 컬럼이 (NULL)인 사원의 모든 정보 조회
SELECT * FROM emp
WHERE COMM IS NULL; -- (NULL)이 아닌 사원 조회 : WHERE COMM IS NOT NULL

-- 급여가 500미만이거나 700이상이면서 직급은 차장이고 커미션은 NULL 인 사원의 사번, 사원명, 급여, 직급, 커미션 정보 조회
SELECT EMPNO, ENAME, SAL, JOB, COMM FROM emp
WHERE (SAL < 500 OR SAL >= 700) AND JOB = '차장' AND COMM IS NULL;  -- 만족하는 조건 없음.

-- LIKE 연산자, 와일드카드
-- 와일드카드 : (%) AND (_)
	-- (1) % : %%의 사이값이 포함된 데이터
	-- (2) _ : _ 이 포함된 글자 수 + 값의 위치가 일치하는 데이터
	
-- 사원명에서 '이'라는 글자가 포함된 사원 조회
SELECT * FROM emp
WHERE ENAME LIKE '%이%';

-- 사원명이 3글자 이면서 중간 글자가 '이'라는 글자인 사원 조회
SELECT * FROM emp
WHERE ENAME LIKE '_이_';

-- 사원명의 세번째 글자가 이'라는 글자인 사원 조회
SELECT * FROM emp
WHERE ENAME LIKE '__이%';

-- UPPER : 대문자로 변경 / LOWER : 소문자로 변경   > 오라클
SELECT 'java', UPPER('java'), LOWER('JAVA');

-- BOARD 테이블 내 제목에 java라는 글자가 포함된 게시글 내용 조회 쿼리 (대소문자 구분X)
SELECT CONTENT FROM board
WHERE TITLE LIKE '%java%';

SELECT CONCAT('AA','BB'); -- 문자열 나열

SELECT CONTENT FROM board -- 활용
WHERE TITLE LIKE CONCAT('%','#{title}','%')