SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP DATABASE IF EXISTS CONSTRUCT;
CREATE DATABASE CONSTRUCT;
USE CONSTRUCT;

DROP TABLE IF EXISTS BUSINESS_REG;
DROP TABLE IF EXISTS CONSTRUCT_CORP_REG;
DROP TABLE IF EXISTS CONSTRUCT_EMPLOYEE;
DROP TABLE IF EXISTS LOGIN;
DROP TABLE IF EXISTS CONSTRUCT_CORP;
DROP TABLE IF EXISTS CONSTRUCT_CORP_REG_INFO;
DROP TABLE IF EXISTS CONSTRUCT_PROJECT;
DROP TABLE IF EXISTS CORP_REG_BUSINESS;
DROP TABLE IF EXISTS CORP_INFO;
DROP TABLE IF EXISTS JOIN_PERSON;
DROP TABLE IF EXISTS JOIN_CORP;
DROP TABLE IF EXISTS PROJECT_INFO;


DROP TABLE IF EXISTS WORKER_NODE;
CREATE TABLE WORKER_NODE
(
    ID BIGINT NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
    HOST_NAME VARCHAR(64) NOT NULL COMMENT 'host name',
    PORT VARCHAR(64) NOT NULL COMMENT 'port',
    TYPE INT NOT NULL COMMENT 'node type: CONTAINER(1), ACTUAL(2), FAKE(3)',
    LAUNCH_DATE DATE NOT NULL COMMENT 'launch date',
    MODIFIED TIMESTAMP NOT NULL COMMENT 'modified time',
    CREATED TIMESTAMP NOT NULL COMMENT 'created time',
    PRIMARY KEY(ID)
)
    COMMENT='DB WorkerID Assigner for UID Generator',ENGINE = INNODB;

/* Create Tables */

