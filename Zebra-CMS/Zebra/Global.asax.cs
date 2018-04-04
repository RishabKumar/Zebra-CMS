//using Microsoft.Practices.Unity.Mvc;
using CacheCrow.Cache;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Operations;
using static Zebra.Application.ZebraContext;

namespace Zebra
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            UnityConfig.RegisterComponents();

            HttpContext.Current.Items.Add("DTOContextContainer", new DTOContextContainer());
            OperationsFactory.PageOperations.Initialize();
            CacheCrow<string, PageDesign>.Initialize();
        }

        protected void Application_EndRequest(object sender, EventArgs e)
        {
            //OperationsFactory.FieldOperations.Dispose();
            //OperationsFactory.NodeOperations.Dispose();
            //OperationsFactory.StructureOperations.Dispose();
            //OperationsFactory.UserOperations.Dispose();
            //          EFContextContainer.GetInstance().Dispose();
        }
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            //          EFContextContainer.GetInstance();
            HttpContext.Current.Items.Add("DTOContextContainer", new DTOContextContainer());
        }


        protected void Application_Dispose(object sender, EventArgs e)
        {
            
        }


            //protected void Application_PostAuthenticateRequest(Object sender, EventArgs e)
            //{
            //    var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
            //    if (authCookie != null)
            //    {
            //        FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            //        if (authTicket != null && !authTicket.Expired)
            //        {
            //            var roles = authTicket.UserData.Split(',');
            //            HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(new FormsIdentity(authTicket), roles);
            //        }
            //    }
            //}
        }
}
