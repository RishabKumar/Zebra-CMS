using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Framework.Contexts;
using Zebra.Services.Operations;

namespace Zebra.Utilities.UtilityProcessor
{
    public class ValidationUtility : IZebraUtility
    {
        public bool HasExecutionRights(ref object obj)
        {
            return true;
        }

        public dynamic Process(ref object obj)
        {
            if (obj != null)
            {
                dynamic data = (dynamic)obj;
                data = JsonConvert.DeserializeObject(data[0]);
                string nodeid = data[0]["nodeid"];
                FrameworkOperations.Execute(nodeid, ProcessType.VALIDATION_TYPE, null);
                return true;
            }
            return false;
        }

        public string RenderView(ref object obj)
        {
            return "~/Utilities/UtilityViews/Framework/Validation/Validation.cshtml";
        }
    }
}