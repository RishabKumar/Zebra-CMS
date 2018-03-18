using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Application;
using Zebra.Framework.Contexts;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public class RoadmapUtility : IZebraUtility
    {
        public bool HasExecutionRights(ref object obj)
        {
            if (obj != null) 
            {
                dynamic data;
                try
                {
                    data = (dynamic)obj;
                    data = JsonConvert.DeserializeObject(data[0]);
                }
                catch
                {
                    return true;
                }
                string nodeid = data[0]["nodeid"];
                //var roles = ZebraContext.Current.CurrentUser.RoleUserMaps.Select(x => OperationsFactory.UserOperations.GetRole(x.RoleId.ToString()));
                var node = OperationsFactory.NodeOperations.GetNode(nodeid);
                var roadmapid = OperationsFactory.NodeOperations.GetValueForField(node.Id.ToString(), "EC9F06A6-4194-4332-B58F-957FC4FD25B4");
                var roadmap = OperationsFactory.NodeOperations.GetNode(roadmapid);
                if (null == OperationsFactory.UserOperations.FilterByUser(ZebraContext.Current.CurrentUser, roadmap))
                {
                    return false;
                }
                else
                    return true;
            }
            else
                return true;
        }

        public dynamic Process(ref object obj)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                data = JsonConvert.DeserializeObject(data[0]);
                string nodeid = data[0]["nodeid"];
                dynamic parameters = data[0];
                FrameworkOperations.Execute(nodeid, ProcessType.ROADMAP_TYPE, parameters);
                return true;
            }
            return false;
        }

        public string RenderView(ref object obj)
        {
            return "~/Utilities/UtilityViews/Framework/Roadmap/Roadmap.cshtml";
        }
    }
}