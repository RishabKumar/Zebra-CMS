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
    class ImageType : ViewRender
    {
        protected string filename;
        protected string encodedstring;
        IFileRepository repo = new FileRepository();

        public ImageType(FieldContext context)
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
                        _context.Value = repo.SaveMedia(filename, bytes);
                        if (!string.IsNullOrWhiteSpace(_context.OldValue))
                        {
                            repo.DeleteMedia(_context.OldValue);
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
                try
                {
                    _context.Value = repo.GetMediaFilePath(_context.Value);
                    //_context.Value = "../handlers/mediahandler.ashx?file=" + _context.Value;
                }
                catch(Exception e)
                {
                    _context.Value = "data:image/jpg;base64, " + Convert.ToBase64String(repo.GetMediaBytes(_context.Value));
                }
            }
            else if(_context.RawData != null && !string.IsNullOrWhiteSpace(_context.RawData.ToString()))
            {
                string newencodedstring = _context.RawData.ToString();
                if (newencodedstring.Contains("[filename="))
                {
                    var tmp = newencodedstring.Split(new[] { "[filename=" }, StringSplitOptions.RemoveEmptyEntries)[0];
                    var datatmp = tmp.Split(']')[1];
                    datatmp = datatmp.Split(new[] { "base64," }, StringSplitOptions.RemoveEmptyEntries)[1];
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
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='file' onchange='encodefile(this)'/><input type='hidden' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='"+_context.Value+"' /></p>");
            sb.AppendLine("<img width='250px' src='"+ GetValue() + "'/>");
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
