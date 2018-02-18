using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;
using Zebra.DataRepository.DAL;

namespace Zebra.Core.Types
{
    class NodeLinkType : SingleLineStringType
    {
        public NodeLinkType(FieldContext context) : base(context)
        {
            _context = context;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p></div>");
            sb.Append(@"
            <input type='button' value='Attach Node' onclick='ChooseNode()' />
            <script type='text/javascript'> 
            function ChooseNode()
            {
                    ShowModelTreePopup(" + "'11111111-1111-1111-1111-111111111111'" + @", null, null, null, function(nodeid){
                         $('#"+_context.FieldId+@"').val($(ZebraEditor_currentnode.element.parentElement).attr('data-nodeid'));
                    }); 
            }
            </script>");
            return sb.ToString();
        }
    }
}