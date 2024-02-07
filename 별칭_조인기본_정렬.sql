-- 별칭 사용 AS (조회 시 컬럼명을 변경)
-- 컬럼명을 조회 할 때는 테이블명.컬럼명 조회
-- 통상적으로 테이블명. 은 생략한다.
SELECT EMPNO
	, ENAME
	, SAL
FROM emp;

SELECT EMPNO AS '사번'
	, ENAME AS NM
	, SAL 급여
FROM emp;

SELECT e.EMPNO
	, e.ENAME
	, e.SAL
FROM emp AS e;

-- join
SELECT * FROM emp;
SELECT * FROM dept;

-- 사원의 사번, 이름, 부서명을 조회
-- 1. CORSS JOIN (공부를 위해 학습, 실무에서 안쓴다.)
SELECT EMPNO, ENAME, DNAME
FROM emp CROSS JOIN dept;

-- 2. INNER JOIN(교집합)
-- ON : 조인하는 두 테이블의 공통컬럼이 같다는 조건을 줄 것
SELECT EMPNO, ENAME, DNAME, E.DEPTNO
FROM emp E INNER JOIN dept D
ON E.DEPTNO = D.DEPTNO;

-- 데이터 조회 시 정렬하여 출력하기
-- 사원의 모든 정보 조회하되, 급여가 낮은 순으로 조회 (오름차순)
-- ascending (오름차순 : 생략가능) descending (내림차순)
SELECT *
FROM emp
ORDER BY SAL ASC;

-- 사원 모든 데이터 조회, 급여 내림차순, 급여 같을시 사번 오름차순 정렬
SELECT *
FROM emp
ORDER BY SAL DESC , EMPNO ASC;

-- 급여가 200 이상이면서 커미션은 NULL이 아닌
-- 사원의 사번, 이름, 급여, 부서번호, 부서명 조회
-- 단, 부서번호 오름차순 정렬 후 부서번호 같을 시 급여 내림차순 정렬
SELECT EMPNO, ENAME, SAL, E.DEPTNO, DNAME
FROM emp E INNER JOIN dept D
ON E.DEPTNO = D.DEPTNO
WHERE SAL >= 200 AND COMM IS NOT NULL
ORDER BY E.DEPTNO ASC , SAL DESC;