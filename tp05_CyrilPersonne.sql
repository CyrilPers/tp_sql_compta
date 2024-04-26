SELECT * FROM article a
ORDER BY a.DESIGNATION ASC;
SELECT * FROM article a
ORDER BY a.PRIX  DESC;
SELECT * FROM article a
WHERE a.DESIGNATION LIKE "boulon%"
ORDER BY a.PRIX ASC;
SELECT * FROM article a
WHERE a.DESIGNATION LIKE "%sachet%"
ORDER BY a.PRIX ASC;
SELECT * FROM article a
WHERE lower(a.DESIGNATION) LIKE "%sachet%"
ORDER BY a.PRIX ASC;
SELECT * FROM article a 
JOIN fournisseur f ON f.id = ID_FOU 
ORDER BY f.nom ASC, a.prix DESC;
SELECT * FROM article a 
WHERE a.ID_FOU = 3;
SELECT AVG(a.PRIX) AS moyenne_prix_article FROM article a
WHERE a.ID_FOU = 3;
SELECT f.NOM AS nom_fournisseur, AVG(a.PRIX) AS moyenne_prix_article FROM article a
JOIN fournisseur f ON f.id = a.ID_FOU
GROUP BY f.NOM;
SELECT * FROM bon b 
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';
SELECT bon FROM bon b
JOIN compo c ON c.ID_BON = b.ID 
JOIN article a ON c.ID_ART = a.ID 
WHERE lower(a.DESIGNATION) LIKE 'boulon%';
SELECT b.ID , b.NUMERO , b.DATE_CMDE , b.DELAI, f.NOM AS nom_fournisseur, a.DESIGNATION AS nom_article FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
JOIN fournisseur f ON f.ID = a.ID_FOU 
WHERE lower(a.DESIGNATION) LIKE 'boulon%';
SELECT b.ID , b.NUMERO , b.DATE_CMDE , b.DELAI, SUM(c.QTE * a.PRIX) AS total_bon FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
GROUP BY b.id;
SELECT b.NUMERO AS numéro_bon_commande, SUM(c.QTE) AS quantité_article FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
GROUP BY b.id;

SELECT b.ID , b.NUMERO , b.DATE_CMDE , b.DELAI, SUM(c.QTE) AS quantité_article FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
GROUP BY b.id
HAVING quantité_article > 25;

SELECT SUM(c.QTE * a.PRIX) AS total_commande_avril FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
WHERE b.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30'

SELECT a.ID , a.DESIGNATION FROM article a 
JOIN article a2 ON a.DESIGNATION = a2.DESIGNATION 
WHERE a2.ID_FOU != a.ID_FOU;

SELECT MONTHNAME(b.DATE_CMDE) AS MOIS, SUM(c.QTE * a.PRIX) AS total_commande FROM bon b
JOIN compo c ON  b.id = c.ID_BON
JOIN article a ON c.ID_ART = a.ID 
GROUP BY MOIS;

SELECT * FROM bon b
WHERE NOT EXISTS (
	SELECT *
    FROM compo c
    WHERE c.ID_BON  = b.id
);

SELECT f.NOM AS nom_fournisseur, AVG(total_commande) AS commande_moyenne
FROM ( 
	SELECT a.ID_FOU AS idFou, b.ID, SUM(c.QTE * a.PRIX) AS total_commande FROM bon b
	JOIN compo c ON b.id = c.ID_BON
	JOIN article a ON c.ID_ART = a.ID 
	GROUP BY b.ID, a.ID_FOU
) AS total
JOIN fournisseur f ON total.idFou = f.ID
GROUP BY f.NOM;

