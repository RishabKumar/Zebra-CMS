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

        Template GetTemplate(Node t);

        bool SaveNodeData(NodeFieldMap nodefieldmap);

        bool RegisterFieldsForNode(IEntity entity, List<Field> fields, IEntity language);

        List<NodeFieldMap> GetNodeFieldMapData(Node node);

        List<NodeFieldMap> GetNodeFieldMapData(Node node, Field field);

        List<NodeFieldMap> GetNodeFieldMapData(Node node, Field field, Language language);

        List<NodeFieldMap> GetNodeFieldMapData(Node node, Language language);

        NodeFieldMap GetNodeFieldMap(IEntity entity);

        void MoveNode(IEntity node, IEntity newparent);

        List<Node> GetNodesByType(Template t);

        bool CreateAndSaveNodeData(Node node, Field field, Language language, dynamic data);
    }
}
