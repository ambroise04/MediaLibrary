using MediaLibrary.DAL.Entities;
using MediaLibrary.DAL.Enumerations;
using System.Collections.Generic;

namespace MediaLibrary.MVC5.Models
{
    public class MediaVM
    {
        public MediaType Type { get; set; }
        public ICollection<Category> Categories { get; set; }
        public ICollection<DAL.Entities.Media> Medias { get; set; }
    }
}