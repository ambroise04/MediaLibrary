using MediaLibrary.DAL.Interfaces;

namespace Library.DAL.UnitOfWork
{
    public interface IUnitOfWork
    {
        IMediaRepository MediaRepository { get; }
        ICategoryRepository CategoryRepository { get; }

        void CreateTransaction();
        void CommitTransaction();
        void RollbackTransaction();
        void Dispose();
    }
}