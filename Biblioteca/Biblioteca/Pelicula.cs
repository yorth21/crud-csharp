using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Biblioteca
{
    // Clase derivada que representa una película
    class Pelicula : ItemBiblioteca
    {
        public string Director { get; set; }
        public int Año { get; set; }

        public Pelicula(string titulo, string director, int año) : base(titulo, "N/A")
        {
            Director = director;
            Año = año;
        }

        public override void MostrarInformacion()
        {
            Console.WriteLine("Película:");
            Console.WriteLine("Título: " + Titulo);
            Console.WriteLine("Director: " + Director);
            Console.WriteLine("Año: " + Año);
        }
    }
}
