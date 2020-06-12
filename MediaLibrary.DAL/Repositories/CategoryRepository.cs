using MediaLibrary.DAL.Entities;
using MediaLibrary.DAL.Interfaces;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace MediaLibrary.DAL.Repositories
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly SqlConnection connection;
        private readonly string connectionString;
        public CategoryRepository(SqlConnection connection)
        {
            this.connection = connection;
        }

        public bool Delete(int id)
        {
            throw new System.NotImplementedException();
        }

        public ICollection<Category> GetAll()
        {
            throw new System.NotImplementedException();
        }

        public Category GetById(int id)
        {
            throw new System.NotImplementedException();
        }

        public Category Insert(Category entity)
        {
            throw new System.NotImplementedException();
        }

        public Category Update(Category entity)
        {
            throw new System.NotImplementedException();
        }
    }
}