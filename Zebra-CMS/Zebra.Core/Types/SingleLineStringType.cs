using System.Text;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class SingleLineStringType : ViewRender
    {
        public SingleLineStringType(FieldContext context)
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
            return _context.Value;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='"+_context.Value+"' /></p></div>");
            return sb.ToString();
        }
    }
}