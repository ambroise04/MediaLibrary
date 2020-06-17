using Library.DAL.UnitOfWork;
using MediaLibrary.MVC5.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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

        [HttpGet]
        public ActionResult Search(string search)
        {
            ICollection<DAL.Entities.Media> medias;

            if (!string.IsNullOrEmpty(search))
                medias = unitOfWork.MediaRepository.GetAll().Where(m => m.Name.ToLower().Contains(search.ToLower())).ToList();
            else
                medias = unitOfWork.MediaRepository.GetAll().ToList();
            
            return Json(new { data = medias }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(DAL.Entities.Media media, int Category, HttpPostedFileBase file)
        {
            if (file != null && file.ContentLength > 0)
            {
                media.Path = Path.GetFileName(file.FileName);
                media.Url = Path.Combine(Server.MapPath("~/images"), file.FileName);
                //file.SaveAs(media.Url);
            }

            media.Category = new DAL.Entities.Category { Id = Category };

            var result = unitOfWork.MediaRepository.Insert(media);
            if (result != null)
            {
                var data = unitOfWork.MediaRepository.GetAll();

                return Json(new { status = true, message = "Media added successfully", data });
            }


            return Json(new { status = false, message = "An error was encountered. Please try again later." });
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            if (id <= 0)
                return Json(new { status = false, message = "Bad parameter was provided." });

            var retrievedMedia = unitOfWork.MediaRepository.GetById(id);

            if (retrievedMedia is null)
                return Json(new { status = false, message = "No media found for the given parameter" });

            var result = unitOfWork.MediaRepository.Delete(id);

            if (!result)
                return Json(new { status = false, message = "Sorry, we encountered an error while processing your request. Please try again." });
            
            var data = unitOfWork.MediaRepository.GetAll();
           
            return Json(new { status = true, message = "Media deleted successfully.", data });
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            if (id <= 0)
                return Json(new { status = false, message = "Bad parameter was provided." });

            var retrievedMedia = unitOfWork.MediaRepository.GetById(id);

            if (retrievedMedia is null)
                return Json(new { status = false, message = "No media found for the given parameter" });

            var model = new MediaVM
            {
                Medias = unitOfWork.MediaRepository.GetAll(),
                Categories = unitOfWork.CategoryRepository.GetAll(),
                Media = retrievedMedia
            };

            return PartialView("_EditMedia", model);
        }

        [HttpPost]
        public ActionResult Edit(DAL.Entities.Media media, int Category)
        {
            if(media is null)
                return Json(new { status = false, message = "Sorry, your request cannot be processed. Please try again." });

            if (media.Id <= 0)
                return Json(new { status = false, message = "Bad parameter was provided." });

            media.Category = new DAL.Entities.Category { Id = Category };
            var result = unitOfWork.MediaRepository.Update(media);

            if (result is null)
                return Json(new { status = false, message = "Sorry, an error was encountered. Please try again." });

            var data = unitOfWork.MediaRepository.GetAll();

            return Json(new { status = true, message = "Media updated successfully.", data});
        }
    }
}