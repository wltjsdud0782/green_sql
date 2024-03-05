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
DROP TABLE studyroom_member;


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
	, CARD VARCHAR(5) DEFAULT 'Y'   -- 'Y', 'N'
);


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
INSERT INTO STUDYROOM_CHARGE VALUES(1, '30일', 220000);
INSERT INTO STUDYROOM_CHARGE VALUES(2, '21일', 180000);
INSERT INTO STUDYROOM_CHARGE VALUES(3, '14일', 130000);
INSERT INTO STUDYROOM_CHARGE VALUES(4, '7일', 70000);
INSERT INTO STUDYROOM_CHARGE VALUES(5, '1일', 10000);

-- ------------------------------------------- PAGE 관련 TABLE
CREATE TABLE STUDYROOM_BOARD (
	BOARD_CODE INT AUTO_INCREMENT PRIMARY KEY
	, BOARD_TITLE VARCHAR(20) NOT NULL
	, BOARD_WRITER VARCHAR (20) NOT NULL REFERENCES STUDYROOM_MEMBER (MEMBER_ID)
	, BOARD_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
	, BOARD_CONTENT VARCHAR(200)
	, BOARD_SECRET VARCHAR(10) DEFAULT 'NO' -- YES : 비밀글 , NO : 공개글 
	, READ_CNT INT DEFAULT 0
);


CREATE TABLE STUDYROOM_COMMENT (
	COMMENT_CODE INT AUTO_INCREMENT PRIMARY KEY
	,	COMMENT_WIRTER VARCHAR(20) NOT NULL 
	, 	COMMENT_CONTENT VARCHAR(200) 
	,	COMMET_DATE DATETIME DEFAULT CURRENT_TIMESTAMP 
	, 	BOARD_CODE INT NOT NULL REFERENCES STUDYROOM_BOARD (BOARD_CODE)
);


CREATE TABLE BOARD_IMG (
	IMG_CODE INT AUTO_INCREMENT PRIMARY KEY
	, ORIGIN_FILE_NAME VARCHAR(100) NOT NULL
	, ATTACHED_FILE_NAME VARCHAR(100) NOT NULL
	, BOARD_CODE INT NOT NULL REFERENCES STUDYROOM_BOARD (BOARD_CODE)
);
