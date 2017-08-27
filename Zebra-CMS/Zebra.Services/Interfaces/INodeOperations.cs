using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    public interface INodeOperations
    {
        List<Node> GetAllnodes();

        Node GetRootNode();

        List<Node> GetChildNodes(Node node);

        Node GetNode(string nodeid);

        bool SaveNode(Node node, dynamic data, List<Field> fields = null);
    }
}
