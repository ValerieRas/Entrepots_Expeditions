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


        ///>>>>>>>>>>>>>>>>CLIENT<<<<<<<<<<<<<<<<<<<<<<<

        ////REPO Client 

        ClientRepository ClientRepo = new ClientRepository();


        //Update un client

        //Clients UpdateClient = new Clients();
        //UpdateClient.Id = 5;
        //UpdateClient.Nom = "Val";
        //UpdateClient.Adresse = "Grenoble";
        //UpdateClient.Ville = "Grenoble";
        //UpdateClient.Pays = "Australie";

        //ClientRepo.BDD_Update_Client(UpdateClient);


        ////Créer un client

        //Clients NewClient = new Clients();

        //NewClient.Nom = "Val";
        //NewClient.Adresse = "Grenoble";
        //NewClient.Ville = "Grenoble";
        //NewClient.Pays = "France";

        //bdd.BDD_create(NewClient);



        ////Supprimer un client

        //ClientRepo.BDD_Delete_Client(5);



        //Lecture Client

        //List<Clients> ListeClient = new List<Clients>();

        //ListeClient = ClientRepo.BDD_Read_Client();

        //foreach (Clients client in ListeClient)

        //{
        //    Console.WriteLine(client.ToString());
        //}



        ////>>>>>>>>>>>>>>>>ENTREPOTS<<<<<<<<<<<<<<<<<<<<<<<


        EntrepotsRepository EntreRepo = new EntrepotsRepository();

        ////Création d'un entrepot

        //Entrepots NewEntrepot = new Entrepots();

        //NewEntrepot.NomEntrepot = "Délire";
        //NewEntrepot.Adresse = "Rue du plaisir";
        //NewEntrepot.Ville = "Cocoland";
        //NewEntrepot.Pays = "Etat-Unis";
        //NewEntrepot.Continent = "Amérique";

        //EntreRepo.BDD_Create_Entrepots(NewEntrepot);

        ////Update Entrepots

        //Entrepots UpdateEntrepot = new Entrepots();

        //UpdateEntrepot.Id = 10;
        //UpdateEntrepot.NomEntrepot = "DélireBis";
        //UpdateEntrepot.Adresse = "Rue du plaisir";
        //UpdateEntrepot.Ville = "Cocoland";
        //UpdateEntrepot.Pays = "Etat-Unis";
        //UpdateEntrepot.Continent = "Amérique";

        //EntreRepo.BDD_Update_Entrepot(UpdateEntrepot);

        ////Supprimer un entrepot

        //EntreRepo.BDD_Delete_Entrepot(10);

        ////Lire info entrepots    

        //EntreRepo.BDD_read_entrepot();





        ////>>>>>>>>>>>>>>>>EXPEDITIONS<<<<<<<<<<<<<<<<<<<<<<<


        ExpeditionsRepository ExpedRepo = new ExpeditionsRepository();


        //// Créer une expedition


        //Expeditions NewExpeditions = new Expeditions();
        //NewExpeditions.DateExpedition = new DateTime(2023, 04, 13);
        //NewExpeditions.IdEntrepotSource = 1;
        //NewExpeditions.IdEntrepotDestination = 6;
        //NewExpeditions.Poids = 500;
        //NewExpeditions.Statut = "en transit";

        //ExpedRepo.BDD_Create_Expeditions(NewExpeditions);

        //////Lire info Expedition

        //List<Expeditions> ListeExpeditions = new List<Expeditions>();

        //ListeExpeditions = ExpedRepo.BDD_Read_Expeditions();

        //foreach (Expeditions Expedition in ListeExpeditions)
        //{
        //    Console.WriteLine(Expedition.Id.ToString());
        //    Console.WriteLine(Expedition.DateExpedition.ToString());
        //    Console.WriteLine(Expedition.IdEntrepotSource.ToString());
        //    Console.WriteLine(Expedition.IdEntrepotDestination.ToString());
        //    Console.WriteLine(Expedition.Poids.ToString());
        //    Console.WriteLine(Expedition.Statut);
        //    Console.WriteLine(Expedition.DateLivraisonPrevu.ToString());
        //    Console.WriteLine(Expedition.DateLivraison.ToString());
        //    Console.WriteLine(Expedition.ClientReceveur.ToString());
        //}



    }
}

