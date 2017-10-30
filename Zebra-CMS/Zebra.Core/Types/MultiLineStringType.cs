using System.Text;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class MultiLineStringType : ViewRender
    {
        FieldContext _context;

        public MultiLineStringType(FieldContext context)
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
            sb.Append("<div>").Append(_context.Name).Append("<p><textarea name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append("/>"+ _context.Value + "</textarea></p></div>");
            return sb.ToString();
        }
    }
}