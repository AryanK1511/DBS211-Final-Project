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

/* =================== Business Reports Script =================== */

/* VIEW 1 */

/*
This view displays all the users along with the servers that they have created. It also represents all the permissions that are assigned to the user. This view provides all the necessary information that the social media platform might need to generate a single query output of all servers and their creators.
*/

CREATE [OR REPLACE] VIEW view_name user_info AS
SELECT APP_USER.USER_NAME AS "USER", (APP_USER.FIRST_NAME || ' ' || APP_USER.LAST_NAME) AS "USER_NAME", SERVER.SERVER_NAME AS "SERVER_CREATED", ASSIGNED_ROLE.ROLE_ID
FROM APP_USER JOIN USER_ROLES ON APP_USER.USER_ID = USER_ROLES.ASSIGNED_USER
JOIN SERVER ON SERVER.CREATOR_ID = APP_USER.USER_ID
JOIN ASSIGNED_ROLE ON USER_ROLES.ASSIGNED_ROLE = ASSIGNED_ROLE.ROLE_ID;

/* VIEW 2 */

/*
This view enlists all the bots that are part of Discord along with the permissions they have in servers. It can be used by Discord to keep a check of any unauthorised activity which involves a bot as it is a third-party software.
*/

CREATE VIEW bot_info AS
SELECT BOT.BOT_NAME, SERVER.SERVER_NAME, ASSIGNED_ROLE.ROLE_ID
FROM BOT JOIN SERVER_BOTS ON BOT.BOT_ID = SERVER_BOTS.ASSIGNED_BOT
JOIN SERVER ON SERVER.SERVER_ID = SERVER_BOTS.ASSIGNED_SERVER
JOIN BOT_ROLES ON BOT_ROLES.ASSIGNED_BOT = BOT.BOT_ID
JOIN ASSIGNED_ROLE ON ASSIGNED_ROLE.ROLE_ID = BOT_ROLES.ASSIGNED_ROLE;

/* VIEW 3 */

/*
Our 'FRIEND_REQUEST' table contains information of all the requests taken place between two users. This view helps us to create a subset of the data which includes only necessary information which in this case is list of requests that have been accepted. It can be used by discord to create friend lists of various users.
*/

CREATE VIEW friend_list AS
SELECT A1.USER_NAME AS "USER", (A1.FIRST_NAME || ' ' || A1.LAST_NAME) AS "USER_NAME", A2.USER_NAME AS "FRIEND", (A2.FIRST_NAME || ' ' || A2.LAST_NAME) AS "FRIEND_NAME"
FROM FRIEND_REQUEST JOIN APP_USER A1 ON FRIEND_REQUEST.SENDER_ID = A1.USER_ID
JOIN APP_USER A2 ON FRIEND_REQUEST.RECEIVER_ID = A2.USER_ID
WHERE FRIEND_REQUEST.IS_ACCEPTED = 1;

/* VIEW 4 */

/*
This view records all the messages sent in a particular channel of a servers along with the information of it’s sender. It can used by Discord to perform operations on these messages like viewing, editing, deleting, sharing, etc.
*/

CREATE VIEW channel_messages AS
SELECT USER_NAME, MESSAGE_CONTENT
FROM MESSAGE JOIN CHANNEL USING (CHANNEL_ID)
JOIN APP_USER ON MESSAGE.SENDER_ID = APP_USER.USER_ID
WHERE CHANNEL_ID = 2003;