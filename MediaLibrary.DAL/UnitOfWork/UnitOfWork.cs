using Media.DAL.Context;
using MediaLibrary.DAL.Interfaces;
using MediaLibrary.DAL.Repositories;
using System.Data.SqlClient;

namespace Library.DAL.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ADODbContext Context;
        private SqlConnection Connection;
        private SqlTransaction Transaction;

        private readonly IMediaRepository mediaRepository;
        private readonly ICategoryRepository categoryRepository;

        public UnitOfWork(ADODbContext context)
        {
            Context = context;
            Connection = new SqlConnection(Context._connectionString);
        }

        public IMediaRepository MediaRepository => mediaRepository ?? new MediaRepository(Connection);

        public ICategoryRepository CategoryRepository => categoryRepository ?? new CategoryRepository(Connection);

        public void CreateTransaction()
        {                        
            Transaction = Connection.BeginTransaction();
        }

        public void CommitTransaction()
        {
            Transaction.Commit();
            Dispose();
        }

        public void RollbackTransaction()
        {
            Transaction.Rollback();
            Dispose();
        }

        public void Dispose()
        {
            Connection.Dispose();
        }
    }
}