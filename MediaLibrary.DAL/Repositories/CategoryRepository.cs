using MediaLibrary.DAL.Entities;
using MediaLibrary.DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
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
            List<Category> categories = new List<Category>();

            SqlCommand cmd = new SqlCommand("spGetAllCategories", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                var category = new Category
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    Name = reader["Name"].ToString()
                };
                categories.Add(category);
            };

            connection.Close();

            return categories;
        }

        public Category GetById(int id)
        {
            if (id <= 0)
                throw new ArgumentException("Bad id was provided");

            Category media = new Category();

            SqlCommand cmd = new SqlCommand("spGetCategoryById", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                media.Id = Convert.ToInt32(reader["Id"]);
                media.Name = reader["Name"].ToString();
            }

            connection.Close();

            return media;
        }

        public Category Insert(Category entity)
        {
            if (entity is null)
                throw new ArgumentNullException(nameof(entity));

            var cmd = new SqlCommand("spAddCategory", connection);
            connection.Open();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", entity.Name);

            var result = cmd.ExecuteNonQuery();
            connection.Close();

            if (result > 0)
                return entity;
            else
                throw new Exception("An error was encountered when inserting media");
        }

        public Category Update(Category entity)
        {
            throw new System.NotImplementedException();
        }
    }
}