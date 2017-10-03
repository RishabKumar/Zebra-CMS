using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.Core.Context;
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

        public Node CreateNode(string nodename, string parentid, string templateid, List<Field> fields, string zebratype)
        {
            Guid newid = Guid.NewGuid();
            Node node = new Node() { Id = newid, NodeName = nodename, TemplateId = new Guid(templateid), ParentId = new Guid(parentid) };
            DetermineNodeTypeAndCreate(node.NodeName, newid, node);
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
            switch(DetermineNodeType(new Node { Id = new Guid(nodeid) }))
            {
                case NodeType.CONTENT_TYPE:
                    break;
                case NodeType.TEMPLATE_TYPE:
                    {
                        var template = new Template() { Id = Guid.Parse(nodeid) };
                        template = _templaterepository.GetTemplate(template);
                        foreach (var tmp in template.TemplateFieldMaps)
                        {
                            _fieldrepository.RemoveFieldTemplateRelation(tmp);
                            _fieldrepository.DeleteField(new Field() { Id = tmp.FieldId });
                        }
                        _templaterepository.DeleteTemplate(template);
                    }
                    break;
                case NodeType.SYSTEM_TYPE:
                    break;
                case NodeType.FIELD_TYPE:
                    break;
            }
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

        public Field CreateField(Field field, Template template)
        {
            field = _fieldrepository.CreateField(field, template);
            _fieldrepository.AddFieldToTemplate(template, field);
            //template = _templaterepository.GetTemplate(template);  // this doesnot always retrieve all Nodes in case if browser is not refreshed after noder creation, hence its not safe.
            var fields = new List<Field>() { field };
            var nodes = _base.GetByCondition(x => x.TemplateId == template.Id);
            // add the template to the ndoe list.
            nodes.Add(new Node() { Id = template.Id }); // every template's id is same as to it corresponding Node's Id.
            foreach (var node in nodes)
            {
                ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, fields);
            }
            return field;
        }

        public FieldType CreateFieldType(FieldType ft)
        {
            return _fieldrepository.CreateFieldType(ft);
        }

        [Obsolete("",false)]
        public void DetermineNodeTypeAndCreate(string name, Guid newid, Node node)
        {
            string type = NodeType.UNKNOWN_TYPE;
       //     node = GetBaseParent(node);
            
            switch(node.Id.ToString().ToUpper())
            {
                case NodeType.CONTENTNODE_ID:
                    type = NodeType.CONTENT_TYPE;
                    break;
                case NodeType.TEMPLATENODE_ID:
                    type = NodeType.TEMPLATE_TYPE;
                    CreateTemplate(new Template() {Id  = newid, TemplateName = name });
                    break;
                case NodeType.FIELDNODE_ID:
                    type = NodeType.FIELD_TYPE;
           //         CreateField(new Field() { FieldName = node.NodeName, T});
                    break;
                case NodeType.FIELDTYPENODE_ID:
                    type = NodeType.FIELDTYPE_TYPE;
                    CreateFieldType(new FieldType() { Id = Guid.NewGuid(), TypeName = name });
                    break;
                default:
                    DetermineNodeTypeAndCreate(name, newid, GetNode(node.ParentId.ToString()));
                    break;
            }
        }

        private string DetermineNodeType(Node node)
        {
            string type = NodeType.UNKNOWN_TYPE;
            switch (node.Id.ToString().ToUpper())
            {
                case NodeType.CONTENTNODE_ID:
                    type = NodeType.CONTENT_TYPE;
                    break;
                case NodeType.TEMPLATENODE_ID:
                    type = NodeType.TEMPLATE_TYPE;
                    
                    break;
                case NodeType.FIELDNODE_ID:
                    type = NodeType.FIELD_TYPE;
                     
                    break;
                case NodeType.FIELDTYPENODE_ID:
                    type = NodeType.FIELDTYPE_TYPE;
                     
                    break;
                default:
                    node = GetNode(node.Id.ToString());
                    type = DetermineNodeType(GetNode(node.ParentId.ToString()));
                    break;
            }
            return type;
        }

        private bool DetermineNodeTypeAndCreate(Node node, Guid newid, string zebratype)
        {
            switch (zebratype)
            {
                case ZebraType.NODE:
                    break;
                case ZebraType.TEMPLATE:
                    CreateTemplate(new Template() { Id = newid, TemplateName = node.NodeName });
                    break;
                case ZebraType.FIELD:
                    //         CreateField(new Field() { FieldName = node.NodeName, T});
                    break;
                case ZebraType.FIELDTYPE:
                    CreateFieldType(new FieldType() { Id = Guid.NewGuid(), TypeName = node.NodeName });
                    break;
                default:
                    return false;
            }
            return true;
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

        public bool SaveNode(Node node, dynamic rawdata, List<Field> fields = null)
        {
            if (fields != null)
            {
                throw new Exception("SaveNodeData is not consumed in the right way!");
                foreach (var field in fields)
                {
                    try
                    {
                        var value = rawdata[field.Id.ToString()];
                        //raw data has to be processed before saving to database
                        var fieldtype = _fieldrepository.GetFieldType(field);
                        
                        var type = System.Type.GetType(fieldtype.ClassPath);
                        FieldContext _context = new FieldContext(Guid.Parse(fieldtype.Id.ToString()), field.FieldName);
                        _context.RawData = value;
                        var fieldobj = Activator.CreateInstance(type, _context);
                        var mi = type.GetMethod("GetValue");
                        var data = mi.Invoke(fieldobj, null).ToString();

                        _currentrepository.SaveNodeData(node, field, data);
                    }
                    catch(Exception e) { }
                }
            }
            else
            {
                var list = ((INodeRepository)_currentrepository).GetNodeFieldMapData(node);
                foreach(var nodefield in list)
                {
                    try
                    {
                        var value = rawdata[nodefield.Id.ToString()];
                        //raw data has to be processed before saving to database
                        var fieldtype = _fieldrepository.GetFieldType(nodefield.Field);
                        var type = System.Type.GetType(fieldtype.ClassPath);
                        FieldContext _context = new FieldContext(Guid.Parse(fieldtype.Id.ToString()), nodefield.Field.FieldName);
                        _context.RawData = value;
                        var fieldobj = Activator.CreateInstance(type, _context);
                        var mi = type.GetMethod("GetValue");
                        var data = mi.Invoke(fieldobj, null).ToString();

                        nodefield.NodeData = data;
                        _currentrepository.SaveNodeData(nodefield);
                    }
                    catch(Exception e) { }
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