CREATE TABLE BUSINESS_REG
(
    CORP_TYPE varchar(16) NOT NULL,
    BUSINESS_ID bigint NOT NULL,
    REG_ID bigint NOT NULL,
    -- DELETE
    -- MODIFY
    -- CREATE
    -- QUOTED
    OPERATE varchar(6) NOT NULL COMMENT 'DELETE
MODIFY
CREATE
QUOTED',
    PRIMARY KEY (CORP_TYPE, BUSINESS_ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CONSTRUCT_CORP
(
	CORP_CODE varchar(32) NOT NULL,
	CORP_INFO bigint NOT NULL,
	ENABLE boolean NOT NULL,
	TYPES varchar(128) NOT NULL,
	DATA_TIME timestamp NOT NULL,
	PRIMARY KEY (CORP_CODE)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CONSTRUCT_CORP_REG
(
	CORP_CODE varchar(32) NOT NULL,
	CORP_TYPE varchar(16) NOT NULL,
	REG_ID bigint NOT NULL,
	PRIMARY KEY (CORP_CODE, CORP_TYPE)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CONSTRUCT_CORP_REG_INFO
(
    REG_DATE_TO date NOT NULL,
    LEVEL int,
    LEVEL_NUMBER varchar(32),
    ID bigint NOT NULL,
    PREVIOUS bigint,
    PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CONSTRUCT_EMPLOYEE
(
	ID bigint NOT NULL,
	REG_NUMBER varchar(32),
	REG_RIGHT bigint,
	IDENTIFY_TYPE varchar(16) NOT NULL,
	IDENTIFY_NUMBER varchar(32) NOT NULL,
	NAME varchar(64) NOT NULL,
	TEL varchar(16),
	CORP_CODE varchar(32) NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CONSTRUCT_PROJECT
(
	PROJECT_CODE varchar(32) NOT NULL,
	ENABLE boolean NOT NULL,
	PROJECT_INFO bigint NOT NULL,
	PRIMARY KEY (PROJECT_CODE)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CORP_INFO
(
	ID bigint NOT NULL,
	REG_ID_TYPE varchar(16) NOT NULL,
	REG_ID_NUMBER varchar(32) NOT NULL,
	OWNER_NAME varchar(32) NOT NULL,
	OWNER_ID_TYPE varchar(16) NOT NULL,
	OWNER_ID_NUMBER varchar(32),
	ADDRESS varchar(256),
	TEL varchar(16),
	NAME varchar(128) NOT NULL,
	PREVIOUS bigint,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE CORP_REG_BUSINESS
(
    BUSINESS_ID bigint NOT NULL,
    CORP_CODE varchar(32) NOT NULL,
    CREATE_TIME datetime NOT NULL,
    REG_TIME datetime NOT NULL,
    -- OLD
    -- OLE
    -- BIZ
    SOURCE varchar(3) NOT NULL COMMENT 'OLD
OLE
BIZ',
    STATUS varchar(8),
    INFO boolean NOT NULL,
    CORP_INFO bigint NOT NULL,
    TAGS varchar(512),
    APPLY_TIME datetime,
    PRIMARY KEY (BUSINESS_ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE DFCC
(
	ID bigint NOT NULL,
	NAME varchar(32) NOT NULL,
	_ORDER int NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE DFCI
(
	ID bigint NOT NULL,
	CHECK_ID bigint NOT NULL,
	COLLECT_ID bigint NOT NULL,
	_ORDER int NOT NULL,
	NAME varchar(32) NOT NULL,
	CONTENT varchar(256),
	_REQUIRE varchar(256) NOT NULL,
	LEVEL char NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE DFCT
(
	ID bigint NOT NULL,
	_ORDER int NOT NULL,
	NAME varchar(32) NOT NULL,
	FULL boolean NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE FIRE_CHECK
(
	ID bigint NOT NULL,
	CHECK_DATE date NOT NULL,
	PROJECT_CODE varchar(32) NOT NULL,
	NAME varchar(256) NOT NULL,
	ADDRESS varchar(512),
	FILE_NUMBER varchar(32),
	CONTACTS varchar(64),
	TEL varchar(16),
	TYPE varchar(8) NOT NULL,
	PROPERTY varchar(16) NOT NULL,
	DANGER varchar(16),
	CONTRACT_AREA decimal(19,2),
	ALL_AREA decimal(19,2),
	HEIGHT decimal(19,2),
	GROUND_FLOOR_COUNT int,
	UNDER_FLOOR_COUNT int,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE FIRE_CHECK_COLLECT
(
	ID bigint NOT NULL,
	_ORDER int NOT NULL,
	NAME varchar(32) NOT NULL,
	FULL boolean NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE FIRE_CHECK_ITEM
(
	ID bigint NOT NULL,
	NAME varchar(32) NOT NULL,
	_ORDER int NOT NULL,
	CONCLUSION varchar(16),
	CHECK_ID bigint NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE FIRE_CHECK_SUB_ITEM
(
	ID bigint NOT NULL,
	ITEM_ID bigint NOT NULL,
	COLLECT_ID bigint NOT NULL,
	_ORDER int NOT NULL,
	NAME varchar(32) NOT NULL,
	CONTENT varchar(256),
	_REQUIRE varchar(256) NOT NULL,
	LEVEL char NOT NULL,
	PARTS varchar(16),
	COUNT int,
	DESCRIPTION varchar(16),
	STANDARD boolean NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE FIRE_JOIN_CORP
(
	ID bigint NOT NULL,
	CHECK_ID bigint NOT NULL,
	CORP_TYPE varchar(16) NOT NULL,
	LEVEL int NOT NULL,
	CORP_CODE varchar(32) NOT NULL,
	NAME varchar(128) NOT NULL,
	REG_ID_TYPE varchar(16) NOT NULL,
	REG_ID_NUMBER varchar(32) NOT NULL,
	CONTACTS varchar(64),
	TEL varchar(16),
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE JOIN_CORP
(
	ID bigint NOT NULL,
	OUTSIDE_TEAM_FILE varchar(32),
	OUT_LEVEL boolean NOT NULL,
	OUT_LEVEL_FILE varchar(32),
	CORP_CODE varchar(32) NOT NULL,
	CORP_TYPE varchar(16) NOT NULL,
	NAME varchar(128) NOT NULL,
	REG_ID_TYPE varchar(16) NOT NULL,
	REG_ID_NUMBER varchar(32) NOT NULL,
	LEVEL int NOT NULL,
	PROJECT_ID bigint NOT NULL,
	CONTACTS varchar(64),
	TEL varchar(16),
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE JOIN_PERSON
(
	ID bigint NOT NULL,
	CORP bigint NOT NULL,
	JOIN_TYPE varchar(16) NOT NULL,
	LEVEL varchar(8),
	JOB varchar(32) NOT NULL,
	NAME varchar(64) NOT NULL,
	IDENTIFY_TYPE varchar(16) NOT NULL,
	IDENTIFY_NUMBER varchar(32) NOT NULL,
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE LOGIN
(
	CORP_CODE varchar(32) NOT NULL,
	ROLE varchar(16) NOT NULL,
	IDENTIFY_TYPE varchar(16) NOT NULL,
	IDENTIFY_NUMBER varchar(32) NOT NULL,
	NAME varchar(64) NOT NULL,
	PASSWORD varchar(32),
	LOGIN_ID varchar(32) NOT NULL,
	PRIMARY KEY (LOGIN_ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;


CREATE TABLE PROJECT_INFO
(
	ID bigint NOT NULL,
	PROJECT_CODE varchar(32) NOT NULL,
	NAME varchar(256) NOT NULL,
	ADDRESS varchar(512),
	TYPE varchar(32),
	PROPERTY varchar(32),
	CONTRACT_AREA decimal(19,2),
	ALL_AREA decimal(19,2),
	GROUND_FLOOR_COUNT int,
	UNDER_FLOOR_COUNT int,
	BEGIN_DATE date,
	COMPLETED_DATE date,
	TENDER varchar(32),
	STRUCTURE varchar(32),
	COSTS decimal(18,2),
	MAIN_PROJECT boolean,
	MAIN_PROJECT_LEVEL varchar(16),
	MAIN_PROJECT_FILE varchar(32),
	MEMO varchar(512),
	REG_TIME datetime,
	STATUS varchar(16) NOT NULL,
	HEIGHT decimal(19,2),
	PRIMARY KEY (ID)
) ENGINE = InnoDB DEFAULT CHARACTER SET utf8;



/* Create Foreign Keys */

ALTER TABLE CONSTRUCT_CORP_REG
	ADD FOREIGN KEY (CORP_CODE)
	REFERENCES CONSTRUCT_CORP (CORP_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONSTRUCT_EMPLOYEE
	ADD FOREIGN KEY (CORP_CODE)
	REFERENCES CONSTRUCT_CORP (CORP_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE LOGIN
	ADD FOREIGN KEY (CORP_CODE)
	REFERENCES CONSTRUCT_CORP (CORP_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE BUSINESS_REG
	ADD FOREIGN KEY (REG_ID)
	REFERENCES CONSTRUCT_CORP_REG_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONSTRUCT_CORP_REG
	ADD FOREIGN KEY (REG_ID)
	REFERENCES CONSTRUCT_CORP_REG_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONSTRUCT_CORP_REG_INFO
	ADD FOREIGN KEY (PREVIOUS)
	REFERENCES CONSTRUCT_CORP_REG_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONSTRUCT_CORP
	ADD FOREIGN KEY (CORP_INFO)
	REFERENCES CORP_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CORP_INFO
	ADD FOREIGN KEY (PREVIOUS)
	REFERENCES CORP_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CORP_REG_BUSINESS
	ADD FOREIGN KEY (CORP_INFO)
	REFERENCES CORP_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE BUSINESS_REG
	ADD FOREIGN KEY (BUSINESS_ID)
	REFERENCES CORP_REG_BUSINESS (BUSINESS_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;




ALTER TABLE JOIN_PERSON
	ADD FOREIGN KEY (CORP)
	REFERENCES JOIN_CORP (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONSTRUCT_PROJECT
	ADD FOREIGN KEY (PROJECT_INFO)
	REFERENCES PROJECT_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE JOIN_CORP
	ADD FOREIGN KEY (PROJECT_ID)
	REFERENCES PROJECT_INFO (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



SET SESSION FOREIGN_KEY_CHECKS=1;