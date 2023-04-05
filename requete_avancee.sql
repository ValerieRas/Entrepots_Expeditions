
--Affichez les entrepôts qui ont envoyé au moins une expédition en transit.

SELECT
	nom_entrepot
FROM
	entrepots ent
INNER JOIN 
	expeditions expe
	ON ent.id=expe.id_entrepot_source
WHERE 
	statut='en transit';

-- Affichez les entrepôts qui ont reçu au moins une expédition en transit.

SELECT
	nom_entrepot
FROM
	entrepots ent
INNER JOIN 
	expeditions expe
	ON ent.id=expe.id_entrepot_destination
WHERE 
	statut='en transit';

--Affichez les expéditions qui ont un poids supérieur à 100 kg et qui sont en transit.
SELECT 
	*
FROM
	expeditions
WHERE 
	poids>100 AND statut='en transit';


--Affichez le nombre d'expéditions envoyées par chaque entrepôt.
SELECT
	nom_entrepot,
	count(expe.id_entrepot_source) as nombre_expedition
FROM
	entrepots ent
INNER JOIN 
	expeditions expe
	ON ent.id=expe.id_entrepot_source
GROUP BY nom_entrepot;


--Affichez le nombre total d'expéditions en transit.
SELECT 
	count(*) as nombre_total_transit
FROM
	expeditions
WHERE 
	statut='en transit';


--Affichez le nombre total d'expéditions livrées.
SELECT 
	count(*) as nombre_total_arrivee
FROM
	expeditions
WHERE 
	statut='arriver';

--Affichez le nombre total d'expéditions pour chaque mois de l'année en cours.

	--changement des annees en 2023 
	UPDATE expeditions SET date_expedition=REPLACE(date_expedition,YEAR(date_expedition),'2023');
	-- 

SELECT 
	MONTH(date_expedition) as mois,
	count(*) as nombre_total
FROM
	expeditions
WHERE YEAR(date_expedition)=YEAR(getdate())
GROUP BY MONTH(date_expedition);


--Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours.
SELECT
	nom_entrepot
FROM
	entrepots ent
INNER JOIN 
	expeditions expe
	ON ent.id=expe.id_entrepot_source
WHERE 
	day(date_expedition)-day(getdate())<30
GROUP BY nom_entrepot;


--Affichez les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours.
SELECT
	nom_entrepot
FROM
	entrepots ent
INNER JOIN 
	expeditions expe
	ON ent.id=expe.id_entrepot_destination
WHERE 
	statut='arriver' AND
	day(date_expedition)-day(getdate())<30
GROUP BY nom_entrepot;



--Affichez les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables

SELECT 
	*
FROM
	expeditions
WHERE
	statut='arriver' 
	AND DATEPART(weekday, date_expedition) NOT IN (7,6) AND DATEDIFF(day, date_expedition, GETDATE())<=5;


SELECT *
FROM (
		SELECT *
		FROM
			expeditions
		WHERE
		DATEPART(weekday, date_expedition) NOT IN (7,6)
	) as JOUR_OUVRABLE
WHERE
	JOUR_OUVRABLE.statut='arriver' 
	AND DATEDIFF(day, JOUR_OUVRABLE.date_expedition, DATEPART(weekday,GETDATE()))<=5;	



--
SELECT * FROM entrepots;
SELECT * FROM EXPEDITIONS;

UPDATE expeditions SET date_expedition=REPLACE(date_expedition,YEAR(date_expedition),'2023');

UPDATE expeditions SET date_expedition= DATEADD(year, -1, date_expedition);

