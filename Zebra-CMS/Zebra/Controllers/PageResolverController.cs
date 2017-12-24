using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.Application;
using Zebra.ModelView;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class PageResolverController : Controller
    {
        IPageOperations _pageopr;
        public PageResolverController(IPageOperations pageopr)
        {
            _pageopr = pageopr;
            ZebraContext.IsEditorMode = false;
        }
        // GET: PageResolver
        public ActionResult Index()
        {
            var layoutid = ZebraContext.Current.Page.PageLayout;
            var actions = ZebraContext.Current.Page.Actions;
            var layout = OperationsFactory.NodeOperations.GetValueForField(layoutid.Value.ToString(), "97C9C0EC-361D-47FA-B032-C8C8BE15019D");
            var model = new PageModel() { LayoutPath = layout, Actions = actions};
            return View(model:model);
        }

        private string AppendSlash(string path)
        {
            return path[path.Length - 1] == '/' ? path : path + "/";
        }
    }
}