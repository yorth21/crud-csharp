using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using tiendaBD.Models;

namespace tiendaBD.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            List<ClienteViewModel> lista = new List<ClienteViewModel>();
            lista = ClienteViewModel.Get();

            return View(lista);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        // METODOS PARA EL CRUD

        public IActionResult Add()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Add(ClienteViewModel viewModel)
        {
            bool add = ClienteViewModel.Post(viewModel);

            if (add)
            {
                return Json(new { success = true, message = "Se agrego correctamente" });
            }
            else
            {
                return Json(new { success = false, message = "No se pudo agregar el cliente" });
            }
        }

        public IActionResult Delete(int Id)
        {
            bool eliminado = ClienteViewModel.Delete(Id);

            if (eliminado)
            {
                return Json(new { success = true, message = "Eliminación exitosa" });
            }
            else
            {
                return Json(new { success = false, message = "No se pudo eliminar el elemento" });
            }
        }

    }
}