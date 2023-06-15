using contacts.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace contacts.Dato
{
    public class Usuario
    {
        List<UsuarioModelo> lista = new List<UsuarioModelo>();

        /// <summary>
        /// Agregar usuarios 
        /// </summary>
        /// <param name="model">Datos del usuario</param>
        public void Agregar (UsuarioModelo model) {
            lista.Add(model);
        }

        /// <summary>
        /// Consultar todos los usuarios
        /// </summary>
        /// <returns>datos de usuarios</returns>
        public List<UsuarioModelo> Consultar () { return lista; }
    }
}
