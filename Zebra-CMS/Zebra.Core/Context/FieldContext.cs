using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.Core.Context
{
    public class FieldContext
    {
        public Guid Id { get; set; }

        public string Name { get; set; }  

        public string Value { get; set; }

        public FieldContext()
        {
            Id = new Guid();
            Name = "name_"+Id;
        }
    }
}
