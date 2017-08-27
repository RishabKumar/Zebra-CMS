using System.Web.Mvc;
using Microsoft.Practices.Unity;
using Unity.Mvc5;
using Zebra.DataRepository.DAL;
using Zebra.Services.Interfaces;
using Zebra.Core.Context;
using Zebra.Services.Operations;
using System.Web.Http;
using Zebra.DataRepository.Interfaces;

namespace Zebra
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType(typeof(BaseRepository<>), typeof(UserRepository));
            container.RegisterType<INodeRepository, NodeRepository>();
            container.RegisterType<ITemplateRepository, TemplateRepository>();
            container.RegisterType<IUserOperations, UserOperations>();
            container.RegisterType<INodeOperations, NodeOperations>();
            container.RegisterType<IFieldOperations, FieldOperations>();
            container.RegisterType<FieldContext, FieldContext>();
            GlobalConfiguration.Configuration.DependencyResolver = new Unity.WebApi.UnityDependencyResolver(container);
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}