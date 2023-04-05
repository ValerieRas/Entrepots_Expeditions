--Affichez les expéditions en transit qui ont été initiées par un entrepôt situé en Europe et à destination d'un entrepôt situé en Asie.

--(requête en plus pour l'execution des requêtes suivantes) ajout d'une colonne continent dans entrepots
ALTER TABLE entrepots
ADD continent VARCHAR(20);

UPDATE entrepots SET continent='europe' WHERE pays IN ('France','Angleterre','Autriche')
UPDATE entrepots SET continent='AFRIQUE' WHERE pays='Maroc'
UPDATE entrepots SET continent='Amerique' WHERE pays='Etats-unis'

INSERT INTO entrepots (nom_entrepot, adresse, ville, pays, continent)
VALUES 
('SingapourInc.','123 rue singapour','Singapour','Singapour','Asie'),
('Bangkok','123 rue bangkok','Bangkok','Thaïlande','Asie'),
('los Angels', '20 8 Avenue', 'Los Angeles', 'Etats-Unis', 'Amerique');

INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut)
VALUES
    ('2023-03-20', 8, 4, 1200, 'en transit'),
    ('2023-03-21', 3, 7, 180.6, 'en transit'),
    ('2023-03-28',4,6,40,'arriver');

--affichage des expeditions d'europe en destination d'Asie
SELECT 
	*
FROM
	expeditions expe
INNER JOIN entrepots entrs
	ON expe.id_entrepot_source=entrs.id
INNER JOIN entrepots entrd
	ON expe.id_entrepot_destination=entrd.id
WHERE entrs.continent='europe' AND entrd.continent='Asie';


--Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays.
SELECT 
	*
FROM
	expeditions expe
INNER JOIN entrepots entrs
	ON expe.id_entrepot_source=entrs.id
INNER JOIN entrepots entrd
	ON expe.id_entrepot_destination=entrd.id
WHERE entrs.pays=entrd.pays;

--Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent.

--Affichez les expéditions en transit qui ont été initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et qui pèsent plus de 500 kg.


--Affichez le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination.

SELECT 
	e1.pays AS pays_origine, 
	e2.pays AS pays_destination, 
	COUNT(*) AS nb_expeditions
FROM 
	entrepots e1
JOIN expeditions ex ON ex.id_entrepot_source = e1.id
JOIN entrepots e2 ON ex.id_entrepot_destination = e2.id
GROUP BY e1.pays, e2.pays;

--Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 1000 kg.


--Affichez les expéditions qui ont été livrées avec un retard de plus de 2 jours ouvrables.


--Affichez le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant.


SELECT * FROM entrepots;
select * FROM expeditions;