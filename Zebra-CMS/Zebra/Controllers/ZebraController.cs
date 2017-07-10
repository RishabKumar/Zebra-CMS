using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;

namespace Zebra.Controllers
{
    [ZebraAuthorize]
    public abstract class ZebraController : Controller
    {
        // GET: Zebra
        public abstract ActionResult Index();
    }
}