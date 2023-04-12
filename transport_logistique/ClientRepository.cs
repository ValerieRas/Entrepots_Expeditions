using Bdd.Table.Classes;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Client.Repository
{ 
    public class ClientRepository
    {
        private SqlConnection connexion;
        public void BDD_Connect()
        {

            // Définir la chaîne de connexion
            string connectionString = @"Data Source=VALANGELA\SQLEXPRESS;Initial Catalog=transport_logistique;Integrated Security=True";

            // Instancier la connexion
            connexion = new SqlConnection(connectionString);

            // Ouvrir la connexion
            connexion.Open();
        }


        public List<Clients> BDD_Read_Client()
        {
            BDD_Connect();

            List<Clients> ListeClients = new List<Clients>();

            try
            {

                // Exécuter une requête SQL pour récupérer des données
                string sql = "SELECT * FROM clients";
                SqlCommand commande = new SqlCommand(sql, connexion);
                SqlDataReader lecteur = commande.ExecuteReader();

                Clients clients = new Clients();

                while (lecteur.Read())
                {

                    Clients client = new Clients();

                    client.Id = (int)lecteur["id"];
                    client.Nom=(string)lecteur["nom"]; 
                    client.Adresse = (string)lecteur["adresse"];
                    client.Ville = (string)lecteur["ville"];
                    client.Pays = (string)lecteur["pays"];

                    ListeClients.Add(client);
                }

                lecteur.Close();
            }
            catch (Exception ex)
            {
                // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
            return ListeClients;
        }

        // Méthode pour ajouter un nouvel objet CLIENT à la base de données
        public void BDD_Create_Client(Clients client)
        {
            BDD_Connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = "INSERT INTO clients (nom, adresse, ville, pays) VALUES (@nom, @adresse, @ville, @pays)";
                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("@nom", client.Nom);
                commande.Parameters.AddWithValue("@adresse", client.Adresse);
                commande.Parameters.AddWithValue("@ville", client.Ville);
                commande.Parameters.AddWithValue("@pays", client.Pays);

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("Nouveau client ajouté avec succès !");
                }
                else
                {
                    Console.WriteLine("Échec de l'ajout du client.");
                }
            }
            catch (Exception ex)
            {
                // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
        }

        //Méthode pour DELETE un client avec un ID 
        public void BDD_Delete_Client(int idClient)
        {
            BDD_Connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"DELETE FROM Clients WHERE id={idClient}";

                SqlCommand commande = new SqlCommand(sql, connexion);

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("un client a été supprimé !");
                }
                else
                {
                    Console.WriteLine("Échec de la suppression.");
                }
            }
            catch (Exception ex)
            {
                // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
        }

        //Méthode pour Update un client avec un ID
        public void BDD_Update_Client(int idClient)
        {
            BDD_Connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"DELETE FROM Clients WHERE id={idClient}";

                SqlCommand commande = new SqlCommand(sql, connexion);

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("un client a été supprimé !");
                }
                else
                {
                    Console.WriteLine("Échec de la suppression.");
                }
            }
            catch (Exception ex)
            {
                // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
                Console.WriteLine("Erreur : " + ex.Message);
            }
            finally
            {
                // Fermer la connexion
                connexion.Close();
            }
        }



    }
}
