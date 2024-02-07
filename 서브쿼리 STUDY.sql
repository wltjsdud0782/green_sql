-- 서브 쿼리 : 두 개 이상의 테이블이 하나로 합쳐진 것
-- 두 개 이상의 테이블에서 데이터를 조회할 때 사용

-- 김사랑 사원과 같은 부서에 근무하는 사원들의 사번, 이름, 부서번호
SELECT EMPNO, ENAME, DEPTNO
FROM emp
WHERE DEPTNO = (
   SELECT DEPTNO
   FROM emp
   WHERE ENAME = '김사랑'
);

-- 한예슬 사원과 같은 급여를 받는 사원들의 이름, 직급, 급여 조회
SELECT ENAME, JOB, SAL
FROM emp
WHERE SAL = (
   SELECT SAL
   FROM EMP
   WHERE ENAME = '한예슬'
);

-- 모든 사원들의 사번, 이름, 부서번호, 부서명 조회 (단, 서브쿼리만 사용)
SELECT EMPNO
   , ENAME
   , DEPTNO
   , (SELECT DNAME FROM dept WHERE DEPTNO = emp.DEPTNO) AS DNAME
FROM emp;

-- 모든 사원들의 급여의 합, 사원수, 높은급여, 낮은급여, 급여평균 조회
SELECT SUM(SAL), COUNT(EMPNO), MAX(SAL), MIN(SAL), AVG(SAL) FROM emp;

-- 모든 사원들의 급여 평균보다 더 높은 급여를 받는 사원들의 모든 정보
SELECT *
FROM emp
WHERE SAL > (SELECT AVG(SAL) FROM emp);

-- 근무지가 인천인 부서에 속한 사원들의 급여를 현재 급여에서 100인상
UPDATE emp
SET SAL = SAL + 100
WHERE DEPTNO = (SELECT DEPTNO FROM dept WHERE LOC = '인천');

SELECT * FROM shop_cart;
-- 장바구니에 저장된 상품들의
-- 상품명, 상품가격, 장바구니 소유자 아이디, 장바구니 소유자 명 조회
SELECT (SELECT ITEM_NAME FROM shop_item WHERE ITEM_CODE = shop_cart.ITEM_CODE) ITEM_NAME
   , (SELECT ITEM_PRICE FROM shop_item WHERE ITEM_CODE = shop_cart.ITEM_CODE) ITEM_PRICE
   , MEMBER_ID
   , (SELECT MEMBER_NAME FROM shop_member WHERE MEMBER_ID = shop_cart.MEMBER_ID) MEMBER_NAME
FROM shop_cart;