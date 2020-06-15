using System;
using System.Collections.Generic;

namespace Library.BL.UseCases
{
    public partial class User
    {
        public ICollection<MediaLibrary.DAL.Entities.Media> GetAllMedias()
        {
            try
            {
                var list = unitOfWork.MediaRepository.GetAll();

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}