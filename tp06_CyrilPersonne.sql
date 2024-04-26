UPDATE article a
SET DESIGNATION = upper(a.DESIGNATION)
WHERE a.ID = 2;

UPDATE article a
SET DESIGNATION = upper(a.DESIGNATION)
WHERE a.PRIX > 10;

UPDATE article a
SET PRIX = a.prix*0.9
WHERE NOT EXISTS (
	SELECT *
    FROM compo c
    WHERE c.ID_ART = a.id
);

UPDATE compo c
JOIN article a ON c.ID_ART = a.ID 
SET QTE = c.QTE * 2
WHERE a.ID_FOU = 1;

UPDATE article a
SET DESIGNATION =
WHERE a.DESIGNATION LIKE '%(%' AND '%)'