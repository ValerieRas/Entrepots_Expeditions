using Bdd.Table.Classes;
using Sql.Data.Connect;
using Entrepot.Repository;
using Expedition.Repository;
using Client.Repository;


internal class Program
{
    private static void Main(string[] args)
    {
        BDD bdd = new BDD();

        //Clients NewClient = new Clients();

        //NewClient.Nom = "Val";
        //NewClient.Adresse = "Grenoble";
        //NewClient.Ville = "Grenoble";
        //NewClient.Pays = "France";

        //bdd.BDD_create(NewClient);


        //Entrepots NewEntrepot = new Entrepots();

        //NewEntrepot.NomEntrepot = "Délire";
        //NewEntrepot.Adresse = "Rue du plaisir";
        //NewEntrepot.Ville = "Cocoland";
        //NewEntrepot.Pays = "Etat-Unis";
        //NewEntrepot.Continent = "Amérique";

        //EntreRepo.BDD_Create_Entrepots(NewEntrepot);

        //Lire info entrepots    
        //EntrepotsRepository EntreRepo = new EntrepotsRepository();
        //EntreRepo.BDD_read_entrepot();

        ////Lire info Expedition
        ExpeditionsRepository ExpedRepo = new ExpeditionsRepository();

        List<Expeditions>ListeExpeditions= new List<Expeditions>();

        ListeExpeditions= ExpedRepo.BDD_Read_Expeditions();

        foreach(Expeditions Expedition in ListeExpeditions)
        {
            Console.WriteLine(Expedition.Id.ToString());
            Console.WriteLine(Expedition.DateExpedition.ToString());
            Console.WriteLine(Expedition.IdEntrepotSource.ToString());
            Console.WriteLine(Expedition.IdEntrepotDestination.ToString());
            Console.WriteLine(Expedition.Poids.ToString());
            Console.WriteLine(Expedition.Statut);
            Console.WriteLine(Expedition.DateLivraisonPrevu.ToString());
            Console.WriteLine(Expedition.DateLivraison.ToString());
            Console.WriteLine(Expedition.ListeClientReceveur.ToString());

        }

        //// Lire info Client 
        //ClientRepository ClientRepo = new ClientRepository();
        //ClientRepo.BDD_Read_Client();

    }
}

