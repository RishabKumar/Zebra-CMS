using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.Application;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class TestController : Controller
    {
        // GET: Test
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Heading()
        {
            var node = OperationsFactory.NodeOperations.GetNode(ZebraContext.Current.Page.PageNodeId.ToString());
            var values = node.GetFieldValues();
            return View(model:values["First Name"]);
        }

        public ActionResult Details()
        {
            return View();
        }
       

    }
}
