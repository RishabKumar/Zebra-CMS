using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Zebra.DataRepository.Models;

namespace Zebra.ZebraHelpers
{
    public static class ZebraHelper
    {
        public static IHtmlString LoadFields(this HtmlHelper helper, List<string> fieldshtml)
        {
            StringBuilder sb = new StringBuilder();
            foreach(var fieldhtml in fieldshtml)
            {
                sb.Append(fieldhtml);
            }
            return helper.Raw(sb.ToString());
        }

    }
}