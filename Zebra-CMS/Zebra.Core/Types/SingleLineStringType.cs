using System.Text;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class SingleLineStringType : ViewRender
    {
        FieldContext _context;

        public SingleLineStringType(FieldContext context)
        {
            _context = context;
        }

        public void SaveValue()
        {
             
        }

        public string GetValue()
        {
            // -> add get value from database via a wrapper.
            _context.Value = HttpUtility.HtmlEncode(_context.RawData.ToString());
            return _context.Value;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.Id).Append("' id='").Append(_context.Id).Append("'").Append(" value='"+_context.Value+"' /></p></div>");
            return sb.ToString();
        }
    }
}