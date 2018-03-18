using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web;
using System.Web.Http;
using Zebra.CustomAttributes;
using Zebra.Utilities.UtilityProcessor;

namespace Zebra.APIControllers
{
    [ZebraWebAPIAuthorize]
    public class UtilityServiceController : ApiController
    {
        [HttpPost]
        public object InvokeMethod([FromBody] string JsonData)
        {
            dynamic jsondata = JsonConvert.DeserializeObject<dynamic>(JsonData);
            string fullyqualifiedname = jsondata[0]["fullyqualifiedname"];
            string methodname = jsondata[1]["methodname"];
            object data = jsondata[2];
            try
            {
                var type = Type.GetType(fullyqualifiedname);
                Assembly assembly = null;
                if (type != null /*&& typeof(IZebraUtility).IsAssignableFrom(type)*/ && (assembly = Assembly.GetAssembly(type)) != null)
                {
                    var instance = Activator.CreateInstance(type, null);
                    var mi = type.GetMethod("HasExecutionRights");
                    var returndata = mi.Invoke(instance, new [] { data });
                    if (returndata.Equals(true))
                    {
                        mi = type.GetMethod(methodname);
                        returndata = mi.Invoke(instance, new[] { data });
                        return JsonConvert.SerializeObject(returndata);
                    }
                }
                return null;
            }
            catch(Exception e)
            {
                //log e
                return false;
            }
        }

    }
}
