-- 공부용 테이블 생성
-- 컬렴명  자료형  (최대글자수)
-- 중복X, NULL X 의 조건을 줄 수 있는 제약조건 PRIMARY KEY 중요!
-- 삽입, 롤백, 커밋 모두 (CTRL + SHIFT + F9) 실행시켜야 작동함.

-- 현재 쿼리 탭에서는 AUTOCOMMIT 을 비활성화 하겠습니다.
SET @@AUTOCOMMIT=0;

-- 데이터의 변경사항을 취소
ROLLBACK;

-- 데이터의 변경사항을 저장
COMMIT;


CREATE TABLE STUDENT (
	STU_NO INT PRIMARY KEY
	, STU_NAME VARCHAR(10)
	, SCORE INT
	, ADDR VARCHAR(20)
);

-- 모든 정보 출력
SELECT * FROM student;

-- 데이터 삽입
-- : INSERT INTO 테이블명 (컬럼명들) VALUES (값들);
INSERT INTO student (STU_NO, STU_NAME, SCORE, ADDR) VALUES (1, '김자바', 80, '울산');
INSERT INTO student (STU_NO, STU_NAME) VALUES (2, '이자바');
INSERT INTO student (STU_NAME, STU_NO) VALUES ('최자바', 3); -- 순서 바꿔도 가능
COMMIT;

INSERT INTO student(STU_NAME, SCORE) VALUES ('최자바', 90); -- PRIMARY KEY 종목이 들어가지 않아서 삽입되지 않는다.

INSERT INTO student VALUES (5, '홍길동', 85, '서울'); -- 컬럼명 생략가능 > 정보 전체 순서, 갯수대로 바르게 입력해야 함.
COMMIT;

SELECT * FROM student;
-- 데이터 삭제
-- : DELETE FROM 테이블명 [WHERE 조건];      [] 생략가능
DELETE FROM student;
ROLLBACK; -- 삭제도 되돌릴 수 있음.

-- 학번이 1번인 학생을 삭제하는 쿼리
DELETE FROM student WHERE STU_NO = 1;

-- 학번이 3번 이상이면서 주소가 NULL 인 학생을 삭제하는 쿼리
DELETE FROM student WHERE STU_NO >= 3 AND ADDR IS NULL;

COMMIT; 