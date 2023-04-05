
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

---marche mais compte le weekend---
SELECT 
	*
FROM
	expeditions
WHERE
	statut='arriver' 
	AND DATEPART(weekday, date_expedition) NOT IN (7,6) AND DATEDIFF(day, date_expedition, GETDATE())<=5;

---marche mais compte le weekend---
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


---marche mais compte le weekend---
SELECT *
FROM expeditions
WHERE DATEDIFF(DAY, date_expedition, GETDATE()) <= 5
AND DATEDIFF(WEEK, date_expedition, GETDATE()) * 2 +
    CASE WHEN DATEPART(WEEKDAY, date_expedition) = 7 THEN 1 ELSE 0 END +
    CASE WHEN DATEPART(WEEKDAY, GETDATE()) = 1 THEN 1 ELSE 0 END <= 5
AND statut = 'arriver';


---marche mais compte le weekend et azu dela de 5jours---
CREATE FUNCTION fn_remove_weekend (@inputDate DATE)
RETURNS DATE
AS
BEGIN
    DECLARE @outputDate DATE = @inputDate

    -- Retire le samedi
    WHILE DATEPART(WEEKDAY, @outputDate) = 7
        SET @outputDate = DATEADD(DAY, 1, @outputDate)

    -- Retire le dimanche
    WHILE DATEPART(WEEKDAY, @outputDate) = 1
        SET @outputDate = DATEADD(DAY, 1, @outputDate)

    RETURN @outputDate
END

SELECT *
FROM expeditions
WHERE DATEDIFF(day, dbo.fn_remove_weekend(GETDATE()), date_expedition) <= 5
  AND DATEDIFF(day, dbo.fn_remove_weekend(date_expedition), date_expedition) <= 5
  AND statut = 'arriver'


---marche mais compte le weekend---

CREATE FUNCTION dbo.fn_rm_weekend (@inputDate DATE)
RETURNS DATE
AS
BEGIN
    DECLARE @outputDate DATE = @inputDate

    -- Retire le samedi
    WHILE DATEPART(WEEKDAY, @outputDate) = 7
        SET @outputDate = DATEADD(DAY, 1, @outputDate)

    -- Retire le dimanche
    WHILE DATEPART(WEEKDAY, @outputDate) = 1
        SET @outputDate = DATEADD(DAY, 1, @outputDate)

    RETURN @outputDate
END


SELECT *
FROM expeditions
WHERE DATEDIFF(d, dbo.fn_remove_weekend(date_expedition), GETDATE()) <= 5
  AND DATEDIFF(d, dbo.fn_remove_weekend(GETDATE()), dbo.fn_remove_weekend(date_expedition)) <= 5 
  AND statut = 'arriver';

CREATE FUNCTION expeditions_inf_5_jours_ouvrables()
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM expeditions
    WHERE statut = 'arriver'
      AND DATEDIFF(WEEKDAY, date_expedition, GETDATE()) < 5
);

SELECT * FROM expeditions_inf_5_jours_ouvrables();


----

SELECT *
FROM expeditions
WHERE date_expedition >= DATEADD(dd, -4, GETDATE())
AND DATEDIFF(dd, date_expedition, GETDATE()) - 
    (DATEDIFF(wk, date_expedition, GETDATE()) * 2) -
    CASE WHEN DATENAME(dw, date_expedition) = 'Sunday' THEN 1 ELSE 0 END -
    CASE WHEN DATENAME(dw, GETDATE()) = 'Saturday' THEN 1 ELSE 0 END < 5

----
CREATE FUNCTION fn_remove_week (@inputDate DATETIME)
RETURNS DATETIME
AS
BEGIN
    DECLARE @outputDate DATETIME = @inputDate

    -- Retire le samedi
    IF DATEPART(WEEKDAY, @outputDate) = 7
        SET @outputDate = DATEADD(DAY, 2, @outputDate)

    -- Retire le dimanche
    IF DATEPART(WEEKDAY, @outputDate) = 1
        SET @outputDate = DATEADD(DAY, 1, @outputDate)

    RETURN @outputDate
END

SELECT *
FROM expeditions
WHERE DATEDIFF(dd, date_expedition, dbo.fn_remove_week(GETDATE())) <= 5 
  AND DATEDIFF(dd, dbo.fn_remove_week(GETDATE()), GETDATE()) <= 5
  AND statut = 'arriver'



  --- marche mais prends en compte le weekend
SELECT *
FROM expeditions
WHERE date_expedition >= DATEADD(day, -5, GETDATE())
AND DATEDIFF(day, date_expedition, GETDATE()) - 
    (DATEDIFF(week, date_expedition, GETDATE()) * 2) -
    CASE WHEN DATENAME(weekday, date_expedition) = 'Sunday' THEN 1 ELSE 0 END -
    CASE WHEN DATENAME(weekday, GETDATE()) = 'Saturday' THEN 1 ELSE 0 END < 5



SELECT * FROM entrepots;
SELECT * FROM EXPEDITIONS;

UPDATE expeditions SET date_expedition=REPLACE(date_expedition,YEAR(date_expedition),'2023');

UPDATE expeditions SET date_expedition= DATEADD(year, -1, date_expedition);

