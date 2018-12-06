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