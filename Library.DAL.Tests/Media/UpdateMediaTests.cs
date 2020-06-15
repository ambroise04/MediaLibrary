using MediaLibrary.DAL.Enumerations;
using MediaLibrary.DAL.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;
using System.Linq;

namespace Library.DAL.Tests.Media
{
    [TestClass]
    public class UpdateMediaTests
    {
        [TestMethod]
        public void UpdateMedia_CorrectMediaIdProvided_ReturnUpdatedMedia()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);

                var media = new MediaLibrary.DAL.Entities.Media
                {
                    Name = "Use of Flexbox",
                    Url = @"C:\Users\Ambroise\Desktop\UNamur",
                    Path = @"C:\Users\Ambroise\Desktop\UNamur",
                    Type = MediaType.Film,
                    Done = true
                };
                var addedMedia = repository.Insert(media);
                var retrievedMedia = repository.GetAll().FirstOrDefault(m => m.Name.Equals(media.Name));
                retrievedMedia.Name = "New name";
                //ACT
                var result = repository.Update(retrievedMedia);
                //ASSERT
                Assert.IsNotNull(result);
                Assert.AreEqual("New name", result.Name);
            }
        }

        [TestMethod]
        public void UpdateMedia_NullMediaProvided_ThrowArgumentNullException()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);

                //ACT
                //ASSERT
                Assert.ThrowsException<ArgumentNullException>(() => repository.Update(null));
            }
        }

        [TestMethod]
        public void UpdateMedia_MediaProvidedWithBadId_ThrowArgumentException()
        {
            var connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MediaLibrary;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            using (var connection = new SqlConnection(connectionString))
            {
                //ARRANGE
                var repository = new MediaRepository(connection);

                var media = new MediaLibrary.DAL.Entities.Media
                {
                    Name = "Use of Flexbox",
                    Url = @"C:\Users\Ambroise\Desktop\UNamur",
                    Path = @"C:\Users\Ambroise\Desktop\UNamur",
                    Type = MediaType.Film,
                    Done = true
                };
                var addedMedia = repository.Insert(media);
                var retrievedMedia = repository.GetAll().FirstOrDefault(m => m.Name.Equals(media.Name));
                retrievedMedia.Id = 0;
                //ACT
                //ASSERT
                Assert.ThrowsException<ArgumentException>(() => repository.Update(retrievedMedia));
            }
        }
    }
}