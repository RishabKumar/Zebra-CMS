using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Core.Context;
using Zebra.Core.Renderers;

namespace Zebra.Core.Types
{
    class ListType : SingleLineStringType
    {
        public ListType(FieldContext context) : base(context)
        {
            _context = context;
        }

        public override string DoRender()
        {

            string tmp = _context.Value ?? string.Empty;
            var values = tmp.Split(new char[] {','}, StringSplitOptions.RemoveEmptyEntries);
            string ollist = string.Empty;
            foreach (var value in values)
            {
                var temp = value.Split('=');
                if (temp.Length > 1)
                {
                    var name = temp[0];
                    var id = temp[1];
                    ollist += "<li name='" + name + "'  id='" + id + "' > " + name + " <i class='fa fa-remove' onclick=RemoveElement('" + id + "')></i></li>";
                }
            }
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name);
            
            sb.Append(@"
                <input type='hidden' name='"+_context.FieldId+@"' id='"+_context.FieldId+@"' value='"+_context.Value+ @"'/>
                <i onclick='ChooseNode()' class='fa fa-plus-square' ></i> 
                <ol class='list-" + _context.FieldId + @"'>
                "+ ollist + @"    
                </ol>

                <script type='text/javascript'> 
                    function ChooseNode()
                    {
                           ShowModelTreePopup(" + "'11111111-1111-1111-1111-111111111111'" + @", null, null, null, function(nodeid){
                                AddNewElement($(ZebraEditor_currentnode.element).html(), $(ZebraEditor_currentnode.element.parentElement).attr('data-nodeid'));
                            }); 
                    }

                    function UpdateValue()
                    {
                        debugger;
                        var elements = $('.list-" + _context.FieldId + @" li');
                        var valueElement = $('#" + _context.FieldId + @"');
                        valueElement.val('');
                        for(var i = 0; i < elements.length; i++)
                        {
                            valueElement.val(function(){return this.value + $(elements[i]).attr('name') + '=' + $(elements[i]).attr('id')+',';});
                        }
                    }

                    function RemoveElement(id)
                    {
                        $('.list-" + _context.FieldId + @" li[id='+id+']').remove();
                        UpdateValue();
                    }

                    function AddNewElement(name, id)
                    { 
                        $('.list-" + _context.FieldId + @"').append('<li name=\''+name+'\' id='+id+'>'+name+'<i class=\'fa fa-remove\' onclick=RemoveElement(\''+id+'\')></i></li>');
                        UpdateValue();
                    }
                </script>
                ");
           

            return sb.ToString();
        }
    }
}
