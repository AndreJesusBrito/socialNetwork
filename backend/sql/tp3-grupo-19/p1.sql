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