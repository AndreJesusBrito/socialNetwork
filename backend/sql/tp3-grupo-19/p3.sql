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