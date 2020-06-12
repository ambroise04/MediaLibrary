using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Media.DAL.Context
{
    public class ADODbContext : IDisposable
    {
        public readonly string _connectionString; /*ConfigurationManager.ConnectionStrings["MediaLibrary"].ConnectionString*/
        public readonly DbConnection _connection;

        public ADODbContext(string connectionString)
        {
            _connectionString = connectionString;
            _connection = new SqlConnection(_connectionString);
        }

        public ADODbContext(DbConnection connection)
        {
            _connection = connection;
        }

        public void Dispose()
        {
            _connection.Dispose();
        }
    }
}