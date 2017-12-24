using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Core.Context;

namespace Zebra.Core.Types
{
    class LayoutType : SingleLineStringType
    {
        public LayoutType(FieldContext context) : base(context)
        {
            _context = context;
        }

        public override string GetValue()
        {
            _context.Value = _context.RawData.ToString();
            return _context.Value;
        }

        public override string GetProcessedValue()
        {
            var tmp = _context.Value;
            var id = tmp.Split(',');
            if(id.Length > 0)
            {
                return id[1].Trim();
            }
            return string.Empty;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p></div>");
            sb.Append(@"
                <input type='button' onclick='ChooseLayout()' value='Choose' /> 
                <script type='text/javascript'> 
                    function ChooseLayout()
                    {
debugger;
                        ShowModelTreePopup(" + "'67F9BD9C-BF7D-4C90-BD9F-E9FE399FC474'" + @", null, null, null, function(nodeid){
                            $('#" + _context.FieldId + @"').val($(ZebraEditor_currentnode.element).html() +', '+ $(ZebraEditor_currentnode.element.parentElement).attr('data-nodeid'));
                        });
                    
                    }
                </script>
                ");

            return sb.ToString();
        }
    }
}
