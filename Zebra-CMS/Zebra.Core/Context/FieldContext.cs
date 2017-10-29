using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.Core.Context
{
    public class FieldContext
    {
        public Guid FieldId { get; set; }

        public Guid TypeId { get; set; }

        public string Name { get; set; }  

        public string Value { get; set; }

        public string OldValue { get; set; }

        public object RawData { get; set; } 

        public FieldContext(Guid fieldId, Guid typeid, string Name)
        {
            this.FieldId = fieldId;
            this.TypeId = typeid;
            this.Name = Name;
            this.Value = string.Empty;
        }
    }
}
