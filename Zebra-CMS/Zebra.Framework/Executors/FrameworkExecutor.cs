using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Framework.Contexts;

namespace Zebra.Framework.Executors
{
    public static class FrameworkExecutor
    {
        public static void Execute(FrameworkContext fwcontext)
        {
            var classType =  fwcontext.frameworknodecontext.FieldsData.Where(x=>x.FieldName == "Type").Select(y=>y.FieldValue).FirstOrDefault();
            if (!string.IsNullOrWhiteSpace(classType))
            {
                var type = Type.GetType(classType);
                var obj = Activator.CreateInstance(type);
                var mi = type.GetMethod("Execute");
                var data = mi.Invoke(obj, new[] { fwcontext }).ToString();
            }
        }
    }
}
