using Library.DAL.UnitOfWork;
using System.Configuration;
using System.Web.Mvc;

namespace MediaLibrary.MVC5.Controllers
{
    public class HomeController : Controller
    {
        private IUnitOfWork unitOfWork;
        public HomeController()
        {
            unitOfWork = new UnitOfWork(new Media.DAL.Context.ADODbContext(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"));
        }

        public ActionResult Index()
        {
            var medias = unitOfWork.MediaRepository.GetAll();
            return View(medias);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}