using contacts.Dato;
using contacts.Modelo;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace contacts
{
    public partial class Form1 : Form
    {
        DataTable tabla;
        Usuario dato = new Usuario();

        public Form1()
        {
            InitializeComponent();
            Iniciar();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            Agregar();
            Iniciar();
            Limpiar();
            Consultar();
        }

        private void Iniciar()
        {
            tabla = new DataTable();
            tabla.Columns.Add("Nombre");
            tabla.Columns.Add("Apellido");
            tabla.Columns.Add("Numero");
            grilla.DataSource = tabla;
        }

        private void Agregar()
        {
            UsuarioModelo modelo = new UsuarioModelo()
            {
                Nombre = textNombre.Text,
                Apellido = textApellido.Text,
                Numero = textNumero.Text,
            };

            dato.Agregar(modelo);
        }

        private void Consultar()
        {
            foreach (var item in dato.Consultar())
            {
                DataRow fila = tabla.NewRow();
                fila["Nombre"] = item.Nombre;
                fila["Apellido"] = item.Apellido;
                fila["Numero"] = item.Numero;
                tabla.Rows.Add(fila);
            }
        }

        public void Limpiar()
        {
            textNombre.Text = string.Empty;
            textApellido.Text = string.Empty;
            textNumero.Text = string.Empty;
        }
    }
}
