using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Core.Context;

namespace Zebra.Core.Renderers
{
    class ViewRender
    {
        internal FieldContext _context;
        public virtual string DoRender()
        {
            return string.Empty;
        }

        public virtual string SaveValue()
        {
            return null;
        }

        public virtual string GetValue()
        {
            return null;
        }

        public virtual void PostRender()
        {

        }

        public virtual string GetProcessedValue()
        {
            return GetValue();
        }

        public virtual void PostSave()
        {

        }

    }
}
