using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class NodeOperations : BaseOperations<NodeRepository, Node>, INodeOperations
    {
        public NodeOperations(NodeRepository t) : base(t)
        {
        }

        public List<Node> GetAllnodes()
        {
            throw new NotImplementedException();
        }

        public Node GetRootNode()
        {
           return _base.GetByName(new Node() { NodeName = "root" });
        }
    }
}
