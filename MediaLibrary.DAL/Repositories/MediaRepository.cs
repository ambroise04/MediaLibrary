using MediaLibrary.DAL.Enumerations;
using MediaLibrary.DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace MediaLibrary.DAL.Repositories
{
    public class MediaRepository : IMediaRepository
    {
        private readonly SqlConnection connection;

        public MediaRepository(DbConnection connection)
        {
            this.connection = (SqlConnection)connection;
        }

        public bool Delete(int id)
        {
            if (id <= 0)
                throw new ArgumentException("Bad id was provided");

            SqlCommand cmd = new SqlCommand("spDeleteMedia", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            connection.Open();
            cmd.Parameters.AddWithValue("@Id", id);
            var result = cmd.ExecuteNonQuery();
            connection.Close();

            return result > 0;
        }

        public ICollection<Entities.Media> GetAll()
        {
            List<Entities.Media> medias = new List<Entities.Media>();

            SqlCommand cmd = new SqlCommand("spGetMediaById", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                var media = new Entities.Media
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    Name = reader["Name"].ToString(),
                    Url = reader["Url"].ToString(),
                    Path = reader["Path"].ToString(),
                    Type = (MediaType)Convert.ToInt32(reader["Path"]),
                    Done = Convert.ToBoolean(reader["Done"])
                };
                medias.Add(media);
            };

            connection.Close();

            return medias;
        }

        public Entities.Media GetById(int id)
        {
            if (id <= 0)
                throw new ArgumentException("Bad id was provided");

            Entities.Media media = new Entities.Media();

            SqlCommand cmd = new SqlCommand("spGetMediaById", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            connection.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                media.Id = Convert.ToInt32(reader["Id"]);
                media.Name = reader["Name"].ToString();
                media.Url = reader["Url"].ToString();
                media.Path = reader["Path"].ToString();
                media.Type = (MediaType)Convert.ToInt32(reader["Path"]);
                media.Done = Convert.ToBoolean(reader["Done"]);
            }

            connection.Close();

            return media;
        }

        public Entities.Media Insert(Entities.Media entity)
        {
            if (entity is null)
                throw new ArgumentNullException(nameof(entity));

            var cmd = new SqlCommand("spAddMedia", connection);
            connection.Open();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", entity.Name);
            cmd.Parameters.AddWithValue("@Url", entity.Url);
            cmd.Parameters.AddWithValue("@Path", entity.Path);
            cmd.Parameters.AddWithValue("@Type", entity.Type);
            cmd.Parameters.AddWithValue("@Done", entity.Done);

            var result = cmd.ExecuteNonQuery();
            connection.Close();

            if (result > 0)
                return entity;
            else
                throw new Exception("An error was encountered when inserting media");
        }

        public Entities.Media Update(Entities.Media entity)
        {
            if (entity is null)
                throw new ArgumentNullException(nameof(entity));
            if (entity.Id <= 0)
                throw new ArgumentException("The provided media has wrong properties. Please check the object's id.");

            var cmd = new SqlCommand("spUpdateMedia", connection);
            connection.Open();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", entity.Id);
            cmd.Parameters.AddWithValue("@Name", entity.Name);
            cmd.Parameters.AddWithValue("@Url", entity.Url);
            cmd.Parameters.AddWithValue("@Path", entity.Path);
            cmd.Parameters.AddWithValue("@Type", entity.Type);
            cmd.Parameters.AddWithValue("@Done", entity.Done);

            var result = cmd.ExecuteNonQuery();
            connection.Close();

            if (result > 0)
                return entity;
            else
                throw new Exception("An error was encountered when updating media");
        }
    }
}