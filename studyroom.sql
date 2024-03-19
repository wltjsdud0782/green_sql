-- ------------------------------------------- MEMBER 관련 TABLE
CREATE TABLE STUDYROOM_MEMBER (
	MEMBER_CODE INT AUTO_INCREMENT PRIMARY KEY
	, MEMBER_ID VARCHAR(15) UNIQUE NOT NULL
	, MEMBER_PW VARCHAR(50) NOT NULL
	, MEMBER_NAME VARCHAR(10) NOT NULL
	, MEMBER_TEL VARCHAR(13) NOT NULL
	, MEMBER_BIRTH DATETIME
	, MEMBER_ADDR VARCHAR(50) NOT NULL
	, MEMBER_DETAIL VARCHAR(50)
	, MEMBER_GENDER VARCHAR(2)
	, IS_ADMIN VARCHAR(10) DEFAULT 'USER'-- 'USER', 'ADMIN', 'ARBEIT'
);
ALTER TABLE studyroom_member ADD COLUMN  POST_CODE VARCHAR(10) AFTER MEMBER_BIRTH;
ALTER TABLE studyroom_member CHANGE MEMBER_DETAIL ADDR_DETAIL VARCHAR(50);
SELECT * FROM studyroom_member;


CREATE TABLE STUDYROOM_RESERVATION(
	RESERVATION_CODE INT AUTO_INCREMENT PRIMARY KEY
	, MEMBER_CODE INT REFERENCES STUDYROOM_MEMBER (MEMBER_CODE)
	, SEAT_NUM INT REFERENCES STUDYROOM_SEAT (SEAT_NUM)
	, RESERVATION_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, CHARGE_CODE INT REFERENCES studyroom_charge (CHARGE_CODE)
);
DROP TABLE studyroom_reservation;


-- 결재
CREATE TABLE APPROVAL(
	APPROVAL_CODE INT AUTO_INCREMENT PRIMARY KEY
	, MEMBER_CODE INT REFERENCES STUDYROOM_MEMBER (MEMBER_CODE)
	, CHARGE_CODE INT REFERENCES studyroom_charge (CHARGE_CODE)
	, CARD VARCHAR(5) DEFAULT 'Y'   -- 'Y', 'N'
);
ALTER TABLE APPROVAL ADD COLUMN APPROVAL_DATE DATETIME DEFAULT CURRENT_TIMESTAMP AFTER APPROVAL_CODE;

SELECT
	CHARGE_NAME
FROM approval APP
INNER JOIN studyroom_charge CHARG
ON APP.CHARGE_CODE = CHARG.CHARGE_CODE
WHERE MEMBER_CODE = 6;


-- 입실, 퇴실(me)
CREATE TABLE STUDYROOM_INOUT(
	DAY_INPUT INT AUTO_INCREMENT PRIMARY KEY
	, MEMBER_CODE INT REFERENCES STUDYROOM_MEMBER (MEMBER_CODE)
	, IN_OUT VARCHAR(5)
);


DROP TABLE studyroom_inout;
-- ------------------------------------------- SEAT 관련 TABLE
CREATE TABLE STUDYROOM_SEAT (
	SEAT_NUM INT AUTO_INCREMENT PRIMARY KEY
	, SEAT_POWER VARCHAR(10) DEFAULT 'OFF' -- (ON,OFF)
	, SEAT_FLOOR INT DEFAULT 1 NOT NULL -- (1 , 2)
	, MEMBER_CODE INT REFERENCES studyroom_member (MEMBER_CODE)
	, STATUS_NUM INT DEFAULT 2 REFERENCES seat_status (STATUS_NUM)
	, AGE_CODE INT DEFAULT 1 REFERENCES floor_age (AGE_CODE)
);


CREATE TABLE SEAT_STATUS (
	STATUS_NUM INT AUTO_INCREMENT PRIMARY KEY
	, STATUS_NAME VARCHAR(20) NOT NULL UNIQUE
);
INSERT INTO SEAT_STATUS VALUES(1, '사용중');
INSERT INTO SEAT_STATUS VALUES(2, '사용가능');
INSERT INTO SEAT_STATUS VALUES(3, '수리중');

CREATE TABLE FLOOR_AGE (
	AGE_CODE INT AUTO_INCREMENT PRIMARY KEY
	, AGE_NAME VARCHAR(15) NOT NULL
);
INSERT INTO FLOOR_AGE VALUES(1, '20세 미만');
INSERT INTO FLOOR_AGE VALUES(2, '20세 이상');


