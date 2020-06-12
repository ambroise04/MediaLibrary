using MediaLibrary.DAL.Entities;
using System.Data.Entity;

namespace Media.DAL.Context
{
    public class EFContext : DbContext
    {
        public EFContext() : base(@"Server=(localdb)\mssqllocaldb; Database=MediaLibrary;Trusted_Connection=True;MultipleActiveResultSets=true")
        {}

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<MediaLibrary.DAL.Entities.Media> Medias { get; set; }
        public DbSet<Category> Categories { get; set; }
    }
}