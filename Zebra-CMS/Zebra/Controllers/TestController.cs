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

        public ActionResult Heading(string datasource)
        {
            var nodeid = ZebraContext.Current.Page.PageNodeId;
            var node = OperationsFactory.NodeOperations.GetNode(nodeid.ToString());
            var fieldata = node.GetFieldValues();
            ViewBag.Title = fieldata["Test"];
            ViewBag.Meta = fieldata["META"];
            ViewBag.Copyrights = fieldata["Copyrights"];
            return PartialView();
        }

        public ActionResult Details(string datasourceidwersdf4r)
        {
            return PartialView();
        }
    }
}
