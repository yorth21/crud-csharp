using Microsoft.AspNetCore.Mvc;
using mvcPrueba.Models;
using System.Diagnostics;
using System.Reflection;

namespace mvcPrueba.Controllers
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
            return View();
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

        public IActionResult Prueba()
        {
            List<PruebaVewModel> lista = new List<PruebaVewModel>();
            lista = PruebaVewModel.Get();

            return View(lista);
        }

        public IActionResult Insert(int Id)
        {
            PruebaVewModel model = new PruebaVewModel();
            model.Id = Id;

            if (model.Id != 0)
            {
                model = PruebaVewModel.GetId(Id);
            }

            return View(model);
        }

        [HttpPost]
        public IActionResult Insert(PruebaVewModel vewModel)
        {
            if (vewModel.Id != 0)
            {
                PruebaVewModel.Put(vewModel);
            } else
            {
                PruebaVewModel.Post(vewModel);
            }


            List<PruebaVewModel> lista = new List<PruebaVewModel>();
            lista = PruebaVewModel.Get();

            //return RedirectToAction("Prueba", lista);
            return View("Prueba", lista);

        }

        public IActionResult Delete(int Id)
        {
            PruebaVewModel.Delete(Id);

            List<PruebaVewModel> lista = new List<PruebaVewModel>();
            lista = PruebaVewModel.Get();

            return View("Prueba", lista);
        }
    }
}