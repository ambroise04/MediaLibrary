using Library.DAL.UnitOfWork;
using MediaLibrary.DAL.Interfaces;
using MediaLibrary.DAL.Repositories;
using System.Web.Mvc;
using Unity;
using Unity.Mvc5;

namespace MediaLibrary.MVC5
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            //My services
            container.RegisterType<IUnitOfWork, UnitOfWork>();
            container.RegisterType<IMediaRepository, MediaRepository>();
            container.RegisterType<ICategoryRepository, CategoryRepository>();

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}