-- ------------------------------------------- ADMIN 관련 TABLE
-- 이용자 메세지 받기
CREATE TABLE STUDYROOM_MESSAGE (
	MESSAGE_CODE INT AUTO_INCREMENT PRIMARY KEY
	, MESSAGE_CONTENT VARCHAR(300) NOT NULL
	, MESSAGE_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, MEMBER_CODE INT REFERENCES studyroom_member (MEMBER_CODE)
	, SEAT_NUM INT REFERENCES STUDYROOM_SEAT (SEAT_NUM)
);



-- 요금제 
CREATE TABLE STUDYROOM_CHARGE (
	CHARGE_CODE INT AUTO_INCREMENT PRIMARY KEY
	, CHARGE_NAME VARCHAR(10) NOT NULL
	, CHARGE_FEE INT NOT NULL
);
ALTER TABLE STUDYROOM_CHARGE ADD COLUMN CHARGE_DATE INT NOT NULL AFTER CHARGE_FEE;
ALTER TABLE STUDYROOM_CHARGE CHANGE CHARGE_NAME CHARGE_NAME VARCHAR(50) NOT NULL;

INSERT INTO STUDYROOM_CHARGE VALUES(1, '30일', 220000, 30);
INSERT INTO STUDYROOM_CHARGE VALUES(2, '21일', 180000, 21);
INSERT INTO STUDYROOM_CHARGE VALUES(3, '14일', 130000, 14);
INSERT INTO STUDYROOM_CHARGE VALUES(4, '7일', 70000, 7);
INSERT INTO STUDYROOM_CHARGE VALUES(5, '1일', 10000, 1);

CREATE OR REPLACE VIEW STUDYROOM_LOG_VIEW
AS
SELECT  MEMBER.MEMBER_CODE
		, MEMBER_NAME
		
		, RESERVATION_CODE
		, RESERVATION_DATE
		
		, APPROVAL_CODE
		
		, DAY_INPUT
		, IN_OUT
		
		, SEAT_POWER
		, SEAT_FLOOR
		
		, MESSAGE_CODE
		, MESSAGE_CONTENT
		, MESSAGE_DATE
		
FROM studyroom_member MEMBER
INNER JOIN studyroom_reservation RESERVE
ON MEMBER.MEMBER_CODE = RESERVE.MEMBER_CODE
INNER JOIN approval APPROVAL
ON MEMBER.MEMBER_CODE = APPROVAL.MEMBER_CODE
INNER JOIN studyroom_inout INPUT
ON MEMBER.MEMBER_CODE = INPUT.MEMBER_CODE
INNER JOIN STUDYROOM_SEAT SEAT
ON MEMBER.MEMBER_CODE = SEAT.MEMBER_CODE
INNER JOIN STUDYROOM_MESSAGE MSG
ON MEMBER.MEMBER_CODE = MSG.MEMBER_CODE;

SELECT *
     FROM studyroom_log_view;
DROP VIEW STUDYROOM_LOG_VIEW;

-- ------------------------------------------- PAGE 관련 TABLE
CREATE TABLE STUDYROOM_BOARD (
	BOARD_CODE INT AUTO_INCREMENT PRIMARY KEY
	, BOARD_TITLE VARCHAR(20) NOT NULL
	, BOARD_WRITER VARCHAR (20) NOT NULL REFERENCES STUDYROOM_MEMBER (MEMBER_ID)
	, BOARD_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, BOARD_CONTENT VARCHAR(200)
	, BOARD_SECRET VARCHAR(10) DEFAULT 'NO' -- YES : 비밀글 , NO : 공개글
	, BOARD_ANSER VARCHAR(10) DEFAULT 'NO' -- 답변 유무
);

CREATE TABLE STUDYROOM_COMMENT (
   COMMENT_CODE INT AUTO_INCREMENT PRIMARY KEY
   ,   COMMENT_WRITER VARCHAR(20) NOT NULL 
   ,    COMMENT_CONTENT VARCHAR(200) NOT NULL
   ,   COMMENT_DATE DATETIME DEFAULT CURRENT_TIMESTAMP 
   ,    BOARD_CODE INT NOT NULL REFERENCES STUDYROOM_BOARD (BOARD_CODE)
);


CREATE TABLE BOARD_IMG (
	IMG_CODE INT AUTO_INCREMENT PRIMARY KEY
	, ORIGIN_FILE_NAME VARCHAR(100) NOT NULL
	, ATTACHED_FILE_NAME VARCHAR(100) NOT NULL
	, BOARD_CODE INT NOT NULL REFERENCES STUDYROOM_BOARD (BOARD_CODE)
);

-- 현재 날짜
SELECT DATE_FORMAT(now(), '%Y-%m-%d');

-- 더하는 쿼리
SELECT date_add(DATE_FORMAT(now(), '%Y-%m-%d'),INTERVAL 3 DAY);

-- 날짜 사이 일 수 차이 구하는 쿼리
SELECT TIMESTAMPDIFF(DAY, '2017-03-01', '2018-03-28');





