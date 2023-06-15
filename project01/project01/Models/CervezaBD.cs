using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Npgsql;

namespace project01.Models
{
    class CervezaBD
    {
        private string GetConnectionString()
        {
             string server = "localhost";
             int port = 5432;
             string database = "FundamentosCSharp";
             string userId = "postgres";
             string password = "123";

            NpgsqlConnectionStringBuilder builder = new NpgsqlConnectionStringBuilder
            {
                Host = server,
                Port = port,
                Database = database,
                Username = userId,
                Password = password,
                //SslMode = SslMode.Require, // Utiliza SSL para una conexión segura (requiere que el servidor PostgreSQL esté configurado para SSL)
                //TrustServerCertificate = false // Para omitir la validación del certificado SSL (solo para pruebas, no recomendado en producción)
            };

            return builder.ConnectionString;
        }

        public List<Cerveza> Get()
        {
            List<Cerveza> cervezas = new List<Cerveza>();

            using (var connection = new NpgsqlConnection(GetConnectionString()))
            {
                connection.Open();

                string query = "SELECT nombre, marca, alcohol, cantidad FROM cerveza";
                cervezas = connection.Query<Cerveza>(query).ToList();

                //foreach (var row in result)
                //{
                //    int cantidad = (int)row.cantidad;
                //    string nombre = (string)row.nombre;
                //    string marca = (string)row.marca;
                //    int alcohol = (int)row.alcohol;

                //    Cerveza cerveza = new Cerveza(cantidad, nombre);
                //    cerveza.Marca = marca;
                //    cerveza.Alcohol = alcohol;
                //    cerveza.Beberse(5);
                //    cervezas.Add(cerveza);
                //}
            }

            return cervezas;
        }

        public void Post(Cerveza cerveza)
        {
            using (var connection = new NpgsqlConnection(GetConnectionString()))
            {
                connection.Open();

                string query = "INSERT INTO cerveza (nombre, marca, alcohol, cantidad) VALUES (@nombre, @marca, @alcohol, @cantidad)";
                connection.Execute(query, new { nombre=cerveza.Nombre, marca=cerveza.Marca, alcohol=cerveza.Alcohol, cantidad=cerveza.Cantidad });
            }
        }

        public void Put(Cerveza cerveza, int Id)
        {
            using (var connection = new NpgsqlConnection(GetConnectionString()))
            {
                connection.Open();

                string query = "UPDATE cerveza SET nombre=@nombre, marca=@marca, alcohol=@alcohol, cantidad=@cantidad WHERE id=@id";
                connection.Execute(query, new { nombre = cerveza.Nombre, marca = cerveza.Marca, alcohol = cerveza.Alcohol, cantidad = cerveza.Cantidad, id=Id });
            }
        }

        public void Delete(int Id)
        {
            using (var connection = new NpgsqlConnection(GetConnectionString()))
            {
                connection.Open();

                string query = "DELETE FROM cerveza WHERE id=@id";
                connection.Execute(query, new { id = Id });
            }
        }
    }
}
