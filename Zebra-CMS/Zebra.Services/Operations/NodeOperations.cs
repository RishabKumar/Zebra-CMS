using System;
using System.Collections.Generic;
using System.Linq;
using Zebra.Core.Context;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Globalization;
using Zebra.Services.Interfaces;
using Zebra.Services.Type;

namespace Zebra.Services.Operations
{
    public class NodeOperations : BaseOperations<NodeRepository, Node>, INodeOperations, IStructureOperations
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
            node = ((INodeRepository)_currentrepository).CreateNode(node);
            ((INodeRepository)_currentrepository).AddLanguageToNode(node, LanguageManager.GetDefaultLanguage());
            if (!DetermineNodeTypeAndCreate(node.NodeName, newid, node))
            {
                DeleteNode(node.Id.ToString());
                return null;
            }
            foreach (var field in fields)
            {
                ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, field, LanguageManager.GetDefaultLanguage());
            }
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
            var Id = new Guid(nodeid);
            if (Guid.Empty.Equals(Id))
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
                case NodeType.RENDER_TYPE:
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
                    var node = GetNode(nodeid);
                    var filerepo = new FileRepository();
                    //ugly way of removing media files
                    foreach (var nodefieldmap in node.NodeFieldMaps)
                    {
                        filerepo.DeleteMedia(nodefieldmap.NodeData);
                    }
                    flag = _currentrepository.DeleteNode(node);
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

        public Field CreateField(Field field, Template template, Language language)
        {
            field = _fieldrepository.CreateField(field, template);
            _fieldrepository.AddFieldToTemplate(template, field);
            //template = _templaterepository.GetTemplate(template);  // this doesnot always retrieve all Nodes in case if browser is not refreshed after noder creation, hence its not safe.
            //    var nodes = _base.GetByCondition(x => x.TemplateId == template.Id);
            var nodes = GetAllDerivedNodesByType(template);

            nodes.Add(new Node() { Id = template.Id }); // every template's id is same as to it corresponding Node's Id.
            var lang = language ?? LanguageManager.GetDefaultLanguage();
            foreach (var node in nodes)
            {
                RegisterFieldsForNode(node, field, lang);
            }
            return field;
        }

        public Field CreateField(Field field, Template template)
        {
            field = _fieldrepository.CreateField(field, template);
            _fieldrepository.AddFieldToTemplate(template, field);
            //template = _templaterepository.GetTemplate(template);  // this doesnot always retrieve all Nodes in case if browser is not refreshed after noder creation, hence its not safe.
            //    var nodes = _base.GetByCondition(x => x.TemplateId == template.Id);
            var nodes = GetAllDerivedNodesByType(template);

            nodes.Add(new Node() { Id = template.Id }); // every template's id is same as to it corresponding Node's Id.
            
            foreach (var node in nodes)
            {
                RegisterFieldsForNode(node, field);
            }
            return field;
        }

        public List<Language> GetNodeLanguages(string nodeid)
        {
            var node = GetNode(nodeid);
            return ((INodeRepository)_currentrepository).GetNodeLanguages(node);
        }

        public bool LocalizeNode(string nodeid, string languageid)
        {
            var node = GetNode(nodeid);
            var language = LanguageManager.GetLanguageById(languageid);
            return ((INodeRepository)_currentrepository).AddLanguageToNode(node, language);
        }

        public bool RegisterFieldsForNode(IEntity node, Field field, Language language)
        {
            field = _fieldrepository.GetField(field);
            if (field.IsStatic)
            {
                return false;
            }
            else
            {
                return ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, field, language);
            } 
            
        }

        public bool RegisterFieldsForNode(IEntity node, Field field)
        {
            field = _fieldrepository.GetField(field);
            if (field.IsStatic)
            {
                return false;
            }
            else
            {
                return ((INodeRepository)_currentrepository).RegisterFieldsForNode(node, field);
            }
        }


        public string GetValueForField(string nodeid, string fieldid)
        {
            var node = GetNode(nodeid);
            var field = new Field() { Id = Guid.Parse(fieldid) };
            var nodefieldmap = ((NodeRepository)_currentrepository).GetNodeFieldMapData(node, field).FirstOrDefault();
            return GetValueForField(nodefieldmap);
        }

        public string GetValueForField(NodeFieldMap nodefieldmap)
        {
            var fieldtype = _fieldrepository.GetFieldType(nodefieldmap.Field);
            var type = System.Type.GetType(fieldtype.ClassPath);
            FieldContext _context = new FieldContext(nodefieldmap.Field.Id, fieldtype.Id, nodefieldmap.Field.FieldName);
            _context.Value = nodefieldmap.NodeData;
            var fieldobj = Activator.CreateInstance(type, _context);
            //invoke GetValue to get the processed value.
            var mi = type.GetMethod("GetProcessedValue");
            var data = mi.Invoke(fieldobj, null).ToString();
            return data;
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
                if(t != null && t.Id != template.Id)
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
        public bool DetermineNodeTypeAndCreate(string name, Guid newid, Node node)
        {
            string type = NodeType.UNKNOWN_TYPE;
       //     node = GetBaseParent(node);
            
            switch(node.Id.ToString().ToUpper())
            {
                case NodeType.CONTENTNODE_ID:
                    type = NodeType.CONTENT_TYPE;
                    return true; 
                    
                case NodeType.RENDERNODE_ID:
                    type = NodeType.RENDER_TYPE;
                    return true;
                    
                case NodeType.TEMPLATENODE_ID:
                    type = NodeType.TEMPLATE_TYPE;
                    CreateTemplate(new Template() {Id  = newid, TemplateName = name });
                    return true;
                    
                case NodeType.FIELDNODE_ID:
                    type = NodeType.FIELD_TYPE;
                    //         CreateField(new Field() { FieldName = node.NodeName, T});
                    return true;
                    
                case NodeType.FIELDTYPENODE_ID:
                    type = NodeType.FIELDTYPE_TYPE;
                    CreateFieldType(new FieldType() { Id = newid, TypeName = name });
                    return true;

                case NodeType.LANGUAGE_ID:
                    type = NodeType.LANGUAGE_TYPE;
                    LanguageManager.CreateEmptyLanguage(newid);
                    return true;

                case NodeType.MEDIA_ID:
                    type = NodeType.MEDIA_TYPE;
                    return true;
                default:
                    node = GetNode(node.Id.ToString());
                    return DetermineNodeTypeAndCreate(name, newid, GetNode(node.ParentId.ToString()));
                    
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
                case NodeType.RENDERNODE_ID:
                    type = NodeType.RENDER_TYPE;
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
                case NodeType.LANGUAGE_ID:
                    type = NodeType.LANGUAGE_TYPE;
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
            if(node.ParentId.ToString().Equals(NodeType.ROOT_ID))
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
            var languageid = rawdata["nodelanguageid"];
            Language language = null;
            if (string.IsNullOrWhiteSpace(languageid) || (language = LanguageManager.GetLanguageById(languageid)) == null)
            {
                return false;
            }
            
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
                        //node.LanguageId = LanguageManager.GetDefaultLanguage().Id;
                        _currentrepository.SaveNodeData(node, field, data);
                    }
                    catch(Exception e) { }
                }
            }
            else
            {
                var list = ((INodeRepository)_currentrepository).GetNodeFieldMapData(node, language);
                var processedlist = new List<NodeFieldMap>();
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
                        nodefield.LanguageId = language.Id;
                        _currentrepository.SaveNodeData(nodefield);
                        processedlist.Add(nodefield);
                    }
                    catch(Exception e) { }
                }
                PerformUpdates(processedlist, node);
            }
            return true;
        }

        private async void PerformUpdates(List<NodeFieldMap> list, Node node)
        {
            var type = DetermineNodeType(new Node() { Id = node.Id });
            switch(type)
            {
                case NodeType.LANGUAGE_TYPE:
                    var displayname = list.Where(x => x.Field.FieldName == "Display Name").FirstOrDefault().NodeData;
                    var languagecode = list.Where(x => x.Field.FieldName == "Language Code").FirstOrDefault().NodeData;
                    var countrycode = list.Where(x => x.Field.FieldName == "Country Code").FirstOrDefault().NodeData;
                    LanguageManager.UpdateLanguage(node.Id, displayname, countrycode, languagecode);
                    break;
                case NodeType.TEMPLATE_TYPE:
                    break;
            }
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

        public List<NodeFieldMap> GetNodeFieldMapData(string nodeid, string language)
        {
            if (string.IsNullOrWhiteSpace(nodeid) || string.IsNullOrWhiteSpace(language))
            {
                return null;
            }
            return ((INodeRepository)_currentrepository).GetNodeFieldMapData(new Node() { Id = Guid.Parse(nodeid) }, new Language() { Id = Guid.Parse(language)});
        }
    }
}
