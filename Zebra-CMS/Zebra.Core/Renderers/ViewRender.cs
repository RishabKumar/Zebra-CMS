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
            return "";
        } 

        public virtual void PostRender()
        {

        }

        public virtual void PostSave()
        {

        }

    }
}
