using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static Zebra.Application.ZebraContext;

namespace Zebra.ViewModel
{
    public class PageModel
    {
        public string LayoutPath { get; set; }
        public PageDesign Design { get; set; }
    }
}