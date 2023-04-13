using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Bdd.Table.Classes;

namespace Entrepot.Repository
{
    public class EntrepotsRepository
    {
        private SqlConnection connexion;
        public void BDD_connect()
        {

            // Définir la chaîne de connexion
            string connectionString = @"Data Source=VALANGELA\SQLEXPRESS;Initial Catalog=transport_logistique;Integrated Security=True";

            // Instancier la connexion
            connexion = new SqlConnection(connectionString);

            // Ouvrir la connexion
            connexion.Open();
        }

         public void BDD_read_entrepot()
         {
            BDD_connect();

            try
            {
                
                // Exécuter une requête SQL pour récupérer des données
                string sql = "SELECT * FROM entrepots";
                SqlCommand commande = new SqlCommand(sql, connexion);
                SqlDataReader lecteur = commande.ExecuteReader();

                while (lecteur.Read())
                {
                    int id = (int)lecteur["id"];

                    string NomEntrepot = (string)lecteur["Nom_Entrepot"];
                    string Adresse = (string)lecteur["Adresse"];
                    string Ville = (string)lecteur["Ville"];
                    string Pays = (string)lecteur["Pays"];
                    string Continent = (string)lecteur["Continent"];


                    Console.WriteLine(id.ToString() + " " + NomEntrepot + " " + Adresse + " " + Ville + " " + Pays + " " + Continent);
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
         }

            // Méthode pour ajouter un nouvel objet ENTREPOT à la base de données
        public void BDD_Create_Entrepots(Entrepots entrepot)
        {
            BDD_connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = "INSERT INTO entrepots (Nom_Entrepot, Adresse, Ville, Pays, Continent) VALUES (@NomEntrepot, @Adresse, @Ville, @Pays, @Continent)";
                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("@NomEntrepot", entrepot.NomEntrepot);
                commande.Parameters.AddWithValue("@Adresse", entrepot.Adresse);
                commande.Parameters.AddWithValue("@Ville", entrepot.Ville);
                commande.Parameters.AddWithValue("@Pays", entrepot.Pays);
                commande.Parameters.AddWithValue("@Continent", entrepot.Continent);


                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("Nouvel entrepot ajouté avec succès !");
                }
                else
                {
                    Console.WriteLine("Échec de l'ajout de l'entrepot.");
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

           //Méthode pour DELETE un entrepot avec un ID 
        public void BDD_Delete_Entrepot(int idEntrepot)
        {
            BDD_connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"DELETE FROM Entrepots WHERE id=@Identrepot";

                SqlCommand commande = new SqlCommand(sql, connexion);
                commande.Parameters.AddWithValue("@Identrepot", idEntrepot);

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("un entrepot a été supprimé !");
                }
                else
                {
                    Console.WriteLine("Échec de la suppression entrepot.");
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

           //Méthode pour Update un entrepot avec un ID
        public void BDD_Update_Entrepot(Entrepots entrepot)
        {
            BDD_connect();

            try
            {
                // Créer une nouvelle commande SQL pour insérer les données dans la base de données
                string sql = $"UPDATE Entrepots SET Nom_Entrepot=@NomEntrepot, Adresse=@Adresse, Ville=@Ville, Pays=@Pays, Continent=@Continent WHERE id=@Id";

                SqlCommand commande = new SqlCommand(sql, connexion);

                commande.Parameters.AddWithValue("@Id", entrepot.Id);
                commande.Parameters.AddWithValue("@NomEntrepot", entrepot.NomEntrepot);
                commande.Parameters.AddWithValue("@Adresse", entrepot.Adresse);
                commande.Parameters.AddWithValue("@Ville", entrepot.Ville);
                commande.Parameters.AddWithValue("@Pays", entrepot.Pays);
                commande.Parameters.AddWithValue("@Continent", entrepot.Continent);

                

                // Exécuter la commande SQL pour insérer les données
                int nombreLignesAffectees = commande.ExecuteNonQuery();

                if (nombreLignesAffectees > 0)
                {
                    Console.WriteLine("un entrepot a été modifié !");
                }
                else
                {
                    Console.WriteLine("Échec de la modification entrepot.");
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
