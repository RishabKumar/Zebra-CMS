using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Framework.Contexts;
using Zebra.Services.Operations;

namespace Zebra.Framework.ValidationExecutors
{
    public class NotEmpty
    {
        public bool Execute(FrameworkContext frameworkContext)
        {
            var frameworknodefieldata = frameworkContext.frameworknodecontext.FieldsData.Where(x => x.FieldName == "Params").FirstOrDefault();
            var param = frameworknodefieldata.FieldValue;
            if (!string.IsNullOrWhiteSpace(param))
            {
                var paramnamevalue = HttpUtility.ParseQueryString(param);
                var fieldname = paramnamevalue["fieldname"];
                return 1 == frameworkContext.initiatornodecontext.FieldsData.Where(x => x.FieldName == fieldname && !string.IsNullOrEmpty(x.FieldValue)).Count();
            }
            else
            {
                int count = frameworkContext.initiatornodecontext.FieldsData.Count;
                int notemptycount1 = frameworkContext.initiatornodecontext.FieldsData.Count(x=>!string.IsNullOrEmpty(x.FieldValue));
                int notemptycount = frameworkContext.initiatornodecontext.FieldsData.Count(x => x.FieldValue.Count() > 0 || !string.IsNullOrEmpty(x.FieldValue));
                return count == notemptycount;
            }
        }
    }
}
