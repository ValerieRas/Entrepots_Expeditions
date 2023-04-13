using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using Bdd.Table.Classes;
using Client.Repository;

namespace Expedition.Repository
{
    public class ExpeditionsRepository
    {
        private SqlConnection? connexion;

        public void BDD_connect()
        {
            // D�finir la cha�ne de connexion
            string connectionString = @"Data Source=VALANGELA\SQLEXPRESS;Initial Catalog=transport_logistique;Integrated Security=True";

            // Instancier la connexion
            connexion = new SqlConnection(connectionString);

            // Ouvrir la connexion
            connexion.Open();
        }

        public void BDD_Create_Expeditions(Expeditions expedition)
        {
            BDD_connect();

            try
            {
                // Cr�er une nouvelle commande SQL pour ins�rer les donn�es dans la base de donn�es
                string sql = "INSERT INTO Expeditions (Date_Expedition, Id_Entrepot_Source, Id_Entrepot_Destination, Poids, Statut) VALUES (@date, @source, @destination, @poids, @statut)";
                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("@date", expedition.DateExpedition);
                commande.Parameters.AddWithValue("@source", expedition.IdEntrepotSource);
                commande.Parameters.AddWithValue("@destination", expedition.IdEntrepotDestination);
                commande.Parameters.AddWithValue("@poids", expedition.Poids);
                commande.Parameters.AddWithValue("@statut", expedition.Statut);

                // Ex�cuter la commande SQL pour ins�rer les donn�es
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("Nouvelle exp�dition ajout�e avec succ�s !");
                }
                else
                {
                    Console.WriteLine("�chec de l'ajout de la nouvelle exp�dition.");
                }
            }
            catch (Exception ex)
            {
                // G�rer les exceptions en cas d'erreur de connexion ou d'ex�cution de requ�te
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
        }

        public List<Expeditions> BDD_Read_Expeditions()
        {
            BDD_connect();
            List<Expeditions> expeditions = new List<Expeditions>();
            ClientRepository ClientRepo = new ClientRepository();
            
            try
            {
                // Ex�cuter une requ�te SQL pour r�cup�rer des donn�es
                string sql = "SELECT * FROM Expeditions";
                SqlCommand commande = new SqlCommand(sql, connexion);
                SqlDataReader lecteur = commande.ExecuteReader();

                while (lecteur.Read())
                {

                    Expeditions expedition = new Expeditions();
                    expedition.Id = (int)lecteur["Id"];
                    expedition.DateExpedition = (DateTime)lecteur["Date_Expedition"];
                    expedition.IdEntrepotSource = (int)lecteur["Id_Entrepot_Source"];
                    expedition.IdEntrepotDestination = (int)lecteur["Id_Entrepot_Destination"];
                    expedition.Poids = (decimal)lecteur["Poids"];
                    expedition.Statut = (string)lecteur["Statut"];
                    
                    expedition.DateLivraisonPrevu = lecteur["Date_Livraison_Pr�vu"] as DateTime?;
                    expedition.DateLivraison = lecteur["Date_Livraison"] as DateTime?;

                    if (!lecteur.IsDBNull(lecteur.GetOrdinal("id_client_receveur")))
                    {
                        int IdClientReceveur = (int)lecteur["id_client_receveur"];

                        Clients clientreceveur = new Clients();
                        clientreceveur = ClientRepo.BDD_Find_Client(IdClientReceveur);

                        expedition.ClientReceveur = clientreceveur;
                    }
                    expeditions.Add(expedition);
                }

                lecteur.Close();
            }
            catch (Exception ex)
            {
                // G�rer les exceptions en cas d'erreur de connexion ou d'ex�cution de requ�te
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
            return expeditions;

        }

    }
}




 // faire une instance new client avec l'id r�cup�r� dans la table exped'
 // et avec jointure de la table client 
 // et ADD cette new instance client dans listeCLientReceveur de la classe/objet exped'.