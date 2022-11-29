-- Active: 1668645566760@@127.0.0.1@5432@TP4_Livraison
#4.1
SELECT DISTINCT numeroClient, nomClient 
FROM Client NATURAL JOIN Abonner NATURAL JOIN Planrepas  
WHERE prix BETWEEN 20 AND 40;

#4.2
SELECT DISTINCT numeroPlan
FROM Planrepas NATURAL JOIN Fournisseur
WHERE nomFournisseur <> 'QC Transport';

#4.3
SELECT DISTINCT numeroPlan
FROM Planrepas
WHERE categorie = 'cétogène';

#4.4
SELECT COUNT(*)
FROM Fournisseur
WHERE nomFournisseur IS NULL;

#4.5
SELECT DISTINCT nomFournisseur
FROM Fournisseur NATURAL JOIN Planrepas
WHERE PRIX > ALL (SELECT PRIX 
FROM Fournisseur NATURAL JOIN Planrepas
WHERE nomFournisseur = 'AB Transport');

#4.6
SELECT f.nomFournisseur, f.adresseFournisseur, SUM(p.prix) AS prixTotalLivraison
FROM Fournisseur f NATURAL JOIN Planrepas p
GROUP BY f.nomFournisseur, f.adresseFournisseur
ORDER BY prixTotalLivraison desc
LIMIT 2;

#4.7
SELECT COUNT(*)
FROM Kitrepas k
WHERE k.numeroKitrepas NOT IN (
    SELECT k.numeroKitrepas
    FROM Kitrepas NATURAL JOIN Planrepas NATURAL JOIN Abonner
);

#4.8
SELECT DISTINCT c.numeroClient, c.nomClient, c.prenomClient
FROM Client c
WHERE LEFT(c.prenomClient, 1) NOT IN ('a', 'e', 'i', 'o', 'u', 'y', 'A', 'E', 'I', 'O', 'U', 'Y')
AND c.villeClient = (SELECT DISTINCT f.adresseFournisseur
FROM Fournisseur f
WHERE f.nomFournisseur = 'Benjamin')
ORDER BY c.nomClient ASC;

#4.9
SELECT i.paysIngredient, COUNT(i.paysIngredient)
FROM Ingredient i
WHERE i.paysIngredient NOT LIKE '%g__' AND i.paysIngredient NOT LIKE '%G__'
GROUP BY i.paysIngredient
ORDER BY i.paysIngredient DESC;

#4.10
CREATE VIEW V_fournisseur(V_categorie, V_adresse, V_tot) AS
    SELECT p.categorie, f.adresseFournisseur, SUM(p.prix) AS totalprix
    FROM Planrepas p NATURAL JOIN Fournisseur f
    GROUP BY p.categorie, f.adresseFournisseur
        HAVING SUM(p.prix) > 12500
        AND p.categorie LIKE '%e%'
        AND p.categorie LIKE '%o__'
    ORDER BY p.categorie ASC, totalprix DESC;