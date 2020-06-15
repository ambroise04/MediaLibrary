using MediaLibrary.DAL.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace Library.DAL.Tests.Media
{
    [TestClass]
    public class GetByIdMediaTests
    {
        [TestMethod]
        public void GetByIDMedia_CorrectMediaIdProvided_ReturnMediaRetrieved()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);
                var firstMedia = repository.GetAll().FirstOrDefault();
                //ACT
                var result = repository.GetById(firstMedia.Id);
                //ASSERT
                Assert.IsNotNull(result);
                Assert.AreEqual(firstMedia.Id, result.Id);
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