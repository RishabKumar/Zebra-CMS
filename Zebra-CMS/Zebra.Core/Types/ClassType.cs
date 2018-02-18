using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class ClassType : ViewRender
    {
        public ClassType(FieldContext context)
        {
            _context = context;
        }

        public override string SaveValue()
        {
            return _context.Value;
        }

        public override string GetValue()
        {
            // -> add get value from database via a wrapper.
            _context.Value = _context.RawData == null ? string.Empty : HttpUtility.HtmlEncode(_context.RawData.ToString());
            return _context.Value;
        }

        public override string GetProcessedValue()
        {
            //if (!string.IsNullOrWhiteSpace(_context.Value))
            //{
            //    var type = Type.GetType(_context.Value);
            //    var obj = Activator.CreateInstance(type);

            //    var mi = type.GetMethod("Validate");
            //    var data = mi.Invoke(obj, null).ToString();
            //}
            return _context.Value;
        }

        public override string DoRender()
        {
            var data = GetProcessedValue();
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p></div>");
            return sb.ToString();
        }
    }
}
