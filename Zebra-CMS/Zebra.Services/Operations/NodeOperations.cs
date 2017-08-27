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
    public class NodeOperations : BaseOperations<NodeRepository, Node>, INodeOperations, IStructureOperations
    {
        ITemplateRepository _templaterepository;
        IFieldRepository _fieldrepository;
        public NodeOperations(NodeRepository n, TemplateRepository t, FieldRepository f) : base(n)
        {
            _currentrepository = (INodeRepository)n;
            _templaterepository = (ITemplateRepository)t;
            _fieldrepository = (IFieldRepository)f;
        }

        public Node CreateNode(string nodename, string parentid, string templateid, List<Field> fields)
        {
            Guid newid = Guid.NewGuid();
            Node node = new Node() { Id = newid, NodeName = nodename, TemplateId = new Guid(templateid), ParentId = new Guid(parentid) };
            DetermineNodeTypeAndCreate(node, newid);
            node = ((INodeRepository)_currentrepository).CreateNode(node);
            ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, fields);
            return node;
        }

        public string GetNodeBrowser()
        {

            return null;
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

        public Template CreateTemplate(Template t)
        {
            return _templaterepository.CreateTemplate(t);
        }

        public Field CreateField(Field field)
        {
            return _fieldrepository.CreateField(field);
        }

        public FieldType CreateFieldType(FieldType ft)
        {
            return _fieldrepository.CreateFieldType(ft);
        }

        public string DetermineNodeTypeAndCreate(Node node, Guid newid)
        {
            string type = NodeType.UNKNOWN_TYPE;
       //     node = GetBaseParent(node);
            
            switch(node.TemplateId.ToString().ToUpper())
            {
                case NodeType.CONTENT_ID:
                    type = NodeType.CONTENT_TYPE;
                    break;
                case NodeType.TEMPLATE_ID:
                    type = NodeType.TEMPLATE_TYPE;
                    CreateTemplate(new Template() {Id  = newid, TemplateName = node.NodeName});
                    break;
                case NodeType.FIELD_ID:
                    type = NodeType.FIELD_TYPE;
           //         CreateField(new Field() { FieldName = node.NodeName, T});
                    break;
                case NodeType.FIELDTYPE_ID:
                    type = NodeType.FIELDTYPE_TYPE;
                    CreateFieldType(new FieldType() { Id = Guid.NewGuid(), TypeName = node.NodeName });
                    break;
            }
            return type;
        }

        private Node GetBaseParent(Node node)
        {
            node = _base.GetByCondition(x => x.Id == node.ParentId).FirstOrDefault();
            if(node.ParentId.ToString().Equals("00000000-0000-0000-0000-000000000000"))
            {
                return node;
            }
            return GetBaseParent(node);
        }

        public Template GetTemplate(string templateid)
        {
            return _templaterepository.GetTemplate(new Template() { Id = new Guid(templateid) });
        }

        public bool SaveNode(Node node, dynamic data, List<Field> fields = null)
        {
            if (fields != null)
            {
                foreach (var field in fields)
                {
                    try
                    {
                        var value = data[field.Id.ToString()];
                        _currentrepository.SaveNodeData(node, field, value);
                    }
                    catch { }
                }
            }
            else
            {
                var list = ((INodeRepository)_currentrepository).GetNodeFieldMapData(node);
                foreach(var nodefield in list)
                {
                    try
                    {
                        var value = data[nodefield.Id.ToString()];
                        nodefield.NodeData = value.ToString();
                        _currentrepository.SaveNodeData(nodefield);
                    }
                    catch { }
                }
            }

            return true; 
        }

        public List<NodeFieldMap> GetNodeFieldMapData(string nodeid)
        {
            return ((INodeRepository)_currentrepository).GetNodeFieldMapData(new Node() { Id = Guid.Parse(nodeid)});
        }
    }
}
