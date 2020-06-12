using System.Collections.Generic;

namespace MediaLibrary.DAL.Entities
{
    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<Media> Medias { get; set; }
    }
}