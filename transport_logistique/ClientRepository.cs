using Bdd.Table.Classes;
using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using Sql.Data.Connect;


namespace Client.Repository
{ 
    public class ClientRepository
    {
        
        public List<Clients> BDD_Read_Client()
        {
            
            List<Clients> ListeClients = new List<Clients>();

            SqlConnection? connexion = null;

            try
            {
            connexion = BDD.BDD_connect();
            connexion.Open();

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

        //méthode qui va chercher un client avec son ID
        public Clients BDD_Find_Client(int Id_client)
        {

            Clients client = new Clients();            

            SqlConnection? connexion = null;

            try
            {
                connexion = BDD.BDD_connect();
                connexion.Open();

                // Exécuter une requête SQL pour récupérer des données
                string sql = "SELECT * FROM clients WHERE id=@Id";
                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("id", Id_client);

                SqlDataReader lecteur = commande.ExecuteReader();


                if (lecteur.Read())
                {
                    client.Id = (int)lecteur["id"];
                    client.Nom = (string)lecteur["nom"];
                    client.Adresse = (string)lecteur["adresse"];
                    client.Ville = (string)lecteur["ville"];
                    client.Pays = (string)lecteur["pays"];

                  
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
             return client;
        }



        // Méthode pour ajouter un nouvel objet CLIENT à la base de données
        public void BDD_Create_Client(Clients client)
        {

            SqlConnection? connexion = null;

            try
            {
                connexion = BDD.BDD_connect();
                connexion.Open();

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

            SqlConnection? connexion = null;

            try
            {
                connexion = BDD.BDD_connect();
                connexion.Open();

                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"DELETE FROM Clients WHERE id=@Idclient";

                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("@Idclient", idClient);

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

        //Méthode pour Update un client 
        public void BDD_Update_Client(Clients client)
        {

            SqlConnection? connexion = null;

            try
            {
                connexion = BDD.BDD_connect();
                connexion.Open();
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"UPDATE clients SET nom=@nom, adresse=@adresse, ville=@ville, pays=@pays WHERE id=@Id";

                SqlCommand commande = new SqlCommand(sql, connexion);

                commande.Parameters.AddWithValue("@Id", client.Id);
                commande.Parameters.AddWithValue("@nom", client.Nom);
                commande.Parameters.AddWithValue("@adresse", client.Adresse);
                commande.Parameters.AddWithValue("@ville", client.Ville);
                commande.Parameters.AddWithValue("@pays", client.Pays);
                

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("un client a été modifié !");
                }
                else
                {
                    Console.WriteLine("Échec de la modification d'un client.");
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
