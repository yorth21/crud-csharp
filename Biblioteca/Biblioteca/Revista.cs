using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Biblioteca
{
    // Clase derivada que representa una revista
    class Revista : ItemBiblioteca
    {
        public int Año { get; set; }
        public int Numero { get; set; }

        public Revista(string titulo, int año, int numero) : base(titulo, "N/A")
        {
            Año = año;
            Numero = numero;
        }

        public override void MostrarInformacion()
        {
            Console.WriteLine("Revista:");
            Console.WriteLine("Título: " + Titulo);
            Console.WriteLine("Año: " + Año);
            Console.WriteLine("Número: " + Numero);
        }
    }
}
