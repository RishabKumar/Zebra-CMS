using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;
using Zebra.DAL;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;

namespace Zebra.Core.Types
{
    class VideoType : FileType
    {
        public VideoType(FieldContext context) : base(context)
        {
            _context = context;
            filename = string.Empty;
            encodedstring = string.Empty;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div>").Append(_context.Name).Append("<p><input type='file' onchange='UploadFile(this)'/><input type='hidden' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p>");
            sb.AppendLine(@"<video width='400' controls>
                              <source src = '" + GetValue() + @"'>
                              Your browser does not support HTML5 video.
                            </video >");
            sb.AppendLine("<script type='text/javascript'>");

            sb.AppendLine("function UploadFile(e){");

            sb.AppendLine(" var data = new FormData(); var files = e.files;");
            sb.AppendLine("if (files.length > 0) {");
            sb.AppendLine("data.append('UploadedImage', files[0]);}");
            sb.AppendLine(@"

            var ajaxRequest = $.ajax(
                {
                    type: 'POST',
                    url: '/zebraapi/MediaService/UploadFile',
                    contentType: false,
                    processData: false,
                    data: data,
                    success: function (tmpid) {
                        if (tmpid !== '' && tmpid !== 'null') {
                            $('#" + _context.FieldId + @"').val(tmpid);
                        }
                    }
                });
                ajaxRequest.done(function(data, textStatus, jqXHR) {
                    console.log(data);
                });

            ");

            sb.AppendLine("}</script>");
            sb.AppendLine("</div>");
            return sb.ToString();
        }

    }
}
