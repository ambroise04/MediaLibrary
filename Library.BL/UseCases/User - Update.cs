using System;

namespace Library.BL.UseCases
{
    public partial class User
    {
        public MediaLibrary.DAL.Entities.Media UpdateMedia(MediaLibrary.DAL.Entities.Media media)
        {
            if (media is null)
                throw new ArgumentNullException();

            try
            {
                var result = unitOfWork.MediaRepository.Update(media);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}