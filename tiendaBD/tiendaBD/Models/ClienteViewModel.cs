using Npgsql;
using Dapper;

namespace tiendaBD.Models
{
    public class ClienteViewModel
    {
        public int? Id { get; set; }
        public string Nombre { get; set; }
        public string Ciudad { get; set; }
        public string Pais { get; set; }
        public bool Estado { get; set; }

        private static string stringConnection = "User Id=postgres; Database=tienda; Port=5432; Password=123; Server=localhost";

        public static List<ClienteViewModel> Get()
        {
            List<ClienteViewModel> lista = new List<ClienteViewModel>();

            using (var connection = new NpgsqlConnection(stringConnection))
            {
                connection.Open();

                string query = "SELECT cliente_id as id, nombre_cliente as nombre, ciudad, pais, estado FROM clientes WHERE estado=true";

                lista = connection.Query<ClienteViewModel>(query).ToList();
            }

            return lista;
        }

        public static Boolean Post(ClienteViewModel viewModel)
        {
            using (var connection = new NpgsqlConnection(stringConnection))
            {
                connection.Open();

                string query = "INSERT INTO clientes (nombre_cliente, ciudad, pais) VALUES (@nombre, @ciudad, @pais)";

                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("nombre", viewModel.Nombre);
                parametros.Add("ciudad", viewModel.Ciudad);
                parametros.Add("pais", viewModel.Pais);

                //connection.Query(query, parametros).FirstOrDefault();
                int filasAfectadas = connection.Execute(query, parametros);

                if (filasAfectadas > 0)
                {
                    // La acción se ejecutó correctamente, se eliminaron filas
                    return true;
                }
                else
                {
                    // No se eliminaron filas, la acción no se ejecutó correctamente
                    return false;
                }
            }
        }

        public static Boolean Delete(int Id)
        {
            using (var connection = new NpgsqlConnection(stringConnection))
            {
                connection.Open();

                // string query = "DELETE FROM clientes WHERE cliente_id=@id";
                string query = "UPDATE clientes SET estado=false WHERE cliente_id=@id";

                DynamicParameters parametros = new DynamicParameters();
                parametros.Add("id", Id);

                //connection.Query(query, parametros).FirstOrDefault();
                int filasAfectadas = connection.Execute(query, parametros);

                if (filasAfectadas > 0)
                {
                    // La acción se ejecutó correctamente, se eliminaron filas
                    return true;
                }
                else
                {
                    // No se eliminaron filas, la acción no se ejecutó correctamente
                    return false;
                }
            }
        }
    }
}
