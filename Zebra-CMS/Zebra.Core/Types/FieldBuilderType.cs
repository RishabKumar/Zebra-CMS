using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;

namespace Zebra.Core.Types
{
    class FieldBuilderType
    {
        FieldContext _context;

        public FieldBuilderType(FieldContext context)
        {
            _context = context;
        }

        public void SaveValue(string value)
        {
            _context.Value = value;
        }

        public string GetValue()
        {
            // -> add get value from database via a wrapper.
            return _context.Value;
        }

        public string DoRender()
        {
            StringWriter sw = new StringWriter();
            HttpContext.Current.Server.Execute("/Views/FieldBuilder.html", sw, false);

            return sw.ToString();
        }
    }
}
