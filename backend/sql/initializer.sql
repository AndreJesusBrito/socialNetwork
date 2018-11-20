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
    avatarFilename      VARCHAR(?) -- TO CHECK LATER
);

CREATE TABLE Group (
    ID                  INT         PRIMARY KEY,
    name                VARCHAR(?),
    descrip             VARCHAR(?),
    visible             BOOLEAN,
    closed              BOOLEAN,
    ownerID             INT,

    FOREIGN KEY ownerID REFERENCES User(ID)
);

CREATE TABLE Post (
    ID                  INT         PRIMARY KEY,
    postTime            TIMESTAMP,
    postText            VARCHAR(?),

    authorID            INT,
    FOREIGN KEY authorID REFERENCES User(ID)
);




/*----------------------------------------------------
    Suport Classes
----------------------------------------------------*/

-- suport class of Post
CREATE TABLE Comment (
    groupID             INT,
    subID               INT,
    textContent:        INT,
    postTime            TIMESTAMP,
    authorID            INT,

    PRIMARY KEY(groupID, subID),
    FOREIGN KEY(postID) REFERENCES Post
    FOREIGN KEY(authorID) REFERENCES User
);

-- suport class of Group
CREATE TABLE Role (
    groupID             INT,
    subID               INT,
    permitions:         INT,
    color               INT,

    PRIMARY KEY(groupID, subID),
    FOREIGN KEY(groupID) REFERENCES Group
);




/*----------------------------------------------------
    SubClasses
----------------------------------------------------*/

-- subclass class of Post
CREATE TABLE SharePost (
    ID                  INT     PRIMARY KEY,
    shareID             INT,

    FOREIGN KEY(shareID) REFERENCES Post
);

-- subclass class of Post
CREATE TABLE ProfilePost (
    ID                  INT     PRIMARY KEY,
    profileID           INT,

    FOREIGN KEY(profileID) REFERENCES User
);

-- subclass class of Post
CREATE TABLE GroupPost (
    ID                  INT     PRIMARY KEY,
    profileID           INT,

    FOREIGN KEY(profileID) REFERENCES User
);

-- subclass class of Post
CREATE TABLE PostMedia (

);

-- subclass class of Post
CREATE TABLE PostLink (

);


-- subclass class of PM
CREATE TABLE PMMedia (

);

-- subclass class of PM
CREATE TABLE PMLink (

);


-- subclass class of Comment
CREATE TABLE CommentMedia (

);

-- subclass class of Comment
CREATE TABLE CommentLink (

);



/*----------------------------------------------------
    Association classes
----------------------------------------------------*/

-- Association between User and Group
CREATE TABLE member (

);

-- Association between User and Post
CREATE TABLE member (

);

/*----------------------------------------------------
    Relations
----------------------------------------------------*/

-- relation between 2 Users
CREATE TABLE friend (

);

-- relation between 2 Users
CREATE TABLE requestFriend (

);

-- relation between a User and a
create TABLE haveRole (

);
