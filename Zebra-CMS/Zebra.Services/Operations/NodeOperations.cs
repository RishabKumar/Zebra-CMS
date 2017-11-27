using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;
using Zebra.Services.Models;
using Zebra.Services.Type;

namespace Zebra.Services.Operations
{
    public class NodeOperations : BaseOperations<NodeRepository, Node>, INodeOperations, IStructureOperations, IPageOperations
    {
        ITemplateRepository _templaterepository;
        IFieldRepository _fieldrepository;
        IFileRepository _filerepository;
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

        public Stack<Node> GetAllParentNodes(string nodeid)
        {
            Node node = ((INodeRepository)_currentrepository).GetNode(new Node() { Id = Guid.Parse(nodeid) });
            Stack<Node> stack = new Stack<Node>();
            while (node.ParentId != null)
            {
                stack.Push(node);
                node = ((INodeRepository)_currentrepository).GetNode(new Node() { Id = node.ParentId.Value });
            }
            stack.Push(node);
            return stack;
        }

        public List<Node> SearchNode(string nameorid)
        {
            Guid id;
            var list = new List<Node>();
            if (!string.IsNullOrWhiteSpace(nameorid))
            {
                if (Guid.TryParse(nameorid, out id))
                {
                    list.Add(((INodeRepository)_currentrepository).GetNode(new Node() { Id = id }));
                }
                else
                {
                    nameorid = nameorid.ToLower();
                    list.AddRange(_base.GetByCondition(x => x.NodeName.ToLower().Contains(nameorid) || nameorid.Contains(x.NodeName.ToLower())));
                }
            }
            return list;
        }

        public string GetNodeBrowser()
        {
            return null;
        }

        public Node GetNode(string nodeid)
        {
            if (string.IsNullOrWhiteSpace(nodeid))
            {
                return null;
            }
            return ((INodeRepository)_currentrepository).GetNode(new Node { Id = new Guid(nodeid) });
        }

        public bool DeleteNode(string nodeid)
        {
            bool flag = false;
            switch(DetermineNodeType(new Node { Id = new Guid(nodeid) }))
            {
                case NodeType.CONTENT_TYPE:
                        flag = _currentrepository.DeleteNode(new Node() { Id = new Guid(nodeid) });
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
                        flag = _currentrepository.DeleteNode(new Node() { Id = new Guid(nodeid) });
                        _templaterepository.DeleteTemplate(template);
                    }
                    break;
                case NodeType.MEDIA_TYPE:
                    break;
                case NodeType.SYSTEM_TYPE:
                    break;
                case NodeType.FIELD_TYPE:
                    break;
            }
            return flag;
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
            //    var nodes = _base.GetByCondition(x => x.TemplateId == template.Id);
            var nodes = GetAllDerivedNodesByType(template);

            nodes.Add(new Node() { Id = template.Id }); // every template's id is same as to it corresponding Node's Id.
            foreach (var node in nodes)
            {
                ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, fields);
            }
            return field;
        }

        public List<Node> GetNodesByType(Template template)
        {
            return ((NodeRepository)_currentrepository).GetNodesByType(template);
        }

        /// <summary>
        /// Gets all the Nodes of Template t Type
        ///
        /// </summary>
        /// <param name="template"></param>
        /// <returns>List of nodes of type Template t</returns>
        public List<Node> GetAllDerivedNodesByType(Template template)
        {
            var tnodes = GetNodesByType(template);
            for(int i = 0; i < tnodes.Count; i++)
            {
                Template t = _templaterepository.GetTemplate(tnodes[i]);
                if(t != null)
                {
                    tnodes.AddRange(GetNodesByType(t));
                }
            }
            return tnodes;
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
                case NodeType.MEDIA_ID:
                    type = NodeType.MEDIA_TYPE;
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
                case NodeType.MEDIA_ID:
                    type = NodeType.MEDIA_TYPE;
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
            if (string.IsNullOrWhiteSpace(templateid))
            {
                return null;
            }
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
                        FieldContext _context = new FieldContext(field.Id ,fieldtype.Id, field.FieldName);
                        _context.RawData = value;
                        _context.OldValue = null;
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
                        FieldContext _context = new FieldContext(nodefield.Field.Id ,fieldtype.Id, nodefield.Field.FieldName);
                        _context.RawData = value;
                        _context.OldValue = nodefield.NodeData;
                        var fieldobj = Activator.CreateInstance(type, _context);
                        //invoke GetValue to get the processed value.
                        var mi = type.GetMethod("GetValue");
                        var data = mi.Invoke(fieldobj, null).ToString();
                        //call SaveValue to save addition information. 
                        mi = type.GetMethod("SaveValue");
                        data = mi.Invoke(fieldobj, null).ToString();

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
            if (string.IsNullOrWhiteSpace(nodeid))
            {
                return null;
            }
            return ((INodeRepository)_currentrepository).GetNodeFieldMapData(new Node() { Id = Guid.Parse(nodeid)});
        }

        public void MoveNode(string nodeid, string newparentid)
        {
            _currentrepository.MoveNode(new Node() { Id = Guid.Parse(nodeid) }, new Node() { Id = Guid.Parse(newparentid) });
        }

        public void CreateContentMap()
        {
            var g = new Node() { Id = Guid.Parse("2401C12C-1CB4-48E2-B685-7891D9190D70") };
            g = ((INodeRepository)_currentrepository).GetNode(g);
            var content = _base.GetByCondition(x => x.Id == g.Id).FirstOrDefault();
            var list = FormPathsRecursive(content);
        }

        private List<string> FormPathsRecursive(Node node, string path = "", List<string> map = null)
        {
            if(map == null)
            {
                map = new List<string>();
            }
            var list = ((NodeRepository)_currentrepository).GetByCondition(x => x.ParentId == node.Id);

            path += node.NodeName + "/";
            map.Add(path);
            ContentMap.Add(path, node.Id);
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
    }
}
