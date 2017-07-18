using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class NodeRepository : BaseRepository<Node>
    {
        public override Node GetByName(Node t)
        {
            return _context.Nodes.Where(x => x.NodeName.ToLower().Equals(t.NodeName.ToLower())).FirstOrDefault();
        }



    }
}
