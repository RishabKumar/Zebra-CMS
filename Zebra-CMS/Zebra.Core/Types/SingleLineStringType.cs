using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Zebra.Core.Context;

namespace Zebra.Core.Types
{
    class SingleLineStringType
    {
        FieldContext _context;

        public SingleLineStringType(FieldContext context)
        {
            _context = context;
        }

        public void SaveValue(string value)
        {
            _context.Value = value;
        }

        public string GetValue()
        {
            // -> add get value from database via a wrapper.
            return _context.Value;
        }

        public string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div>").Append(_context.Name).Append("<p><input type='text' name='").Append(_context.Id).Append("' id='").Append(_context.Id).Append("'").Append(" value='"+_context.Value+"' /></p></div>");
            return sb.ToString();
        }
    }
}