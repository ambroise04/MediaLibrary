﻿using System.Data;
using System.Data.SqlClient;

namespace Media.DAL.Context
{
    public class ADODbContext
    {
        public readonly string _connectionString; /*ConfigurationManager.ConnectionStrings["MediaLibrary"].ConnectionString*/
        public readonly IDbConnection _connection;

        public ADODbContext(string connectionString)
        {
            _connectionString = connectionString;
            _connection = new SqlConnection(_connectionString);
        }
    }
}