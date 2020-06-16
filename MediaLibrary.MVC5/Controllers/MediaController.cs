using Library.DAL.UnitOfWork;
using MediaLibrary.MVC5.Models;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace MediaLibrary.MVC5.Controllers
{
    public class MediaController : Controller
    {
        private IUnitOfWork unitOfWork;
        public MediaController()
        {
            unitOfWork = new UnitOfWork(new Media.DAL.Context.ADODbContext(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"));
        }

        public ActionResult Index()
        {
            var model = new MediaVM
            {
                Medias = unitOfWork.MediaRepository.GetAll(),
                Categories = unitOfWork.CategoryRepository.GetAll()
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(DAL.Entities.Media media, int Category, HttpPostedFileBase file)
        {
            if (file.ContentLength > 0)
            {
                media.Path = Path.GetFileName(file.FileName);
                media.Url = Path.Combine(Server.MapPath("~/images"), file.FileName);
            }
            var result = unitOfWork.MediaRepository.Insert(media);
            if (result != null)
            {
                return Json(new { status = true, message = "Media added successfully" });
            }

            return Json(new { status = false, message = "An error was encountered. Please try again later." });
        }
    }
}