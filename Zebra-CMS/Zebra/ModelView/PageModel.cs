﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Zebra.ModelView
{
    public class PageModel
    {
        public string LayoutPath { get; set; }
        public List<Guid> Actions { get; set; }
    }
}