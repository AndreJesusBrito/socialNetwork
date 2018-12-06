/*----------------------------------------------------
    Base Classes
----------------------------------------------------*/

CREATE TABLE _User (
    ID               INT                          PRIMARY KEY,
    name             VARCHAR(50)     NOT NULL,
    city             VARCHAR(100),
    country          VARCHAR(50),
    email            VARCHAR(254)    NOT NULL     UNIQUE,
    password         VARCHAR(128)    NOT NULL,
    birthday         DATE,
    avatarFileName   VARCHAR(150)                 UNIQUE,
    bio              VARCHAR(350)
);

CREATE TABLE _Group (
    ID             INT                          PRIMARY KEY,
    name           VARCHAR(50)     NOT NULL,
    descrip        VARCHAR(350),
    visible        BOOLEAN         NOT NULL     DEFAULT true,
    closed         BOOLEAN         NOT NULL     DEFAULT false,
    ownerID        INT,

    FOREIGN KEY (ownerID) REFERENCES _User(ID)
      ON DELETE CASCADE
);

CREATE TABLE Post (
    ID             INT              PRIMARY KEY,
    postTime       TIMESTAMP        NOT NULL,
    postText       VARCHAR(5000),
    authorID       INT              NOT NULL,

    FOREIGN KEY (authorID) REFERENCES _User(ID)
      ON DELETE CASCADE
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

    FOREIGN KEY (postID)   REFERENCES Post(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (authorID) REFERENCES _User(ID)
      ON DELETE CASCADE
);

-- suport class of Group
CREATE TABLE Role (
    groupID             INT,
    name                varchar(50),
    permitions          INT         NOT NULL    DEFAULT 0,
    color               CHAR(7),

    PRIMARY KEY (groupID, name),

    FOREIGN KEY (groupID) REFERENCES _Group(ID)
      ON DELETE CASCADE
);

-- suport class of two Users
CREATE TABLE PM (
    senderUserID        INT,
    reciverUserID       INT,
    subID               INT,
    textContent         VARCHAR(500),
    postTime            TIMESTAMP       NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID)  REFERENCES _User(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (reciverUserID) REFERENCES _User(ID)
      ON DELETE CASCADE
);




/*----------------------------------------------------
    SubClasses
----------------------------------------------------*/

-- subclass class of Post
CREATE TABLE SharePost (
    ID                      INT     PRIMARY KEY,
    shareID                 INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (shareID)   REFERENCES Post(ID)
      ON DELETE CASCADE
);

-- subclass class of Post
CREATE TABLE ProfilePost (
    ID                      INT     PRIMARY KEY,
    profileID               INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (profileID) REFERENCES _User(ID)
      ON DELETE CASCADE
);

-- subclass class of Post
CREATE TABLE GroupPost (
    ID                      INT     PRIMARY KEY,
    groupID                 INT     NOT NULL,

    FOREIGN KEY (ID)        REFERENCES Post(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (groupID)   REFERENCES _Group(ID)
      ON DELETE CASCADE
);

-- subclass class of Post
CREATE TABLE PostMedia (
    ID              INT             PRIMARY KEY,
    filename        VARCHAR(15)     NOT NULL,

    FOREIGN KEY (ID) REFERENCES Post(ID)
      ON DELETE CASCADE
);

-- subclass class of Post
CREATE TABLE PostLink (
    ID      INT                PRIMARY KEY,
    link    VARCHAR(2083)      NOT NULL,

    FOREIGN KEY (ID) REFERENCES Post(ID)
      ON DELETE CASCADE
);


-- subclass class of PM
CREATE TABLE PMMedia (
    senderUserID       INT,
    reciverUserID      INT,
    subID              INT,
    filename           VARCHAR(15)    NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID, reciverUserID, subID) REFERENCES PM(senderUserID, reciverUserID, subID)
      ON DELETE CASCADE
);

-- subclass class of PM
CREATE TABLE PMLink (
    senderUserID       INT,
    reciverUserID      INT,
    subID              INT,
    link               VARCHAR(2083)    NOT NULL,

    PRIMARY KEY (senderUserID, reciverUserID, subID),

    FOREIGN KEY (senderUserID, reciverUserID, subID) REFERENCES PM(senderUserID, reciverUserID, subID)
      ON DELETE CASCADE
);


-- subclass class of Comment
CREATE TABLE CommentMedia (
    postID              INT,
    subID               INT,
    filename            VARCHAR(15)     NOT NULL,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment(postID, subID)
      ON DELETE CASCADE
);

-- subclass class of Comment
CREATE TABLE CommentLink (
    postID              INT,
    subID               INT,
    link                VARCHAR(2083)   NOT NULL,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment(postID, subID)
      ON DELETE CASCADE
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

    FOREIGN KEY (userID)  REFERENCES _User(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (groupID) REFERENCES Post(ID)
      ON DELETE CASCADE
);

-- Association between User and Post
CREATE TABLE reactsToPost (
    userID          INT,
    postID          INT,
    type            INT     NOT NULL,

    PRIMARY KEY (userID, postID),

    FOREIGN KEY (userID) REFERENCES _User(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (postID) REFERENCES Post(ID)
      ON DELETE CASCADE
);



/*----------------------------------------------------
    Relations
----------------------------------------------------*/

-- relation between 2 Users
CREATE TABLE friend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES _User(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (user2ID) REFERENCES _User(ID)
      ON DELETE CASCADE
);

-- relation between 2 Users
CREATE TABLE requestFriend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES _User(ID)
      ON DELETE CASCADE,

    FOREIGN KEY (user2ID) REFERENCES _User(ID)
      ON DELETE CASCADE
);

-- relation between a User of a Group and a role
create TABLE haveRole (
    userID            INT,
    groupID           INT,
    roleName          VARCHAR(50)       NOT NULL,

    PRIMARY KEY (userID, groupID),

    FOREIGN KEY (userID, groupID)    REFERENCES member(userID, groupID)
      ON DELETE CASCADE,

    FOREIGN KEY (groupID, roleName)  REFERENCES Role(groupID, name)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);
