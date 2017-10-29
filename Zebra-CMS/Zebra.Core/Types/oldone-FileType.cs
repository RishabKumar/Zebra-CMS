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
    class FileType : ViewRender
    {
        FieldContext _context;

        public FileType(FieldContext context)
        {
            _context = context;
        }

        //called just after GetValue().
        public void SaveValue()
        {
            string filename = _context.RawData.ToString();
            if (!string.IsNullOrWhiteSpace(filename))
            {
                IFileRepository repo = new FileRepository();
                repo.SaveMedia(HttpContext.Current.Server.MapPath("~/Temp_Data/temp_upload/") + filename, filename);
            }
        }

        //called just before saving data.
        public string GetValue()
        {
            // -> add get value from database via a wrapper.
            string filename = _context.RawData.ToString();
            if (!string.IsNullOrWhiteSpace(filename))
                _context.Value = "/Media/" + filename;
            return _context.Value;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div>").Append(_context.Name).Append("<p><input type='file' onchange='UploadFile(this)'/><input type='hidden' name='").Append(_context.Id).Append("' id='").Append(_context.Id).Append("'").Append(" value='" + _context.Value + "' /></p>");
            sb.AppendLine("<img width='100px' src='"+ _context.Value + "'/>");
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
                            $('#"+_context.Id+@"').val(tmpid);
                        }
                    }
                });
                ajaxRequest.done(function(data, textStatus, jqXHR) {
                    alert(data);
                    console.log(data);
                });

            ");

            sb.AppendLine("}</script>");
            
            sb.AppendLine("</div>");
            return sb.ToString();
        }
    }
}
