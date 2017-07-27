using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class NodeOperations : BaseOperations<NodeRepository, Node>, INodeOperations, IStructureOperations
    {
        public NodeOperations(NodeRepository t) : base(t)
        {
            _currentrepository = (INodeRepository)t;
        }

        public Node CreateNode(string nodename, string parentid, string templateid)
        {
            Node node = new Node() { Id = Guid.NewGuid(), NodeName = nodename, TemplateId = new Guid(templateid), ParentId = new Guid(parentid) };
            return ((INodeRepository)_currentrepository).CreateNode(node);
        }

        public Node GetNode(string nodeid)
        {
            return ((INodeRepository)_currentrepository).GetNode(new Node { Id = new Guid(nodeid) });
        }

        public bool DeleteNode(string nodeid)
        {
            return ((INodeRepository)_currentrepository).DeleteNode(new Node() { Id = new Guid(nodeid) });
        }

        public List<Node> GetAllnodes()
        {
            throw new NotImplementedException();
        }

        public List<Node> GetChildNodes(Node parentnode)
        {   
            return _currentrepository.GetChildNodes(parentnode);
        }

        public Node GetRootNode()
        {
           return _base.GetByName(new Node() { NodeName = "root" });
        }


    }
}
