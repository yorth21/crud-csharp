using System;
using project01.Models;

namespace project01
{
    class Program
    {
        static void Main(string[] args)
        {
            CervezaBD cervezaBD = new CervezaBD();

            // Insertar cerveza en la Base de Datos
            //{
            //    Cerveza cerveza = new Cerveza(15, "Pale ale");
            //    cerveza.Marca = "Minerma";
            //    cerveza.Alcohol = 6;
            //    cervezaBD.Post(cerveza);
            //}

            //{
            //    Cerveza cerveza = new Cerveza(15, "PaleAle");
            //    cerveza.Marca = "Minerma";
            //    cerveza.Alcohol = 5;
            //    cervezaBD.Put(cerveza, 6);
            //}

            //{
            //    cervezaBD.Delete(6);
            //}

            // Mostrar cervezas Base de Datos
            var cervezas = cervezaBD.Get();
            foreach (var row in cervezas)
            {
                Console.WriteLine(row.Nombre + " - " + row.Cantidad);
            }
        }

        static void MostrarRecomendaciones(IBebidaAlcoholica bebida)
        {
            bebida.MaxRecomendado();
        }
    }
}