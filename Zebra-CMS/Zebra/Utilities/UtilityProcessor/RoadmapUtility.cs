using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public class RoadmapUtility : IZebraUtility
    {
        public dynamic Process(ref object obj)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                data = JsonConvert.DeserializeObject(data[0]);
                string nodeid = data[0]["nodeid"];
                dynamic parameters = data[0];
                FrameworkOperations.Execute(nodeid, 0, parameters);
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