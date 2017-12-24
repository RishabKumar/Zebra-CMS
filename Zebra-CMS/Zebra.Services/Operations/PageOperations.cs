using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Type;

namespace Zebra.Services.Operations
{
    public class PageOperations : IPageOperations
    {
        private INodeRepository _noderepo;
        public PageOperations(INodeRepository noderepository)
        {
            _noderepo = noderepository;
        }

        public void CreateContentMap()
        {
            var contentnode = OperationsFactory.NodeOperations.GetNode(NodeType.CONTENTNODE_ID);
            var list = FormPathsRecursive(contentnode);
        }

        private List<string> FormPathsRecursive(Node node, string path = "", List<string> map = null)
        {
            if (map == null)
            {
                map = new List<string>();
            }
            var list = ((NodeRepository)_noderepo).GetByCondition(x => x.ParentId == node.Id);

            path += node.NodeName + "/";
            map.Add(path);
            ContentMapRepository.Add(path, node.Id);
            foreach (var lnode in list)
            {
                map = (FormPathsRecursive(lnode, path, map));
            }
            return map;
        }

        public void Initialize()
        {
            CreateContentMap();
        }

        public void CreateContentMap(Node startnode, string path = "")
        {
            throw new NotImplementedException();
        }

        public Node GetPageNode(string relativepagepath)
        {
            return OperationsFactory.NodeOperations.GetNode(ContentMapRepository.FindNodeId(relativepagepath).ToString());
        }
    }
}
