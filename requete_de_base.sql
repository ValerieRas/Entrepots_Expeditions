

-- Affiche tout les entrepots

select * from entrepots;



-- Affiche toutes les expedition

select * from expeditions;


-- Affiche toutes les expeditions en transit

select * 
from expeditions
where statut = 'en transit';



-- Affiche toutes les expéditions livrées

select * 
from expeditions
where statut = 'arriver';