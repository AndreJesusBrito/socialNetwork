-- amigos de um user - NOT TESTED
(
    SELECT user2ID FROM friend WHERE user1ID=(PUT__HERE)
) UNION (
    SELECT user1ID FROM friend WHERE user2ID=(PUT__HERE)
);




-- amigos em comum
(
    (
        SELECT user2ID FROM friend WHERE user1ID=(PUT__HERE)
    ) UNION (
        SELECT user1ID FROM friend WHERE user2ID=(PUT__HERE)
    )
) INTERSECT (
    (
        SELECT user2ID FROM friend WHERE user1ID=(PUT__HERE2)
    ) UNION (
        SELECT user1ID FROM friend WHERE user2ID=(PUT__HERE2)
    )
);


-- posts para aparecer no feed de um User  -  posts de grupos e amigos



-- amigos que vivem numa localidade (ordenadas por cidade e depois país)



-- amigos de um User que reagiram a um post

(

) INNER JOIN (
    select * from _User
)



-- toda a atividade de um User (por ordem cronologica)



-- todos os grupos(e roles) em que um User está (por ordem)



-- get members in a Group
(SELECT * FROM _member WHERE userID) JOIN (SELECT * FROM _User)



-- get activity of a User in a Group -send help


-- number of reactions in a post
SELECT type as reactionType, COUNT(*) FROM reactsToPost WHERE groupID=(PUT__HERE) GROUP BY type
