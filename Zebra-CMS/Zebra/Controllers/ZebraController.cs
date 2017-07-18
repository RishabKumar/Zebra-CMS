using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;
using Zebra.DataRepository.DAL;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    [ZebraAuthorize]
    public abstract class ZebraController : Controller
    {
        public INodeOperations _nodeop;
        public ZebraController (NodeOperations nodeOperations)
        {
            _nodeop = nodeOperations;
        }
        // GET: Zebra
        public abstract ActionResult Index();
    }
}