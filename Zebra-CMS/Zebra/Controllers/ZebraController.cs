using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Zebra.Application;
using Zebra.CustomAttributes;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    [ZebraAuthorize]
    public abstract class ZebraController : Controller
    {
        protected INodeOperations _nodeop;
        protected IFieldOperations _fieldOperations;
        protected IUserOperations _userOperations;
        public ZebraController(INodeOperations nodeOperations, IFieldOperations fieldOperations, IUserOperations userOperations, bool EditorMode = false)
        {
            _nodeop = nodeOperations;
            _fieldOperations = fieldOperations;
            _userOperations = userOperations;
            ZebraContext.IsEditorMode = EditorMode;
        }
        // GET: Zebra
        public abstract ActionResult Index();

        public User CurrentUser
        {
            get
            {
                var authCookie = HttpContext.Request.Cookies[FormsAuthentication.FormsCookieName];
                if (authCookie != null)
                {
                    FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                    if (authTicket != null && !authTicket.Expired && !string.IsNullOrWhiteSpace(authTicket.UserData))
                    {
                        var userid = authTicket.UserData;
                        return _userOperations.Getuser(userid);
                    }
                }
                return null;
            }
        }
    }
}