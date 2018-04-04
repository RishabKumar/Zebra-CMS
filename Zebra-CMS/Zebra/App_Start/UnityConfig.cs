using System.Web.Mvc;
using Microsoft.Practices.Unity;
using Unity.Mvc5;
using Zebra.DataRepository.DAL;
using Zebra.Services.Interfaces;
using Zebra.Core.Context;
using Zebra.Services.Operations;
using System.Web.Http;
using Zebra.DataRepository.Interfaces;
using Zebra.Globalization;
using Zebra.DataRepository.Models;

namespace Zebra
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
            var container = new UnityContainer();
            container.RegisterType(typeof(BaseRepository<>), typeof(UserRepository));
            container.RegisterType<INodeRepository, NodeRepository>();
            container.RegisterType<ILanguageRepository, LanguageRepository>();
            container.RegisterType<ITemplateRepository, TemplateRepository>();
            container.RegisterType<IUserOperations, UserOperations>();
            container.RegisterType<INodeOperations, NodeOperations>();
            container.RegisterType<IPageOperations, PageOperations>();
            container.RegisterType<IStructureOperations, NodeOperations>();
            container.RegisterType<IFieldOperations, FieldOperations>();

            container.RegisterType<FieldContext, FieldContext>();

            container.RegisterType<OperationsFactory>();
            container.RegisterInstance(container.Resolve<OperationsFactory>());
            container.RegisterInstance(container.Resolve<LanguageManager>());
            GlobalConfiguration.Configuration.DependencyResolver = new Unity.WebApi.UnityDependencyResolver(container);
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}

/*/
 * 
 * 
 *  container.RegisterType(typeof(BaseRepository<>), typeof(UserRepository));
            container.RegisterType<INodeRepository, NodeRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<ITemplateRepository, TemplateRepository>(new ContainerControlledLifetimeManager());
            container.RegisterType<IUserOperations, UserOperations>(new ContainerControlledLifetimeManager());
            container.RegisterType<INodeOperations, NodeOperations>(new ContainerControlledLifetimeManager());

            container.RegisterType<IStructureOperations, NodeOperations>(new ContainerControlledLifetimeManager());
            container.RegisterType<IFieldOperations, FieldOperations>(new ContainerControlledLifetimeManager());

            container.RegisterType<FieldContext, FieldContext>(new ContainerControlledLifetimeManager());
            GlobalConfiguration.Configuration.DependencyResolver = new Unity.WebApi.UnityDependencyResolver(container);
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
 * 
 * 
 * 
 * */
