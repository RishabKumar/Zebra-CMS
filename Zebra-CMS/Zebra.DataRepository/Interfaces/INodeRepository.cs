using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface INodeRepository
    {
        List<Node> GetChildNodes(Node parentnode);
        Node CreateNode(Node node);

        bool DeleteNode(Node node);

        Node GetNode(Node node);

        Template GetTemplate(IEntity t);
    }
}