-- 로그인 한 회원의 이용권 결제일 ---------------------------------------------------
SELECT DATE_FORMAT(APPROVAL_DATE, '%Y-%m-%d') FROM approval WHERE MEMBER_CODE = 6;
-- ----------------------------------------------------------------------------------
-- 로그인 한 회원의 며칠이용권인지? -------------------------------------------------
SELECT CHARGE_DATE
FROM STUDYROOM_CHARGE CHARGE
INNER JOIN APPROVAL APP
ON APP.CHARGE_CODE = CHARGE.CHARGE_CODE
WHERE
APPROVAL_CODE = (SELECT APPROVAL_CODE FROM APPROVAL WHERE MEMBER_CODE = 6);
-- ----------------------------------------------------------------------------------
-- END_DATE 식 = 로그인 한 회원의 이용권이 끝나는 날짜 --------------------------------------------------------------------------------------------------------
SELECT
	(SELECT DATE_ADD(
		(SELECT DATE_FORMAT(APPROVAL_DATE, '%Y-%m-%d') FROM approval WHERE MEMBER_CODE = 6)
		, INTERVAL (
						SELECT CHARGE_DATE
						FROM STUDYROOM_CHARGE CHARGE
						INNER JOIN APPROVAL APP
						ON APP.CHARGE_CODE = CHARGE.CHARGE_CODE
						WHERE
						APPROVAL_CODE = (SELECT APPROVAL_CODE FROM APPROVAL WHERE MEMBER_CODE = 6)
						) DAY)
							) AS END_DATE
FROM approval
WHERE MEMBER_CODE = 6;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- REMAIN_DATE 식 = 로그인 한 회원의 남은날짜 -----------------------------------------------------------------------------------------------------------------
SELECT
	TIMESTAMPDIFF(
		DAY, DATE_FORMAT(now(), '%Y-%m-%d')
		, (SELECT
			(SELECT DATE_ADD(
			(SELECT DATE_FORMAT(APPROVAL_DATE, '%Y-%m-%d') FROM approval WHERE MEMBER_CODE = 6)
			, INTERVAL (
						SELECT CHARGE_DATE
						FROM STUDYROOM_CHARGE CHARGE
						INNER JOIN APPROVAL APP
						ON APP.CHARGE_CODE = CHARGE.CHARGE_CODE
						WHERE
						APPROVAL_CODE = (SELECT APPROVAL_CODE FROM APPROVAL WHERE MEMBER_CODE = 6)
						) DAY)
							) AS END_DATE
FROM approval
WHERE MEMBER_CODE = 6)
	) AS REMAIN_DATE
FROM approval
WHERE MEMBER_CODE = 6;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 이용권 만료 시 데이터 지우기 -------------------------------------------------------------------------------------------------------------------------------
IF(ITEM_STATUS=1, '준비중', IF(ITEM_STATUS=2, '판매중', '매진')) '상태';
SELECT
	IF(
		(SELECT
			(SELECT DATE_ADD(
				(SELECT DATE_FORMAT(APPROVAL_DATE, '%Y-%m-%d') FROM approval WHERE MEMBER_CODE = 6)
				, INTERVAL (
					SELECT
						CHARGE_DATE
						FROM STUDYROOM_CHARGE CHARGE
						INNER JOIN APPROVAL APP
						ON APP.CHARGE_CODE = CHARGE.CHARGE_CODE
						WHERE
						APPROVAL_CODE = (SELECT APPROVAL_CODE FROM APPROVAL WHERE MEMBER_CODE = 6)
					) DAY)
			)
		FROM approval
		WHERE MEMBER_CODE = 6) < (SELECT DATE_FORMAT(now(), '%Y-%m-%d'))
	, '만료일이 오늘보다 이전'
	, '만료일이 오늘보다 이후' )AS EXPIRES;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
	MEMBER_CODE
	, CASE
      WHEN IS_ADMIN='USER' THEN '회원'
      WHEN IS_ADMIN='AREBEIT' THEN '알바생'
      WHEN IS_ADMIN='ADMIN' THEN '관리자'
      END IS_ADMIN
FROM studyroom_member
WHERE (CASE
      WHEN IS_ADMIN='USER' THEN '회원'
      WHEN IS_ADMIN='AREBEIT' THEN '알바생'
      WHEN IS_ADMIN='ADMIN' THEN '관리자'
      END) = '관리자';

SELECT
      APPROVAL_DATE
      , CARD
      , CHARGE_FEE
  FROM APPROVAL APP
  INNER JOIN STUDYROOM_CHARGE CHARGE
  ON APP.CHARGE_CODE = CHARGE.CHARGE_CODE
  WHERE APPROVAL_CODE = (SELECT APPROVAL_CODE FROM APPROVAL WHERE MEMBER_CODE = 6);
  
