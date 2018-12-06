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