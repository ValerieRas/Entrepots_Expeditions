using System;
using System.Data.SqlClient;
using System.Reflection;

namespace transport_logistique
{


    public class BDD
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

        public void BDD_read()
        {
            BDD_connect();

            try
            {
                
                // Exécuter une requête SQL pour récupérer des données
                string sql = "SELECT * FROM clients";
                SqlCommand commande = new SqlCommand(sql, connexion);
                SqlDataReader lecteur = commande.ExecuteReader();

                while (lecteur.Read())
                {
                    int id = (int)lecteur["id"];

                    string nom = (string)lecteur["nom"];
                    string adresse = (string)lecteur["adresse"];
                    string ville = (string)lecteur["ville"];
                    string pays = (string)lecteur["pays"];

                    Console.WriteLine(id.ToString() + " " + nom + " " + adresse + " " + ville + " " + pays);
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

        public void BDD_create<T>(T objet)
        {
            BDD_connect();
           
            try 
            {
                string nomTable = typeof(T).Name;

                string sql = $"INSERT INTO {nomTable} (nom,adresse,ville,pays) VALUES (@nom, @adresse,@ville,@pays)";

                SqlCommand commande = new SqlCommand(sql, connexion);

                foreach (PropertyInfo prop in typeof(T).GetProperties())
                {
                    string nomProp = prop.Name;
                    objet valeurProp = prop.GetValue(objet,null);

                }

                SqlDataReader lecteur = commande.ExecuteReader();

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



