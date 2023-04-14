using System;
using System.Data.SqlClient;
using System.Reflection;
using Bdd.Table.Classes;

namespace Sql.Data.Connect
{


    public class BDD
    {
        // private SqlConnection? connexion;

        public static SqlConnection BDD_connect()
        {
        // private SqlConnection connexion;

            // Définir la chaîne de connexion
            string connectionString = @"Data Source=VALANGELA\SQLEXPRESS;Initial Catalog=transport_logistique;Integrated Security=True";

            // Instancier la connexion
            return new SqlConnection(connectionString);

        }        
    }
}



