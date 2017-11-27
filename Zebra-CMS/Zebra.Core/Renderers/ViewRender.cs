using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.Core.Renderers
{
    class ViewRender
    {
        public virtual string DoRender()
        {
            return string.Empty;
        } 

        public virtual void PostRender()
        {

        }

        public virtual string GetProcessedValue()
        {
            return null;
        }

        public virtual void PostSave()
        {

        }

    }
}
