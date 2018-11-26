/*----------------------------------------------------
    Base Classes
----------------------------------------------------*/

CREATE TABLE User (
    ID                  INT         PRIMARY KEY,
    name                VARCHAR(?),
    password            VARCHAR(?),
    email               VARCHAR(?)  UNIQUE,
    bio                 VARCHAR(150),
    birthday            DATE,
    avatarFilename      VARCHAR(?)  UNIQUE
);

CREATE TABLE Group (
    ID                  INT         PRIMARY KEY,
    name                VARCHAR(?),
    descrip             VARCHAR(?),
    visible             BOOLEAN,
    closed              BOOLEAN,
    ownerID             INT,

    FOREIGN KEYownerID REFERENCES User(ID)
);

CREATE TABLE Post (
    ID                  INT         PRIMARY KEY,
    postTime            TIMESTAMP,
    postText            VARCHAR(?),
    authorID            INT,

    FOREIGN KEYauthorID REFERENCES User(ID)
);




/*----------------------------------------------------
    Suport Classes
----------------------------------------------------*/

-- suport class of Post
CREATE TABLE Comment (
    postID              INT,
    subID               INT,
    textContent         INT,
    postTime            TIMESTAMP,
    authorID            INT,

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID)   REFERENCES Post
    FOREIGN KEY (authorID) REFERENCES User
);

-- suport class of Group
CREATE TABLE Role (
    groupID             INT,
    subID               INT,
    permitions          INT,
    color               INT,

    PRIMARY KEY (groupID, subID),

    FOREIGN KEY (groupID) REFERENCES Group
);

-- suport class of two Users
CREATE TABLE PM (
    sendUserID          INT,
    reciveUserID        INT,
    subID               INT,
    PMtext              VARCHAR(),

    PRIMARY KEY (sendUserID, reciveUserID, subID),

    FOREIGN KEY (groupID) REFERENCES Group
);




/*----------------------------------------------------
    SubClasses
----------------------------------------------------*/

-- subclass class of Post
CREATE TABLE SharePost (
    ID                  INT     PRIMARY KEY,
    shareID             INT,

    FOREIGN KEY (shareID) REFERENCES Post
);

-- subclass class of Post
CREATE TABLE ProfilePost (
    ID                  INT     PRIMARY KEY,
    profileID           INT,

    FOREIGN KEY (profileID) REFERENCES User
);

-- subclass class of Post
CREATE TABLE GroupPost (
    ID                  INT     PRIMARY KEY,
    profileID           INT,

    FOREIGN KEY (ID)        REFERENCES Group,
    FOREIGN KEY (profileID) REFERENCES User
);

-- subclass class of Post
CREATE TABLE PostMedia (
    ID              INT        PRIMARY KEY,
    filename        VARCHAR(),

    FOREIGN KEY (ID) REFERENCES Post
);

-- subclass class of Post
CREATE TABLE PostLink (
    ID                 INT     PRIMARY KEY,
    link               VARCHAR(2083),

    FOREIGN KEY (ID) REFERENCES Post
);


-- subclass class of PM
CREATE TABLE PMMedia (
    senderID           INT,
    reciverID          INT,
    subID              INT,
    filename           VARCHAR(),

    PRIMARY KEY (senderID, reciverID, subID),

    FOREIGN KEY (senderID)  REFERENCES User,
    FOREIGN KEY (reciverID) REFERENCES User
);

-- subclass class of PM
CREATE TABLE PMLink (
    senderID           INT,
    reciverID          INT,
    subID              INT,
    link               VARCHAR(2083),

    PRIMARY KEY (senderID, reciverID, subID),

    FOREIGN KEY (senderID)  REFERENCES User,
    FOREIGN KEY (reciverID) REFERENCES User
);


-- subclass class of Comment
CREATE TABLE CommentMedia (
    postID              INT,
    subID               INT,
    filename            VARCHAR(),

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment
);

-- subclass class of Comment
CREATE TABLE CommentLink (
    postID              INT,
    subID               INT,
    link                VARCHAR(2083),

    PRIMARY KEY (postID, subID),

    FOREIGN KEY (postID, subID) REFERENCES Comment
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

    FOREIGN KEY (userID)  REFERENCES User,
    FOREIGN KEY (groupID) REFERENCES Post
);

-- Association between User and Post
CREATE TABLE reactsToPost (
    userID          INT,
    postID          INT,
    type            INT,

    PRIMARY KEY (userID, postID),

    FOREIGN KEY (userID) REFERENCES User,
    FOREIGN KEY (postID) REFERENCES Post
);



/*----------------------------------------------------
    Relations
----------------------------------------------------*/

-- relation between 2 Users
CREATE TABLE friend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES User,
    FOREIGN KEY (user2ID) REFERENCES User
);

-- relation between 2 Users
CREATE TABLE requestFriend (
    user1ID           INT,
    user2ID           INT,

    PRIMARY KEY (user1ID, user2ID),

    FOREIGN KEY (user1ID) REFERENCES User,
    FOREIGN KEY (user2ID) REFERENCES User
);

-- relation between a User of a Group and a role
create TABLE haveRole (
    userID            INT,
    groupID           INT,
    roleName          VARCHAR(25),

    PRIMARY KEY (userID, groupID),

    FOREIGN KEY (userID, groupID)    REFERENCES member,
    FOREIGN KEY (groupID, roleName)  REFERENCES Role
);
