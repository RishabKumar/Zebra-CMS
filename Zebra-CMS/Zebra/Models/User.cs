using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Zebra.Models
{
    public class User
    {
        public string Name { get; set; }
        public string Password { get; set; }
        public string Roles { set; get; }
    }
}