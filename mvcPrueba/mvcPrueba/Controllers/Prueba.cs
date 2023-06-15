using Microsoft.AspNetCore.Mvc;

namespace mvcPrueba.Controllers
{
    public class Prueba : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
