using System;
using System.Collections.Generic;

namespace Biblioteca
{
    class Program
    {
        static void Main(string[] args)
        {
            List<ItemBiblioteca> biblioteca = new List<ItemBiblioteca>();

            // Agregar libros, revistas y películas a la biblioteca
            biblioteca.Add(new Libro("1984", "George Orwell", 328));
            biblioteca.Add(new Revista("National Geographic", 2021, 6));
            biblioteca.Add(new Pelicula("El Padrino", "Francis Ford Coppola", 1972));

            // Mostrar información sobre los elementos de la biblioteca
            foreach (var item in biblioteca)
            {
                item.MostrarInformacion();
                Console.WriteLine();
            }

            Console.ReadLine();
        }
    }
}
