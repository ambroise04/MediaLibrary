using MediaLibrary.DAL.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace Library.DAL.Tests.Media
{
    [TestClass]
    public class GetAllMediasTests
    {
        [TestMethod]
        public void GetAllMedias_ReturnAllMedias()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);
                //ACT
                var result = repository.GetAll();
                //ASSERT
                Assert.IsNotNull(result);
                Assert.AreNotEqual(0, result.Count());
            }
        }

        [TestMethod]
        public void GetByIDMedia_BAdMediaIdProvided_ThrowArgumentException()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);

                //ACT
                //ASSERT
                Assert.ThrowsException<ArgumentException>(() => repository.GetById(0));
                Assert.ThrowsException<ArgumentException>(() => repository.GetById(-1));
            }
        }
    }
}