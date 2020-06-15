using System;
namespace Library.BL.UseCases
{
    public partial class User
    {
        public MediaLibrary.DAL.Entities.Media GetMediaById(int id)
        {
            if (id <= 0)
                throw new ArgumentException();

            try
            {
                var result = unitOfWork.MediaRepository.GetById(id);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}