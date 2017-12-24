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
    class SmallFileType : ViewRender
    {
        protected string filename;
        protected string encodedstring;

        public SmallFileType(FieldContext context)
        {
            _context = context;
            filename = string.Empty;
            encodedstring = string.Empty;
        }

        //called just after GetValue().
        public override string SaveValue()
        {
            //to prevent decoding to fail
            if (!string.IsNullOrWhiteSpace(encodedstring))
            {
                int mod4 = encodedstring.Length % 4;
                if (mod4 > 0)
                {
                    encodedstring += new string('=', 4 - mod4);
                }
                try
                {
                    byte[] bytes = Convert.FromBase64String(encodedstring);
                    if (bytes != null)
                    {
                        IFileRepository repo = new FileRepository();
                        repo.SaveMedia(filename, bytes);
                        if (!string.IsNullOrWhiteSpace(_context.OldValue))
                        {
                            repo.DeleteMedia(FileRepository.MediaLocalPath + _context.OldValue);
                        }
                    }
                }
                catch (FormatException)
                {

                }
                catch (ArgumentNullException)
                {

                }
            }
            return _context.Value;
        }

        //called just before saving data.
        public override string GetValue()
        {
            if (!string.IsNullOrWhiteSpace(_context.Value))
            {
                // this will execute when data is being fetched from database.
                _context.Value = "/Media/" + _context.Value;
            }
            else if(_context.RawData != null && !string.IsNullOrWhiteSpace(_context.RawData.ToString()))
            {
                string newencodedstring = _context.RawData.ToString();
                if (newencodedstring.Contains("[filename="))
                {
                    var first100 = newencodedstring.Substring(0, 100);
                    var tmp = first100.Split(new[] { "[filename=" }, StringSplitOptions.RemoveEmptyEntries)[0];
                    int index = first100.IndexOf("base64,") + 7;
                    var datatmp = newencodedstring.Substring(index);
                //    datatmp = datatmp.Split(new[] { "base64," }, StringSplitOptions.RemoveEmptyEntries)[1];
                    encodedstring = datatmp;
                    tmp = tmp.Split(']')[0];

                    if (tmp.Split('.').Length > 1)
                    {
                        tmp = "." + tmp.Split('.')[1];
                    }
                    else
                    {
                        tmp = string.Empty;
                    }
                    _context.Value = Guid.NewGuid().ToString() + tmp;
                }
                else
                {
                    // this will execute when data is being saved and no change has been done to the field
                    var guid = new Guid();
                    if (Guid.TryParse(newencodedstring.Split('.')[0], out guid))
                    {
                        _context.Value = newencodedstring;
                    }
                }
            }
            filename = _context.Value;
            return _context.Value;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div>").Append(_context.Name).Append("<p><input type='file' onchange='encodefile(this)'/><input type='hidden' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='"+_context.Value+"' /></p>");
            sb.AppendLine("<img width='100px' src='"+ GetValue() + "'/>");
            sb.AppendLine("<script type='text/javascript'>");

            sb.AppendLine("function encodefile(e){");

            sb.AppendLine("var file = null; if (e.files.length > 0) {");
            sb.AppendLine("var file = e.files[0]; } ");
            sb.AppendLine(@"
               var filename = file.name;
               var reader = new FileReader();
			    reader.readAsDataURL(file);
                reader.onloadstart = function () {
				    showLoader();
                };   
			    reader.onload = function () {
				    $('#" + _context.FieldId + @"').val('[filename='+filename+']'+reader.result);
			    };
			    reader.onerror = function (error) {
				    console.log('Error: ', error);
			    };
                reader.onloadend = function () {
				     hideLoader();
			    };
            }");

            sb.AppendLine("</script>");
            
            sb.AppendLine("</div>");
            return sb.ToString();
        }
    }
}
