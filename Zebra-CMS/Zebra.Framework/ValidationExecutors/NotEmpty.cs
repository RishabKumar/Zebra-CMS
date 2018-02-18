using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Framework.Contexts;

namespace Zebra.Framework.ValidationExecutors
{
    public class NotEmpty
    {
        public bool Execute(FrameworkContext frameworkContext)
        {
            int count = frameworkContext.initiatornodecontext.FieldsData.Count;
            int notemptycount = frameworkContext.initiatornodecontext.FieldsData.Count(x => !string.IsNullOrEmpty(x.FieldValue));
            return count == notemptycount;
        }
    }
}
