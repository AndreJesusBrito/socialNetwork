-- ID of all frineds of a User  - NOT TESTED
(
    SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
) UNION (
    SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
);


-- ID of all common friends between two Users - NOT TESTED
(
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
    )
) INTERSECT (
    (
        SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE2)
    ) UNION (
        SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE2)
    )
);


-- ID of posts that should appear in the feed of a User  -  posts of groups and friends
(
    -- get all posts FROM friends that are visible
    SELECT ID
    FROM Post
    WHERE authorID IN (
        -- get IDs of all friends of a User
        (
            SELECT user2ID AS ID FROM friend WHERE user1ID=(PUT__HERE)
        ) UNION (
            SELECT user1ID AS ID FROM friend WHERE user2ID=(PUT__HERE)
        )
    )
) UNION (
    -- get all posts IDs FROM groups that the user is in
    SELECT groupID AS ID
    FROM member
    WHERE userID=(PUT__HERE)
);


-- amigos que vivem numa localidade (ordenadas por cidade e depois país)
SELECT I.id,I.name,I.city,I.country,U.name
FROM
    _User AS U
INNER JOIN
    _Group AS G
ON G.ownerId = U.id
GROUP BY U.id, G.name
Order by U.id;

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



SELECT * FROM
    (SELECT * FROM estudios) AS t1
NATURAL JOIN
    (SELECT nomeestudio AS nome FROM filmes) AS t2;




-- toda a atividade de um User (sorted by time)


-- all post that a user can see in the feed



-- get all groups(and roles) in which a User is (sorted)
ORDER BY (DESC)


-- get members in a Group
(SELECT * FROM _member WHERE userID) NATURAL JOIN (SELECT * FROM _User);



-- get activity of a User in a Group -send help


-- number of reactions in a post
SELECT type AS reactionType, COUNT(*) FROM reactsToPost WHERE groupID=(PUT__HERE) GROUP BY type;


-- get all SharePosts from a table of Posts
