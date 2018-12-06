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