using System.Collections.Generic;

namespace MediaLibrary.DAL.Entities
{
    public class Category
    {
        public Category()
        {
            this.Medias = new HashSet<Media>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public virtual ICollection<Media> Medias { get; set; }
    }
}