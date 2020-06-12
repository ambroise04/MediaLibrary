using System.Collections.Generic;

namespace MediaLibrary.DAL.Interfaces
{
    public interface IRepository<T> where T : class
    {
        T Insert(T entity);
        T GetById(int id);
        ICollection<T> GetAll();
        bool Delete(int id);
        T Update(T entity);
    }
}