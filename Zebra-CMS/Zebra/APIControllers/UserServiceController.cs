using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Operations;

namespace Zebra.APIControllers
{
    public class UserServiceController : ApiController
    {
        private IUserOperations _userOperations;

        public UserServiceController() : base()
        {
            _userOperations = OperationsFactory.UserOperations;
        }

        [HttpPost]
        public bool AddRole()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = JsonConvert.DeserializeObject(json);
            bool flag = true;
            foreach (var t in tmp)
            {
                flag &= _userOperations.CreateRole(t.Value) != null;
            }
            return flag;
        }

        [HttpPost]
        public void UpdatePermissions()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = ((dynamic)JsonConvert.DeserializeObject(json))[0];
            var nodeid = tmp["nodeid"].Value;
            var roleid = tmp["roleid"].Value;
            var readable = tmp["readable"].Value;
            var writable = tmp["writable"].Value;
            _userOperations.AddOrUpdatePermissions(roleid, nodeid, readable, writable);
        }

        [HttpPost]
        public void AddUser()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = ((dynamic)JsonConvert.DeserializeObject(json));
            var username = tmp["username"].Value;
            var password = tmp["password"].Value;
            var roles = new List<string>();
            JArray jroles = tmp["roles"];
            User user = _userOperations.CreateUser(username, password);
            if(user != null && user.Id != Guid.Empty)
            foreach (var role in jroles)
            {
                _userOperations.AssignRole(user.Id.ToString(), role.Value<string>());
            }
        }

        [HttpPost]
        public void DeleteUser()
        {
            var json = HttpContext.Current.Request.Form[0];
            dynamic tmp = ((dynamic)JsonConvert.DeserializeObject(json));
            var userid = tmp["userid"].Value;
            _userOperations.DeleteUser(userid);
        }
    }
}
