using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Biblioteca
{
    // Clase base abstracta para representar un elemento de la biblioteca
    abstract class ItemBiblioteca
    {
        protected string Titulo { get; set; }
        protected string Autor { get; set; }

        public ItemBiblioteca(string titulo, string autor)
        {
            Titulo = titulo;
            Autor = autor;
        }

        public abstract void MostrarInformacion();
    }
}
