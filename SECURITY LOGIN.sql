CREATE TABLE SECURITY_MEMBER (
	MEMBER_ID VARCHAR(50) PRIMARY KEY
	, MEMBER_NAME VARCHAR(50) NOT NULL
	, MEMBER_PW VARCHAR(50) NOT NULL
	, MEMBER_ROLL VARCHAR(50) DEFAULT 'USER'
);