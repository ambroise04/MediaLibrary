using Effort;
using Effort.Provider;
using Media.DAL.Context;
using MediaLibrary.DAL.Entities;
using MediaLibrary.DAL.Enumerations;
using MediaLibrary.DAL.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.Common;
using System.Data.SqlClient;

namespace Library.DAL.Tests.Media
{
    [TestClass]
    public class AddMediaTests
    {
        [TestMethod]
        public void AddMedia_ReturnAddedMedia()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using(var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);
                var media = new MediaLibrary.DAL.Entities.Media
                {
                    Name = "Programming in C#",
                    Url = @"C:\Users\Ambroise\Desktop\UNamur",
                    Path = @"C:\Users\Ambroise\Desktop\UNamur",
                    Type = MediaType.Book,
                    Done = true
                };
                //ACT
                var result = repository.Insert(media);
                //ASSERT
                Assert.IsNotNull(result);
                Assert.AreEqual("Programming in C#", result.Name);
            }
        }
    }
}