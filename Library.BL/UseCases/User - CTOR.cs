using Library.DAL.UnitOfWork;

namespace Library.BL.UseCases
{
    public partial class User
    {
        private IUnitOfWork unitOfWork;
        public User(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
    }
}