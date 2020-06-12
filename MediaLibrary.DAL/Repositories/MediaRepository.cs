using MediaLibrary.DAL.Interfaces;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MediaLibrary.DAL.Repositories
{
    public class MediaRepository : IMediaRepository
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["MediaDB"].ConnectionString;
        public bool Delete(int id)
        {
            throw new System.NotImplementedException();
        }

        public ICollection<Entities.Media> GetAll()
        {
            throw new System.NotImplementedException();
        }

        public Entities.Media GetById(int id)
        {
            throw new System.NotImplementedException();
        }

        public Entities.Media Insert(Entities.Media entity)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                var cmd = new SqlCommand("spAddNew", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", employee.Name);
                cmd.Parameters.AddWithValue("@Position", employee.Position);
                cmd.Parameters.AddWithValue("@Office", employee.Office);
                cmd.Parameters.AddWithValue("@Age", employee.Age);
                cmd.Parameters.AddWithValue("@Salary", employee.Salary);
                cmd.ExecuteNonQuery();
            }
        }

        public Entities.Media Update(Entities.Media entity)
        {
            throw new System.NotImplementedException();
        }
    }
}