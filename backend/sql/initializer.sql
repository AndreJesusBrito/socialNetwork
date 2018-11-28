/*----------------------------------------------------
    Base Classes
----------------------------------------------------*/

CREATE TABLE _User (
    ID             INT                          PRIMARY KEY,
    name           VARCHAR(50)     NOT NULL,
    city           VARCHAR(50),
    country        VARCHAR(50),
    email          VARCHAR(50)     NOT NULL     UNIQUE,
    password       VARCHAR(50)     NOT NULL,
    birthday       DATE,
    avatar         VARCHAR(150)                 UNIQUE, -- CHANGE ME!!!!!!!!!!!!!!!!!!!!!!!!!!!
    bio            VARCHAR(300)
);

CREATE TABLE _Group (
    ID             INT                          PRIMARY KEY,
    name           VARCHAR(50)     NOT NULL,
    descrip        VARCHAR(200),
    visible        BOOLEAN         NOT NULL     DEFAULT true,
    closed         BOOLEAN         NOT NULL     DEFAULT false,
    ownerID        INT             NOT NULL,

    FOREIGN KEY (ownerID) REFERENCES _User(ID)
);

CREATE TABLE Post (
    ID             INT              PRIMARY KEY,
    postTime       TIMESTAMP        NOT NULL,
    postText       VARCHAR(5000),
    authorID       INT              NOT NULL,

    FOREIGN KEY (authorID) REFERENCES _User(ID)
);


/*----------------------------------------------------
    Suport Classes
----------------------------------------------------*/

-- suport class of Post
CREATE TABLE Comment (
    postID              INT,
    subID               INT,
    textContent         VARCHAR(500),
    postTime            TIMESTAMP       NOT NULL,
    authorID            INT             NOT NULL,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID)   REFERENCES Post(ID),
    FOREIGN KEY (authorID) REFERENCES _User(ID)
);

-- suport class of Group
CREATE TABLE Role (
    groupID             INT,
    name                varchar(50),
    permitions          INT         NOT NULL    DEFAULT 0,
    color               CHAR(7),

    PRIMARY KEY (groupID, name),

    FOREIGN KEY (groupID) REFERENCES _Group(ID)
);

-- suport class of two Users
CREATE TABLE PM (
    senderUserID        INT,
    reciverUserID       INT,
    subID               INT,
    textContent         VARCHAR(500),
    postTime            TIMESTAMP       NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID)  REFERENCES _User(ID),
    FOREIGN KEY (reciverUserID) REFERENCES _User(ID)
);




/*----------------------------------------------------
    SubClasses
----------------------------------------------------*/

-- subclass class of Post
CREATE TABLE SharePost (
    ID                      INT     PRIMARY KEY,
    shareID                 INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID),
    FOREIGN KEY (shareID)   REFERENCES Post(ID)
);

-- subclass class of Post
CREATE TABLE ProfilePost (
    ID                      INT     PRIMARY KEY,
    profileID               INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID),
    FOREIGN KEY (profileID) REFERENCES _User(ID)
);

-- subclass class of Post
CREATE TABLE GroupPost (
    ID                      INT     PRIMARY KEY,
    groupID                 INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID),
    FOREIGN KEY (groupID)   REFERENCES _Group(ID)
);

-- subclass class of Post
CREATE TABLE PostMedia (
    ID              INT             PRIMARY KEY,
    filename        VARCHAR(15)     NOT NULL,

    FOREIGN KEY (ID) REFERENCES Post(ID)
);

-- subclass class of Post
CREATE TABLE PostLink (
    ID      INT                PRIMARY KEY,
    link    VARCHAR(2083)      NOT NULL,

    FOREIGN KEY (ID) REFERENCES Post(ID)
);


-- subclass class of PM
CREATE TABLE PMMedia (
    senderUserID       INT,
    reciverUserID      INT,
    subID              INT,
    filename           VARCHAR(15)    NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID, reciverUserID, subID) REFERENCES PM(senderUserID, reciverUserID, subID)
);

-- subclass class of PM
CREATE TABLE PMLink (
    senderUserID       INT,
    reciverUserID      INT,
    subID              INT,
    link               VARCHAR(2083)    NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID, reciverUserID, subID) REFERENCES PM(senderUserID, reciverUserID, subID)
);


-- subclass class of Comment
CREATE TABLE CommentMedia (
    postID              INT,
    subID               INT,
    filename            VARCHAR(15)     NOT NULL,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment(postID, subID)
);

-- subclass class of Comment
CREATE TABLE CommentLink (
    postID              INT,
    subID               INT,
    link                VARCHAR(2083)   NOT NULL,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment(postID, subID)
);



/*----------------------------------------------------
    Association classes
----------------------------------------------------*/

-- Association between User and Group
CREATE TABLE member (
    userID            INT,
    groupID           INT,
    nickname          VARCHAR(50),

    PRIMARY KEY (userID, groupID),

    FOREIGN KEY (userID)  REFERENCES _User(ID),
    FOREIGN KEY (groupID) REFERENCES Post(ID)
);

-- Association between User and Post
CREATE TABLE reactsToPost (
    userID          INT,
    postID          INT,
    type            INT     NOT NULL,

    PRIMARY KEY (userID, postID),

    FOREIGN KEY (userID) REFERENCES _User(ID),
    FOREIGN KEY (postID) REFERENCES Post(ID)
);



/*----------------------------------------------------
    Relations
----------------------------------------------------*/

-- relation between 2 Users
CREATE TABLE friend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES _User,
    FOREIGN KEY (user2ID) REFERENCES _User
);

-- relation between 2 Users
CREATE TABLE requestFriend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES _User,
    FOREIGN KEY (user2ID) REFERENCES _User
);

-- relation between a User of a Group and a role
create TABLE haveRole (
    userID            INT,
    groupID           INT,
    roleName          VARCHAR(50)       NOT NULL,

    PRIMARY KEY (userID, groupID),

    FOREIGN KEY (userID, groupID)    REFERENCES member,
    FOREIGN KEY (groupID, roleName)  REFERENCES Role
);
