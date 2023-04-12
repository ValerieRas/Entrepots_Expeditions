using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bdd.Table.Classes
{
    public class Clients 
    {
        public int Id { get; set; }
        public string Nom { get; set; }
        public string Adresse { get; set; }
        public string Ville { get; set; }
        public string Pays { get; set; }
        public List<Expeditions> ListeExpeditionsEnvoyées { get; set; }
    }

    

    public class Entrepots
    {
        public int Id { get; set; }
        public string NomEntrepot { get; set; }
        public string Adresse { get; set; }
        public string Ville { get; set; }
        public string Pays { get; set; }
        public string Continent { get; set; }

    }

    public class Expeditions
    {
        public int Id { get; set; }
        public DateTime DateExpedition { get; set; }
        public int IdEntrepotSource { get; set; }
        public int IdEntrepotDestination { get; set; }
        public decimal Poids { get; set; }
        public string Statut { get; set; }
        public DateTime DateLivraisonPrevu { get; set; }
        public DateTime DateLivraison { get; set; }
        public List<Clients> ListeClientReceveur { get; set; }

    }

}
