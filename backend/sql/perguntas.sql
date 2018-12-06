-- ID of all frineds of a User
(
    SELECT user2ID AS ID FROM friend WHERE user1ID = (PUT__HERE)
) UNION (
    SELECT user1ID AS ID FROM friend WHERE user2ID = (PUT__HERE)
);

-- amigos que vivem numa localidade (ordenadas por cidade e depois país)
SELECT *
FROM
(
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID = (PUT__HERE)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID = (PUT__HERE)
    )
) NATURAL JOIN _User
WHERE country = (PUT__HERE) AND city = (PUT__HERE2);

-- SELECT u.id,u.name,u.city,country,G.name
-- FROM
--     _User AS U
-- JOIN
--     _Group AS G
-- ON G.ownerId  =  U.id
-- GROUP BY U.id, G.name
-- ORDER BY U.id;


-- get the IDs of friends of a User that reacted to a post
SELECT userID
FROM reactsToPost
WHERE userID IN (
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID = (PUT__HERE)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID = (PUT__HERE)
    )
)


-- toda a atividade de um User (sorted by time)


-- get all GROUP's IDs that a User is (sorted)
SELECT groupID AS ID
FROM member
WHERE userID = (PUT__HERE)
ORDER BY name


-- get members Ids in a Group
SELECT * FROM
(
    SELECT userID AS ID, groupID
    FROM _member
    WHERE groupID = (PUT__HERE)
) NATURAL JOIN (
    SELECT ID FROM _User
);


-- number of members in a Group
SELECT COUNT(groupID) AS "n users"
FROM member
WHERE groupID = (PUT__HERE);


-- get activity of a User in a Group


-- number of reactions in a post by type
SELECT type AS reactionType, COUNT(*) FROM reactsToPost WHERE postID = (PUT__HERE) GROUP BY type;


-- get all SharePosts FROM a table of Posts
SELECT * FROM Post NATURAL JOIN SharePosts;

-- get all IDs FROM each GROUP's creator
SELECT U.ID AS "User ID",    U.name AS "User Name",    G.ID AS "Group ID",    G.name AS "Group ID"
FROM
    _User AS U
JOIN
    _Group AS G
ON G.ownerId  =  U.id
GROUP BY U.id, G.name
ORDER BY U.id;


-- get all users that have a nickname in a GROUP
SELECT userID AS ID FROM member
WHERE nickname IS NOT NULL;


-- number of posts that each user has writen in a GROUP
SELECT ID AS "User ID", COUNT(*) AS "n of posts"
FROM
    Post
NATURAL JOIN (
    -- get all post in the selected GROUP
    SELECT ID FROM GroupPost
    WHERE groupID = 101
)
GROUP BY ID
ORDER BY "n of posts";


SELECT a.id, a.name, a."n posts", b."n comment" from
(
    SELECT U.id,U.name,Count(U.name) AS "number of posts"
    FROM
    _User AS U  JOIN  Post AS P
    ON P.authorID = U.id
    GROUP BY u.id
) AS a
JOIN
(
    SELECT d.id, d.name, Count(D.name) AS "number of comment"
    FROM
        _User AS D
    JOIN
        Comment AS C
    ON C.authorID = D.id
    GROUP BY D.id
) AS b
ON a.id = b.id
ORDER BY a.name







SELECT a.groupid, b."group name", b."group owner", a."group members" from
(
    SELECT m.groupid,Count(m.groupid) AS "group members"
    FROM member AS m
    GROUP BY m.groupid
) AS a
join
(
    SELECT U.id, u.name AS "group owner", G.id AS GID , g.name AS "group name"
    FROM _Group AS G
    INNER JOIN _User AS U
    ON u.id = g.ownerID
) AS b
ON b.gid = a.groupid
ORDER BY a."group members" DESC,b."group owner" ASC, "group name" ASC;






SELECT a.groupID, b."GROUP name", b."GROUP owner", a."n members"
FROM
(
    SELECT groupID, Count(groupID) AS "n members"
    FROM member
    GROUP BY groupID
) JOIN (
    SELECT U.id, U.name AS "GROUP owner", G.ownerID, G.name AS "GROUP name"
    FROM _Group AS G
    JOIN _User AS U
    ON U.id  =  G.ownerID
)
ON b.id  =  a.groupID

-- get all friends of a user in a age range



-- get all posts ordered by the balance of likes and dislikes
SELECT ID FROM POST NATURAL JOIN

SELECT postID, COUNT(type) FROM reactsToPost
GROUP BY postID





/*------------------------------
  good stuff goes here xD
------------------------------*/

-- 1)
-- ID of all common friends between two Users
(
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID = 213
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID = 213
    )
) INTERSECT (
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID = 225
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID = 225
    )
);

-- 2)


-- 3)
-- get number of reactions of a post
SELECT postid, likes, dislikes FROM
(
    SELECT postid, count(type) AS likes
    FROM reactstopost
    WHERE type = 0
    GROUP BY postid
) AS A
NATURAL JOIN
(
    SELECT postid, count(type) AS dislikes
    FROM reactstopost
    WHERE type = 1
    GROUP BY postid
) AS B
order BY postid




-- 4)
SELECT a.id, a.name, a."n posts", b."n comment" from
(
    SELECT U.id,U.name,Count(U.name) AS "n posts"
    FROM
    _User AS U  JOIN  Post AS P
    ON P.authorID = U.id
    GROUP BY u.id
) AS a
JOIN
(
    SELECT d.id, d.name, Count(D.name) AS "n comment"
    FROM
        _User AS D
    JOIN
        Comment AS C
    ON C.authorID = D.id
    GROUP BY D.id
) AS b
ON a.id = b.id
ORDER BY a.name


-- 5)

-- get IDs of the posts that should appear in the feed of a User  -  posts of groups and friends
SELECT ID FROM post WHERE id IN (
    (
        (   -- get all posts FROM friends that are visible
            SELECT ID
            FROM Post
            WHERE authorID IN (
                -- get IDs of all friends of a User
                (
                    SELECT user2ID AS ID FROM friend WHERE user1ID = 109
                ) UNION (
                    SELECT user1ID AS ID FROM friend WHERE user2ID = 109
                )
            )
        ) UNION (
            -- get all posts IDs FROM groups that the user is in
            SELECT ID
            FROM GroupPost
            WHERE groupID IN (
                SELECT groupID AS ID
                FROM member
                WHERE userID = 109
            )
        )
    ) EXCEPT (
        -- remove the post written by the User imself
        SELECT ID FROM
        GroupPost NATURAL JOIN Post -- a user is not friend of itself, so
        WHERE authorID = 109        -- the all posts to remove are from groups
    )
) ORDER BY postTime DESC;
