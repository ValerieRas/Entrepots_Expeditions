

CREATE DATABASE transport_logistique;

USE transport_logistique;


--Créez une table "entrepots" contenant les colonnes suivantes : 
--id (entier auto-incrémenté, clé primaire) , nom_entrepot (chaîne de caractères), 
--adresse (chaîne de caractères), ville (chaîne de caractères) ,pays (chaîne de caractères).

CREATE TABLE entrepots (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nom_entrepot VARCHAR(25),
    adresse VARCHAR(250),
    ville VARCHAR(30),
    pays VARCHAR(20)
);



--Créez une table "expeditions" contenant les colonnes suivantes : 
--id (entier auto-incrémenté, clé primaire), date_expedition (date), date_livraison (date), 
--id_entrepot_source (entier, clé étrangère faisant référence à la table "entrepots"), id_entrepot_destination 
--(entier, clé étrangère faisant référence à la table "entrepots"), poids (décimal), statut (chaîne de caractères).

CREATE TABLE expeditions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    date_expedition DATE,
    id_entrepot_source INT FOREIGN KEY REFERENCES entrepots(id),
    id_entrepot_destination INT FOREIGN KEY REFERENCES entrepots(id),
    poids DECIMAL(10,2), --permet de pouvoir stocker des nombres décimaux allant jusqu’à 10 chiffres avec 2 décimales (ex: 12345.67).
    statut VARCHAR(30)
);