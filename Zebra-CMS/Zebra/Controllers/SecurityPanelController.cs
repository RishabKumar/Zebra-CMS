using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Zebra.CustomAttributes;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.Controllers
{
    public class SecurityPanelController : ZebraController
    {
        

        public SecurityPanelController(NodeOperations nodeOperations, FieldOperations fieldOperations, UserOperations userOperations) : base(nodeOperations, fieldOperations, userOperations, true)
        {
           
        }

        [ZebraAuthorize(Roles = "Editor")]
        public override ActionResult Index()
        {
            return RedirectToAction("SecurityEditor");
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult SecurityEditor()
        {
            Node root = _nodeop.GetRootNode();
            var list = new List<Node>();
            list.Add(root);
            ViewBag.Roles = _userOperations.GetAllRoles();
            ViewBag.Users = _userOperations.GetAllUsers();
            return View(model: list);
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult RoleEditor()
        {
            var list = _userOperations.GetAllRoles();
            List<Role> t = new List<Role>();
            var b = list == t;
            return PartialView(model: list);
        }

        public ActionResult PermissionBrowser(string nodeid, string roleid)
        {
            if (string.IsNullOrWhiteSpace(nodeid) || string.IsNullOrWhiteSpace(roleid))
            {
                return null;
            }
            var map = _userOperations.GetNodeRoleMap(nodeid, roleid);
            if (map == null)
            {
                map = new NodeRoleMap() { NonReadable = false, NonWritable = false };
            }
            return PartialView(model: map);
        }

        [ZebraAuthorize(Roles = "Editor")]
        public ActionResult UserEditor()
        {
            var roles = _userOperations.GetAllRoles();
            var users = _userOperations.GetAllUsers();
            ViewBag.Roles = roles;
            ViewBag.Users = users;
            return View();
        }
    }
}