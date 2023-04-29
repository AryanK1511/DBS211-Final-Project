/* ==================================================

----------------------------------------
Group Members
----------------------------------------

Member 1:
**********
Name: Bhanu Rakshita Paul
Student ID: brpaul@myseneca.ca
Email: 143428217

Member 2:
**********
Name: Aryan Khurana
Student ID: 145282216
Email: akhurana22@myseneca.ca

================================================== */

/* =================== Database Creation Script =================== */

/* Creating the 'user' table */
CREATE TABLE app_user (
    USER_ID INT PRIMARY KEY NOT NULL,
    USER_NAME VARCHAR(25) NOT NULL,
    FIRST_NAME VARCHAR(25) NOT NULL,
    MIDDLE_NAME VARCHAR(25) DEFAULT null,
    LAST_NAME VARCHAR(25) NOT NULL,
    USER_PASSWORD VARCHAR(25) NOT NULL,
    USER_EMAIL VARCHAR(25) NOT NULL,
    USER_STATUS VARCHAR(10) NOT NULL,
    CREATED_AT DATE NOT NULL
);

/* Creating the channel_category table */
CREATE TABLE channel_category (
    CATEGORY_ID INT PRIMARY KEY NOT NULL,
    CATEGORY_TYPE VARCHAR(10) NOT NULL,
    CATEGORY_NAME VARCHAR(20) NOT NULL,
    CREATOR_ID INT NOT NULL,
    CONSTRAINT foreign_constraint
    FOREIGN KEY (CREATOR_ID) REFERENCES app_user(USER_ID)
);

/* Creating the 'channel' table */
CREATE TABLE channel (
    CHANNEL_ID INT PRIMARY KEY NOT NULL,
    CHANNEL_NAME VARCHAR(20) NOT NULL,
    CREATED_AT DATE NOT NULL,
    CATEGORY_ID INT DEFAULT 0,
    CREATOR_ID INT NOT NULL,
    CONSTRAINT foreign_constraint_1
    FOREIGN KEY (CATEGORY_ID) REFERENCES channel_category(CATEGORY_ID),
    CONSTRAINT foreign_constraint_2
    FOREIGN KEY (CREATOR_ID) REFERENCES app_user(USER_ID)
);

/* Creating the 'message' table */
    CREATE TABLE message (
    MESSAGE_ID INT PRIMARY KEY NOT NULL,
    MESSAGE_TYPE VARCHAR(10) NOT NULL,
    MESSAGE_CONTENT VARCHAR(250) NOT NULL,
    SENDER_ID    INT NOT NULL,
    CHANNEL_ID INT DEFAULT 0,
    RECEIVER_ID INT DEFAULT 0,
    CONSTRAINT foreign_constraint_1a
    FOREIGN KEY (SENDER_ID) REFERENCES app_user(USER_ID),
    CONSTRAINT foreign_constraint_2a
    FOREIGN KEY (RECEIVER_ID) REFERENCES app_user(USER_ID),
    CONSTRAINT foreign_constraint_3a
    FOREIGN KEY (CHANNEL_ID) REFERENCES channel(CHANNEL_ID)
);

/* Creating the 'bot' table */
CREATE TABLE bot (
    BOT_ID INT PRIMARY KEY NOT NULL,
    BOT_NAME VARCHAR(20) NOT NULL,
    BOT_DESCRIPTION VARCHAR(50)
);

/* Creating the 'friend_request' table */
CREATE TABLE friend_request (
    REQUEST_ID INT PRIMARY KEY NOT NULL,
    IS_ACCEPTED NUMBER(1) NOT NULL,
    SENDER_ID INT NOT NULL,
    RECEIVER_ID INT NOT NULL,
    CONSTRAINT foreign_constraint_1b
    FOREIGN KEY (SENDER_ID) REFERENCES app_user(USER_ID),
    CONSTRAINT foreign_constraint_2b
    FOREIGN KEY (RECEIVER_ID) REFERENCES app_user(USER_ID)
);

/* Creating the 'server' table */
CREATE TABLE server (
    SERVER_ID INT PRIMARY KEY NOT NULL,
    SERVER_NAME VARCHAR(25) NOT NULL,
    CREATION_DATE DATE NOT NULL,
    TOTAL_MEMBERS INT NOT NULL,
    CREATOR_ID INT NOT NULL,
    CONSTRAINT foreign_constraintc
    FOREIGN KEY (CREATOR_ID) REFERENCES app_user(USER_ID)
);

/* Creating the 'assigned_role' table */
CREATE TABLE assigned_role (
    ROLE_ID INT PRIMARY KEY NOT NULL,
    PERM1_EDIT NUMBER(1) DEFAULT null,
    PERM2_MANAGE_ROLE NUMBER(1) DEFAULT null,
    PERM3_AUDIT_LOG_ACCESS NUMBER(1) DEFAULT null,
    PERM4_KICK_MEMBERS NUMBER(1) DEFAULT null,
    PERM5_BAN_MEMBERS NUMBER(1) DEFAULT null,
    PERM6_ADMINISTRATOR NUMBER(1) DEFAULT null,
    ASSIGNED_TO INT NOT NULL,
    CONSTRAINT foreign_constraintd
    FOREIGN KEY (ASSIGNED_TO) REFERENCES app_user(USER_ID)
);

/* Creating the 'user_roles' table */
CREATE TABLE user_roles (
    USER_ROLE_ID INT PRIMARY KEY NOT NULL,
    ASSIGNED_USER INT NOT NULL,
    ASSIGNED_ROLE INT NOT NULL,
    CONSTRAINT foreign_constraint_1e
    FOREIGN KEY (ASSIGNED_USER) REFERENCES app_user(USER_ID),
    CONSTRAINT foreign_constraint_2e
    FOREIGN KEY (ASSIGNED_ROLE) REFERENCES assigned_role(ROLE_ID)
);

/* Creating the 'bot_roles' table */
CREATE TABLE server_bots (
    SERVER_BOT_ID INT PRIMARY KEY NOT NULL,
    ASSIGNED_SERVER INT NOT NULL,
    ASSIGNED_BOT INT NOT NULL,
    CONSTRAINT foreign_constraint_1f
    FOREIGN KEY (ASSIGNED_SERVER) REFERENCES server(SERVER_ID),
    CONSTRAINT foreign_constraint_2f
    FOREIGN KEY (ASSIGNED_BOT) REFERENCES bot(BOT_ID)
);

/* Creating the 'server_bots' table */
CREATE TABLE bot_roles (
    BOT_ROLE_ID INT PRIMARY KEY NOT NULL,
    ASSIGNED_ROLE INT NOT NULL,
    ASSIGNED_BOT INT NOT NULL,
    CONSTRAINT foreign_constraint_1g
    FOREIGN KEY (ASSIGNED_BOT) REFERENCES bot(BOT_ID),
    CONSTRAINT foreign_constraint_2g
    FOREIGN KEY (ASSIGNED_ROLE) REFERENCES assigned_role(ROLE_ID)
);