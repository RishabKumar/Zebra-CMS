using System.Text;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class MultiLineStringType : ViewRender
    {
        public MultiLineStringType(FieldContext context)
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
            _context.Value = HttpUtility.HtmlEncode(_context.RawData.ToString());
            return _context.Value;
        }

        public override string GetProcessedValue()
        {
            return HttpUtility.HtmlDecode(_context.Value);
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><textarea rows='10' cols='100' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" >"+ GetProcessedValue() + "</textarea></p></div>");
 //           sb.Append(@"<script> $('#" + _context.FieldId + @"').val('"+ _context.Value + @"');</script>");
            return sb.ToString();
        }
    }
}