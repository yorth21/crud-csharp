using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project01.Models
{
    class Cerveza : Bebida, IBebidaAlcoholica
    {
        public int Alcohol { get; set; }
        public string Marca { get; set; }
        public void MaxRecomendado()
        {
            Console.WriteLine("El maximo permitido son 10");
        }
        public Cerveza(string Nombre, string Marca, int Alcohol, int Cantidad) : base(Nombre, Cantidad)
        {
            this.Alcohol = Alcohol;
            this.Marca = Marca;
        }
    }
}
