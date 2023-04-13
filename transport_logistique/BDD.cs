using System;
using System.Data.SqlClient;
using System.Reflection;
using Bdd.Table.Classes;

namespace Sql.Data.Connect
{


    public class BDD
    {
        private SqlConnection connexion;

        public void BDD_connect()
        {
        // private SqlConnection connexion;

            // Définir la chaîne de connexion
            string connectionString = @"Data Source=VALANGELA\SQLEXPRESS;Initial Catalog=transport_logistique;Integrated Security=True";

            // Instancier la connexion
            connexion = new SqlConnection(connectionString);

            // Ouvrir la connexion
            connexion.Open();
        }

    //     public void BDD_read()
    //     {
    //         BDD_connect();

    //         try
    //         {
                
    //             // Exécuter une requête SQL pour récupérer des données
    //             string sql = "SELECT * FROM clients";
    //             SqlCommand commande = new SqlCommand(sql, connexion);
    //             SqlDataReader lecteur = commande.ExecuteReader();

    //             while (lecteur.Read())
    //             {
    //                 int id = (int)lecteur["id"];

    //                 string nom = (string)lecteur["nom"];
    //                 string adresse = (string)lecteur["adresse"];
    //                 string ville = (string)lecteur["ville"];
    //                 string pays = (string)lecteur["pays"];

    //                 Console.WriteLine(id.ToString() + " " + nom + " " + adresse + " " + ville + " " + pays);
    //             }

    //             lecteur.Close();
    //         }
    //         catch (Exception ex)
    //         {
    //             // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
    //             Console.WriteLine("Erreur : " + ex.Message);
    //         }
    //         finally
    //         {
    //             // Fermer la connexion
    //             connexion.Close();
    //         }
    //     }



    //     // Méthode pour ajouter un nouvel objet CLIENT à la base de données
    //     public void BDD_create(Clients client)
    //     {
    //         BDD_connect();

    //         try
    //         {
    //             // Créer une nouvelle commande SQL pour insérer les données dans la base de données
    //             string sql = "INSERT INTO clients (nom, adresse, ville, pays) VALUES (@nom, @adresse, @ville, @pays)";
    //             SqlCommand commande = new SqlCommand(sql, connexion);
    //             commande.Parameters.AddWithValue("@nom", client.Nom);
    //             commande.Parameters.AddWithValue("@adresse", client.Adresse);
    //             commande.Parameters.AddWithValue("@ville", client.Ville);
    //             commande.Parameters.AddWithValue("@pays", client.Pays);

    //             // Exécuter la commande SQL pour insérer les données
    //             int nombreLignesAffectees = commande.ExecuteNonQuery();

    //             if (nombreLignesAffectees > 0)
    //             {
    //                 Console.WriteLine("Nouveau client ajouté avec succès !");
    //             }
    //             else
    //             {
    //                 Console.WriteLine("Échec de l'ajout du client.");
    //             }
    //         }
    //         catch (Exception ex)
    //         {
    //             // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
    //             Console.WriteLine("Erreur : " + ex.Message);
    //         }
    //         finally
    //         {
    //             // Fermer la connexion
    //             connexion.Close();
    //         }
    //     }

      


    //     public void BDD_create<T>(T objet)
    //     {
    //         BDD_connect();

    //         try
    //         {
    //             string nomTable = typeof(T).Name;

    //             string sql = $"INSERT INTO {nomTable} (nom,adresse,ville,pays) VALUES (@nom, @adresse,@ville,@pays)";

    //             SqlCommand commande = new SqlCommand(sql, connexion);

    //             foreach (PropertyInfo prop in typeof(T).GetProperties())
    //             {
    //                 string nomProp = prop.Name;
    //                 object valeurProp = prop.GetValue(objet, null);

    //             }

    //             SqlDataReader lecteur = commande.ExecuteReader();

    //         }
    //         catch (Exception ex)
    //         {
    //             // Gérer les exceptions en cas d'erreur de connexion ou d'exécution de requête
    //             Console.WriteLine("Erreur : " + ex.Message);
    //         }
    //         finally
    //         {
    //             // Fermer la connexion
    //             connexion.Close();
    //         }
    //     }

        
    }
}



