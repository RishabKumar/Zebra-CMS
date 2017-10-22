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
    public class FieldOperations : BaseOperations<FieldRepository, Field>, IFieldOperations
    {
        IFieldRepository _fieldrepo;
        INodeRepository _noderepo;
        public FieldOperations(FieldRepository t, NodeRepository n) : base(t)
        {
            _fieldrepo = t;
            _noderepo = n;
        }

        public List<Field> GetAllFields()
        {
            throw new NotImplementedException();
        }

        public List<Field> GetExclusiveFieldsOfTemplate(string templateid)
        {
            if (string.IsNullOrWhiteSpace(templateid))
            {
                return null;
            }
            return _fieldrepo.GetFieldsFromTemplate(new Template() { Id = new Guid(templateid) });
        }
         
        public FieldType GetFieldType(string fieldid)
        {
            return _fieldrepo.GetFieldTypeFromField(new Field() { Id = new Guid(fieldid) }).FirstOrDefault();
        }

        public string GetFieldView(string fieldid)
        {
            throw new NotImplementedException();
        }

        public Field GetField(string fieldid)
        {
            if(string.IsNullOrWhiteSpace(fieldid))
            {
                return null;
            }
            return _fieldrepo.GetField(new Field { Id = Guid.Parse(fieldid) });
        }

        // Method to identify required FieldType and loads the corresponding HTML.
        public string GetRenderedField(string nodeid ,string fieldid, string fieldrenderid = null)
        {
            var type = GetFieldType(fieldid);
            var field = GetField(fieldid);
            var node = _noderepo.GetNode(new Node() { Id = Guid.Parse(nodeid) });
            NodeFieldMap nodefieldmap = _noderepo.GetNodeFieldMap(new NodeFieldMap() { Id = Guid.Parse(fieldrenderid)});
            if (type != null)
            {
                var fieldtype = System.Type.GetType(type.ClassPath);
                FieldContext _context = new FieldContext(Guid.Parse(fieldrenderid ?? fieldid), field.FieldName);
                _context.Value = nodefieldmap == null ? string.Empty : nodefieldmap.NodeData;
                var fieldobj = Activator.CreateInstance(fieldtype, _context);
                var mi = fieldtype.GetMethod("DoRender");
                return mi.Invoke(fieldobj, null).ToString(); 
            }
            return string.Empty;
        }

        public List<Field> GetInclusiveFieldsOfTemplate(string nodeid, List<Field> fields = null)
        {
            var node = _noderepo.GetNode(new Node() { Id = Guid.Parse(nodeid) });
         //   var template = _.GetTemplate(new Node() { Id = Guid.Parse(nodeid) });
            if (fields == null)
            {
                fields = new List<Field>();
            }
         //   if (template == null) // must be placed after field == null check !
            {
          //      return fields;
            }
            fields.AddRange(GetExclusiveFieldsOfTemplate(node.Id.ToString()));
            // if(string.Equals(template.Id.ToString().ToUpper(), NodeType.SIMPLETEMPLATE_ID))
            if(node.Id.Equals(node.TemplateId))
            {
                return fields;
            }
            return GetInclusiveFieldsOfTemplate(node.TemplateId.ToString(), fields);
        }

        public FieldType CreateFieldType(FieldType ft)
        {
            return _fieldrepo.CreateFieldType(ft);
        }

        public Field DeleteField(string fieldid)
        {
            if(string.IsNullOrWhiteSpace(fieldid))
            {
                return null;
            }
            var field = new Field() { Id = Guid.Parse(fieldid) };
            return DeleteField(field);
        }

        public Field DeleteField(Field field)
        {
            if (field == null)
            {
                return null;
            }
            _fieldrepo.RemoveFieldTemplateRelation(field);
            return _fieldrepo.DeleteField(field);
        }

        public Field UpdateField(Field field)
        {
            if(field == null)
            {
                return null;
            }
            return _fieldrepo.UpdateField(field);
        }

        public Field UpdateField(string fieldid, string fieldname, string typeid)
        {
            if(string.IsNullOrWhiteSpace(fieldid) || string.IsNullOrWhiteSpace(fieldname) || string.IsNullOrWhiteSpace(typeid))
            {
                return null;
            }
            return UpdateField(new Field() { Id = Guid.Parse(fieldid), FieldName = fieldname, TypeId = Guid.Parse(typeid) });
        }

        public List<FieldType> GetAllFieldTypes()
        {
            return _fieldrepo.GetAllFieldTypes();
        }
    }
}