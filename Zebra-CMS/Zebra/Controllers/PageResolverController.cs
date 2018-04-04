using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.Application;
using Zebra.ViewModel;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;
using Zebra.Constants;
using CacheCrow.Cache;
using static Zebra.Application.ZebraContext;

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
            var design = ZebraContext.Current.Page.PageDesign;
            var layout = OperationsFactory.NodeOperations.GetValueForField(layoutid.Value.ToString(), FieldId.LayoutPathFieldId);
            var model = new PageModel() { LayoutPath = layout, Design = design };
            return View(model:model);
        }

        private string AppendSlash(string path)
        {
            return path[path.Length - 1] == '/' ? path : path + "/";
        }
    }
}