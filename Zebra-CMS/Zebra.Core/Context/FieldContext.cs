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

        public object RawData { get; set; } 

        public FieldContext(Guid Id, string Name)
        {
            this.Id = Id;
            this.Name = Name;
            this.Value = string.Empty;
        }
    }
}
