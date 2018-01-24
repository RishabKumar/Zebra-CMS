using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;

namespace Zebra.Core.Types
{
    class ImageLink : ViewRender
    {
        public ImageLink(FieldContext context)
        {
            _context = context;
        }

        public override string SaveValue()
        {
            return _context.Value;
        }

        public override string GetValue()
        {
            // -> add get value from database via a wrapper.
            if (_context.RawData != null && !string.IsNullOrWhiteSpace(_context.RawData.ToString()))
            {
                _context.Value = HttpUtility.HtmlEncode(_context.RawData.ToString());
            }
            return _context.Value;
        }

        public override string GetProcessedValue()
        {
            var rawdata = GetValue();
            if (rawdata != null && !string.IsNullOrWhiteSpace(rawdata))
            {
                Uri link;
                if(Uri.TryCreate(rawdata, UriKind.Absolute, out link))
                {
                    return link.OriginalString;
                }
                var noderepo = new NodeRepository();//4ea49c20-a9f6-4312-bea1-7e0c5243e1b9
                Guid id ;
                string data = string.Empty;
                if (Guid.TryParse(rawdata, out id))
                {
                    data = noderepo.GetNodeFieldMapData(new Node() { Id = id }, "Image");
                }
                return new FileRepository().GetMediaFilePath(data);
            }
            return string.Empty;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p></div>");
            sb.Append(@"<img width='150px' src='" + GetProcessedValue() +@"' />");
            return sb.ToString();
        }

    }
}
