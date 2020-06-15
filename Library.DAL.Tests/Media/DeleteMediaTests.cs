using MediaLibrary.DAL.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace Library.DAL.Tests.Media
{
    [TestClass]
    public class DeleteMediaTests
    {
        [TestMethod]
        //For this test, check whether the database contains at least one row before running
        public void DeleteMedia_CorrectMediaIdProvided_ReturnTrue()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);
                var media = repository.GetAll().Last();
                //ACT
                var result = repository.Delete(media.Id);
                //ASSERT
                Assert.IsTrue(result);
            }
        }

        [TestMethod]
        public void DeleteMedia_BadMediaIdProvided_ThrowArgumentException()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);

                //ACT
                //ASSERT
                Assert.ThrowsException<ArgumentException>(() => repository.Delete(0));
                Assert.ThrowsException<ArgumentException>(() => repository.Delete(-1));
            }
        }
    }
}