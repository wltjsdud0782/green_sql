-- 위치의 위도, 경도 테이블 --------------------------------------------------
CREATE TABLE MAP(
	SERIAL_NO VARCHAR(15) NOT NULL PRIMARY KEY
	, STATION_NAME VARCHAR(20) NOT NULL
	, LAT DOUBLE DEFAULT 37.0000 -- 위도
	, LON DOUBLE DEFAULT 126.0000 -- 경도
);

-- 데시벨, 전체 평균 테이블 --------------------------------------------------
CREATE TABLE AVERAGE (
	AVERAGE_CODE INT AUTO_INCREMENT PRIMARY KEY
	, AIR_NO INT REFERENCES AIR_QUALITY (AIR_NO)
	, DATA_CODE INT REFERENCES TEMANDHUM (DATA_CODE)
	, DECIBEL_CODE INT REFERENCES DECIBEL_INFO (DECIBEL_CODE)
);

CREATE TABLE DECIBEL_INFO(
	DECIBEL_CODE INT AUTO_INCREMENT PRIMARY KEY
	, DECIBEL INT NOT NULL
	, DECIBEL_GRADE VARCHAR(10) NOT NULL DEFAULT '보통' -- '좋음, 보통, 나쁨'
	, SERIAL_NO VARCHAR(15) REFERENCES MAP (SERIAL_NO)
);

-- 미세먼지, 초미세먼지, 이산화탄소 대기질 데이터 ----------------------------
CREATE TABLE AIR_QUALITY (
	AIR_NO INT AUTO_INCREMENT PRIMARY KEY
	, PM_CODE INT NOT NULL
	, PM_GRADE VARCHAR(5) DEFAULT '보통'
	, FPM_CODE INT NOT NULL
	, FPM_GRADE VARCHAR(5) DEFAULT '보통'
	, CO2_CODE FLOAT NOT NULL
	, VOC_CODE INT NOT NULL
	, AQI_CODE INT NOT NULL
	, SERIAL_NO VARCHAR(15) REFERENCES MAP (SERIAL_NO)
);

-- 온도, 습도 데이터 ---------------------------------------------------------
CREATE TABLE TEMANDHUM (
	DATA_CODE INT AUTO_INCREMENT PRIMARY KEY
	, TEMPERATURE FLOAT NOT NULL
	, HUMIDITY INT NOT NULL
	, DATA_TIME INT NOT NULL
	, SERIAL_NO VARCHAR(15) REFERENCES MAP (SERIAL_NO)
);