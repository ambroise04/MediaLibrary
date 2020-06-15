using System;

namespace Library.BL.UseCases
{
    public partial class User
    {
        public bool DeleteMedia(int id)
        {
            if (id <= 0)
                throw new ArgumentException();

            try
            {
                var result = unitOfWork.MediaRepository.Delete(id);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}