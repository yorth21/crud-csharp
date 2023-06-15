using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Biblioteca
{
    // Clase derivada que representa un libro
    class Libro : ItemBiblioteca
    {
        public int Paginas { get; set; }

        public Libro(string titulo, string autor, int paginas) : base(titulo, autor)
        {
            Paginas = paginas;
        }

        public override void MostrarInformacion()
        {
            Console.WriteLine("Libro:");
            Console.WriteLine("Título: " + Titulo);
            Console.WriteLine("Autor: " + Autor);
            Console.WriteLine("Páginas: " + Paginas);
        }
    }
}
