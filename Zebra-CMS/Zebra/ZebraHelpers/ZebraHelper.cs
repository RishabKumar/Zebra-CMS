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

        public static IHtmlString LoadNodePath(this HtmlHelper helper, Stack<Node> nodes)
        {
            StringBuilder sb = new StringBuilder();
         //   sb.Append("<p>");
            while(nodes.Count > 0)
            {
                var node = nodes.Pop();
                sb.Append("--><a href=javascript:LoadNodeBrowser('").Append(node.Id).Append("') >").Append(node.NodeName).Append("</a>");
            }
        //    sb.Append("</p>");
            return helper.Raw(sb.ToString());
        }

    }
}