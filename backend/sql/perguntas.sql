-- ID of all frineds of a User
(
    SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
) UNION (
    SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
);


-- amigos que vivem numa localidade (ordenadas por cidade e depois país)
SELECT *
FROM
(
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
    )
) NATURAL JOIN _User
WHERE country=(PUT__HERE) AND city=(PUT__HERE2);

-- SELECT u.id,u.name,u.city,country,G.name
-- FROM
--     _User AS U
-- INNER JOIN
--     _Group AS G
-- ON G.ownerId = U.id
-- GROUP BY U.id, G.name
-- ORDER BY U.id;


-- get the IDs of friends of a User that reacted to a post
SELECT userID
FROM reactsToPost
WHERE userID IN (
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
    )
)


-- toda a atividade de um User (sorted by time)


-- get all group's IDs that a User is (sorted)
SELECT groupID AS ID
FROM member
WHERE userID=(PUT__HERE)
ORDER BY name


-- get members Ids in a Group
SELECT * FROM
(
    SELECT userID AS ID, groupID
    FROM _member
    WHERE groupID=(PUT__HERE)
) NATURAL JOIN (
    SELECT ID FROM _User
);


-- number of members in a Group
SELECT COUNT(groupID) AS "nº users"
FROM member
WHERE groupID=(PUT__HERE);


-- get activity of a User in a Group


-- number of reactions in a post by type
SELECT type AS reactionType, COUNT(*) FROM reactsToPost WHERE postID=(PUT__HERE) GROUP BY type;


-- get all SharePosts FROM a table of Posts
SELECT * FROM Post NATURAL JOIN SharePosts;

-- get all IDs FROM each group's creator
SELECT U.ID AS "User ID",    U.name AS "User Name",    G.ID AS "Group ID",    G.name AS "Group ID"
FROM
    _User AS U
INNER JOIN
    _Group AS G
ON G.ownerId = U.id
GROUP BY U.id, G.name
ORDER BY U.id;


-- get all users that have a nickname in a group
SELECT userID AS ID FROM member
WHERE nickname IS NOT NULL;


-- number of posts that each user has writen in a group
SELECT ID AS "User ID", COUNT(*) AS "nº of posts"
FROM
    Post
NATURAL JOIN (
    -- get all post in the selected group
    SELECT ID FROM GroupPost
    WHERE groupID=(PUT__HERE)
)
GROUP BY ID
ORDER BY "nº of posts";



SELECT a.groupID, b."group name", b."group owner", a."n members"
FROM
(
    SELECT groupID, Count(groupID) AS "n members"
    FROM member
    GROUP BY groupID
) JOIN (
    SELECT U.id, U.name AS "group owner", G.ownerID, G.name AS "group name"
    FROM _Group AS G
    INNER JOIN _User AS U
    ON U.id = G.ownerID
)
ON b.id = a.groupID

-- get all friends of a user in a age range



-- get all posts ordered by the balance of likes and dislikes
SELECT ID FROM POST NATURAL JOIN

SELECT postID, COUNT(type) FROM reactsToPost
GROUP BY postID





/*------------------------------
  good stuff goes here xD
------------------------------*/

-- ID of all common friends between two Users
(
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=(213)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=(213)
    )
) INTERSECT (
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=225
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=225
    )
);


-- get posts that should appear in the feed of a User  -  posts of groups and friends
SELECT id,posttime FROM post WHERE id IN (
    (
        (   -- get all posts FROM friends that are visible
            SELECT ID
            FROM Post
            WHERE authorID IN (
                -- get IDs of all friends of a User
                (
                    SELECT user2ID AS ID FROM friend WHERE user1ID=(109)
                ) UNION (
                    SELECT user1ID AS ID FROM friend WHERE user2ID=(109)
                )
            )
        ) UNION (
            -- get all posts IDs FROM groups that the user is in
            SELECT ID
            FROM GroupPost
            where groupID IN (
                SELECT groupID AS ID
                FROM member
                WHERE userID=(109)
            )
        )
    ) EXCEPT (
        -- remove the post written by the User himself
        SELECT ID FROM
        GroupPost NATURAL JOIN Post
        WHERE authorID=(109)
    )
) ORDER BY postTime;
