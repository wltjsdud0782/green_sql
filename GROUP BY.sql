
-- group by : 통계 쿼리에서 사용

SELECT * FROM emp;

-- 급여의 합
SELECT SUM(SAL) FROM emp;

-- 각 직급별 급여의 합
SELECT JOB, SUM(SAL) FROM emp GROUP BY JOB;

-- 부서번호별 인원수 조회
SELECT DEPTNO, COUNT(EMPNO) FROM emp GROUP BY DEPTNO;

-- 다중행 함수 : 데이터의 개수와 상관없이 조회 결과가 1행 나오는 함수
-- -> SUM(), COUNT(), MIN(), MAX(), AVG() 등등
-- 사번, 사원명, 모든 직원의 급여의 합 조회
SELECT EMPNO, ENAME, SUM(SAL) FROM emp; -- 이상하게 나옴

-- 문제8 + 커미션의 평균이 NULL 이라면 0.0 으로 조회
SELECT
	job
	, SUM(SAL)
	, AVG(SAL)
	, IFNULL(AVG(COMM),0.0)
FROM EMP
GROUP BY JOB
ORDER BY JOB ASC;

-- 1월에 입사한 사원을 제외한 월별 사원들의 입사자 수
SELECT
	DATE_FORMAT(HIREDATE, '%m')
	, SUBSTRING(HIREDATE, 6, 2)
	, COUNT(EMPNO)
FROM emp
WHERE DATE_FORMAT(HIREDATE, '%m') != 1
GROUP BY DATE_FORMAT(HIREDATE, '%m');

-- 월별 입사자 수를 조회 --------------------------------------------
-- 조건 : 월별 입사자 수가 2명 이상인 데이터만, 10월 제외
-- 조회 시 월별 입사자수가 높은 순으로 조회
-- (해석 순서)
SELECT -- (3)
	DATE_FORMAT(HIREDATE, '%m') 입사월
	, COUNT(EMPNO) 입사인원
FROM emp -- (1)
WHERE DATE_FORMAT(HIREDATE, '%m') != 10 -- (2)
GROUP BY 입사월 -- (4-1)
HAVING 입사인원 >= 2-- (4-2)
ORDER BY 입사인원 DESC; -- (5)
-- ------------------------------------------------------------------

-- NULL 주의 (AVG(COMM)에서 NULL 이 나오는 이유)
SELECT NULL + 10;

-- 중복 제외 데이터 조회 > DISTINCT
SELECT DISTINCT JOB FROM emp;