using Npgsql;
using Dapper;

namespace mvcPrueba.Models
{
    public class PruebaVewModel
    {
        public int? Id { get; set; }
        public string Nombre { get; set; }
        public string Marca { get; set; }
        public int? Alcohol { get; set; }
        public int? Cantidad { get; set; }

        private static string con = "User Id=postgres; Database=FundamentosCSharp; Port=5432; Password=123; Server=localhost";

        public static List<PruebaVewModel> Get()
        {
            //string con = "User Id=postgres; Database=FundamentosCSharp; Port=5432; Password=123; Server=localhost";
            //string connectionString = "Server=NombreDelServidor;Port=5432;Database=NombreDeLaBaseDeDatos;User Id=NombreDeUsuario;Password=Contraseña";

            List<PruebaVewModel> lista = new List<PruebaVewModel>();

            using (var connection = new NpgsqlConnection(con))
            {
                connection.Open();

                string query = "SELECT id, nombre, marca, alcohol, cantidad FROM cerveza";

                lista = connection.Query<PruebaVewModel>(query).ToList();
            }

            return lista;
        }
        public static PruebaVewModel GetId(int Id)
        {
            //string con = "User Id=postgres; Database=FundamentosCSharp; Port=5432; Password=123; Server=localhost";
            //string connectionString = "Server=NombreDelServidor;Port=5432;Database=NombreDeLaBaseDeDatos;User Id=NombreDeUsuario;Password=Contraseña";

            PruebaVewModel model = new PruebaVewModel();

            using (var connection = new NpgsqlConnection(con))
            {
                connection.Open();

                string query = "SELECT id, nombre, marca, alcohol, cantidad FROM cerveza WHERE id=@id";
                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("id", Id);

                model = connection.Query<PruebaVewModel>(query, parametros).FirstOrDefault();
            }

            return model;
        }

        public static void Post(PruebaVewModel vm)
        {
            //string con = "User Id=postgres; Dbname=FundamentosCSharp; Port=5432; Password=123; Host=localhost";

            using (var connection = new NpgsqlConnection(con))
            {
                connection.Open();

                string query = "INSERT INTO cerveza (nombre, marca, alcohol, cantidad) VALUES (@nombre, @marca, @alcohol, @cantidad)";

                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("nombre", vm.Nombre);
                parametros.Add("marca", vm.Marca);
                parametros.Add("alcohol", vm.Alcohol);
                parametros.Add("cantidad", vm.Cantidad);

                connection.Query<PruebaVewModel>(query, parametros).ToList();
            }
        }

        public static void Delete(int Id)
        {
            //string con = "User Id=postgres; Dbname=FundamentosCSharp; Port=5432; Password=123; Host=localhost";

            using (var connection = new NpgsqlConnection(con))
            {
                connection.Open();

                string query = "DELETE FROM cerveza WHERE id=@id";

                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("id", Id);

                connection.Query(query, parametros).FirstOrDefault();
            }
        }

        public static void Put(PruebaVewModel vm)
        {
            //string con = "User Id=postgres; Dbname=FundamentosCSharp; Port=5432; Password=123; Host=localhost";

            using (var connection = new NpgsqlConnection(con))
            {
                connection.Open();

                string query = "UPDATE cerveza SET nombre=@nombre, marca=@marca, alcohol=@alcohol, cantidad=@cantidad WHERE id=@id";

                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("id", vm.Id);
                parametros.Add("nombre", vm.Nombre);
                parametros.Add("marca", vm.Marca);
                parametros.Add("alcohol", vm.Alcohol);
                parametros.Add("cantidad", vm.Cantidad);

                connection.Query<PruebaVewModel>(query, parametros).FirstOrDefault();
            }
        }
    }
}
