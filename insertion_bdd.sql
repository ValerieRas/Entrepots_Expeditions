


--Ajoutez 5 entrepôts dans différentes villes et pays.

insert into entrepots (nom_entrepot, adresse, ville, pays) 
VALUES
('Lyon', '145, rue de la poudrette', 'Villeurbanne', 'France'),
('Casablanca', '154, rue Meddy Le grand', 'Casablanca', 'Maroc'),
('Vienne', '157, rue du Ballet', 'Vienne', 'Autriche'),
('Londres', '157, Street Queen Elisabeth', 'Londres', 'Angleterre'), 
('New-york', '15, 5 Avenue', 'New-York', 'Etats-Unis');



--Ajoutez 10 expéditions de différents poids, en provenance de différents entrepôts et à destination de différents entrepôts.


INSERT INTO expeditions (date_expedition, id_entrepot_source, id_entrepot_destination, poids, statut)
VALUES
    ('2022-03-15', 1, 3, 120.5, 'en transit'),
    ('2022-03-16', 2, 4, 220.7, 'en transit'),
    ('2022-03-17', 3, 2, 350.2, 'en transit'),
    ('2022-03-18', 4, 1, 140.0, 'non pris en charge'),
    ('2022-03-19', 5, 2, 410.9, 'en transit'),
    ('2022-03-20', 1, 4, 280.3, 'en transit'),
    ('2022-03-21', 2, 5, 180.6, 'en transit'),
    ('2022-03-22', 3, 1, 80.1, 'perdu'),
    ('2022-03-23', 4, 2, 430.0, 'en transit'),
    ('2022-03-24', 5, 3, 90.4, 'arriver'),
    ('2023-03-29',5,2,50,'arriver'),
    ('2023-04-01',2,5,50,'arriver'),
    ('2023-04-02',3,2,150,'arriver'),
    ('2023-04-03',4,1,250,'arriver'),
    ('2023-03-30',1,2,60,'arriver'),
    ('2023-03-31',3,1,40,'arriver'),
    ('2023-03-28',2,1,40,'arriver');
