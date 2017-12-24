using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.DataRepository.Models
{
    public class ContentMap
    {
        public DateTime creationtime;
        public Dictionary<string, Guid> map;

        public ContentMap()
        {
            map = new Dictionary<string, Guid>();
            creationtime = DateTime.Now;
        }
    }
}
