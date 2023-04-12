using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace transport_logistique
{
    public class Clients
    {
        public int id { get; set; }
        public string nom { get; set; }
        public string adresse { get; set; }
        public string ville { get; set; }
        public string pays { get; set; }



    }

    public class Entrepots
    {
        public int id { get; set; }
        public string nom_entrepot { get; set; }
        public string adresse { get; set; }
        public string ville { get; set; }
        public string pays { get; set; }
        public string continent { get; set; }

    }

    public class Expeditions
    {
        public int id { get; set; }
        public DateOnly date_expedition { get; set; }
        public int id_entrepot_source { get; set; }
        public int id_entrepot_destination { get; set; }
        public decimal poids { get; set; }
        public string statut { get; set; }
        public DateTime date_livraison_prévu { get; set; }
        public DateTime date_livraison { get; set; }
        public Clients client_receveur { get; set; }

    }

    public class Expeditions_clients
    {
        public Expeditions expedition { get; set; }
        public Clients client { get; set; }
    }
}
