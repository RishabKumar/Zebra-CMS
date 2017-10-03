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

    // This type has to be removed. A separate utility has to be written for the fieldbuilder. Fieldbuilder was
    // added as a type, it was getting inherited to the child nodes. The proposed utility will attach itself with any node/template(need to confirm exactly on which).
    // nodes created from other nodes(not templates) also gets the parent's template field ?
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
            return _context.Value;
        }

        public string DoRender()
        {
            StringWriter sw = new StringWriter();
            //HttpContext.Current.Server.Execute("/Views/FieldBuilder.html", sw, false);

            string html = @"
    <div class='zebra-fieldbuilder'>
        <input type='button' class='add-field-button' value='Add Field'> 
        <div class='fields-fieldbuilder'>
            <div class='field'>
                Field Name<input type= 'text' id='fieldname1' name='fieldname1' /> 
                FieldType <select id='fieldtype1' name='fieldtype1'>
                                <option value = 'E675EA2D-14DC-4031-97DE-2D91E240FC06'>SingleLineString</option>
                            </select>
            </div>
        </div>
    </div>
    <div class='field-sample'>Field Name<input type= 'text' /> FieldType <select><option> Dummy Field</option><option>SingleLineString</option></select></div>
<script>

$(document).on('click', '.add-field-button', function (e) {

		$('.fields-fieldbuilder').append($('.field-sample').clone().attr('class','field'));

    });

$(document).on('mouseup', function (e)
    {
        var fields = $('.zebra-fieldbuilder .field');

        for (var i = 0; i < fields.length; i++)
        {
            if ($(fields[i]).find('input').val() == '' && $(event.target.parentElement).attr('class') != 'field'){
				$(fields[i]).remove();
        }
    }
});

</script>
<style>
    .field {
        display: block;
    }

    .field-sample {
        display: none;
    }
</style>";
            //sw.WriteLine(html);
            return html;
        }
    }
}
