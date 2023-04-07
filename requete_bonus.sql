--Créez une vue qui affiche les informations suivantes pour chaque entrepôt : 
--nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au cours des 30 derniers jours.

CREATE VIEW entrepot_view AS
SELECT nom_entrepot,
		(adresse+ville+pays)as adresse, 
		count(id_entrepot_source) as nombres_expeditions
FROM entrepots e
INNER JOIN
	 expeditions expd
	 ON
	 e.id=expd.id_entrepot_source
WHERE
	DATEDIFF(day,date_expedition,getdate())<=30
GROUP BY 
		nom_entrepot,
		(adresse+ville+pays);
		
SELECT *
FROM entrepot_view;


--Créez une procédure stockée qui prend en entrée l'ID d'un entrepôt et renvoie le nombre total d'expéditions 
--envoyées par cet entrepôt au cours du dernier mois.


CREATE PROCEDURE nb_expeditions_envoyees_dernier_mois
    @id_entrepot INT
AS
BEGIN
    SELECT COUNT(*) AS nombre_expeditions_envoyees
    FROM expeditions
    WHERE id_entrepot_source = @id_entrepot
    AND date_expedition >= DATEADD(month, -1, GETDATE());
END

EXEC nb_expeditions_envoyees_dernier_mois @id_entrepot=3;


--Créez une fonction qui prend en entrée une date et renvoie le nombre total d'expéditions livrées ce jour-là.

CREATE FUNCTION nombre_total_dexpéditions_livrées(@date date)
RETURNS INT
AS
BEGIN
    DECLARE @result int;
    SELECT @result = COUNT(*) 
    FROM expeditions
    WHERE date_livraison = @date;
    RETURN @result;
END

SELECT dbo.nombre_total_dexpéditions_livrées('2023-03-22');



--Ajoutez une table "clients" contenant les colonnes suivantes :
--id (entier auto-incrémenté, clé primaire) nom (chaîne de caractères) adresse (chaîne de caractères) 
--ville (chaîne de caractères) pays (chaîne de caractères)
CREATE TABLE clients 
(id INT NOT NULL IDENTITY(1,1),
nom VARCHAR(20),
adresse VARCHAR(50),
ville VARCHAR(50),
pays VARCHAR(20)
);

ALTER TABLE clients ADD PRIMARY KEY (id);



--Ajoutez une table de jointure "expeditions_clients" contenant les colonnes suivantes :
--id_expedition (entier, clé étrangère faisant référence à la table "expeditions") 
--id_client (entier, clé étrangère faisant référence à la table "clients")

CREATE TABLE expeditions_clients
(id_expeditions int not null,
id_client int not null,
FOREIGN KEY (id_expeditions) REFERENCES expeditions(id),
FOREIGN KEY (id_client) REFERENCES clients(id)
);


--Modifiez la table "expeditions" pour y ajouter une colonne "id_client" (entier, 
--clé étrangère faisant référence à la table "clients").

ALTER TABLE expeditions ADD 
id_client INT, 
FOREIGN KEY (id_client) REFERENCES clients(id);

UPDATE expeditions SET id_client=1 WHERE id IN (1,6,7,10,15,9);
UPDATE expeditions SET id_client=2 WHERE id IN (2,5,3,4,12);
UPDATE expeditions SET id_client=3 WHERE id IN (8,13,11);
UPDATE expeditions SET id_client=4 WHERE id IN (14,16);

--Ajoutez des données aux tables "clients" et "expeditions_clients". 
--**Écrivez des requêtes pour extraire les informations suivantes : 
--**- Pour chaque client, affichez son nom, son adresse complète, le nombre total d'expéditions 
--qu'il a envoyées et le nombre total d'expéditions qu'il a reçues.

INSERT INTO clients(nom, adresse, ville,pays)
VALUES
	('rasolo',  'Michelle de montaigne',' eybens','France'),
	('michel','rue de la republique', 'Vaulx-en-velin', 'LOS ANGELES'),
	('ferry','felix fort', 'lyon', 'THAILANDE'),
	('sotos','les granges', 'la tours','BRESIL');

INSERT INTO expeditions_clients(id_client,id_expeditions)
VALUES
(1,2),
(1,9),
(1,10),
(1,5),
(2,1),
(2,11),
(3,15),
(3,3),
(3,4),
(4,16),
(4,13),
(4,12);




--renome les colonnes--
EXEC sp_rename 'expeditions.id_client', 'id_client_receveur', 'COLUMN';
EXEC sp_rename 'expeditions_clients.id_client', 'id_client_expediteur', 'COLUMN';


--<<<<<<<<<<<<<<<<<<< MARCHE >>>>>>>>>>>>>>>>>>>>>>>>>

SELECT c.nom AS nom_client, 
       c.adresse AS adresse_client, 
       CONCAT(c.adresse, ', ', c.ville, ', ', c.pays) AS adresse_complete,
       COUNT(DISTINCT ec.id_expeditions) AS nb_expeditions_envoyees, 
       (SELECT COUNT(*) FROM expeditions WHERE id_client_receveur = c.id) AS nb_expeditions_recues
FROM clients c
LEFT JOIN expeditions_clients ec ON c.id = ec.id_client_expediteur
GROUP BY c.id, c.nom, c.adresse, c.ville, c.pays;

--<<<<<<<<<<<<<<<<<<< MARCHE >>>>>>>>>>>>>>>>>>>>>>>>>	
	



---Pour chaque expédition, affichez son ID, son poids, le nom du client qui l'a envoyée, 
--le nom du client qui l'a reçue et le statut



SELECT e.id AS id_expedition,
       e.poids AS poids,
       c1.nom AS expediteur_nom,
       c2.nom AS destinataire_nom,
       e.statut AS statut
FROM expeditions e
INNER JOIN expeditions_clients ec ON ec.id_expeditions=e.id
JOIN clients c1 ON ec.id_client_expediteur = c1.id
JOIN clients c2 ON e.id_client_receveur = c2.id;




SELECT *
FROM 
	expeditions;

SELECT *
FROM 
	entrepots;

SELECT *
FROM 
	expeditions_clients;

SELECT *
FROM clients