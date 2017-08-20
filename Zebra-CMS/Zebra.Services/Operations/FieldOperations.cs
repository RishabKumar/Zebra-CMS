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

namespace Zebra.Services.Operations
{
    public class FieldOperations : BaseOperations<FieldRepository, Field>, IFieldOperations
    {
        IFieldRepository _fieldrepo;
        public FieldOperations(FieldRepository t) : base(t)
        {
            _fieldrepo = t;
        }

        public List<Field> GetAllFields()
        {
            throw new NotImplementedException();
        }

        public List<Field> GetFieldsFromTemplate(string templateid)
        {
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
           return _fieldrepo.GetField(new Field { Id = Guid.Parse(fieldid) });
        }

        // Method to identify required FieldType and loads the corresponding HTML.
        public string GetRenderedField(string fieldid)
        {
            var type = GetFieldType(fieldid);
            var field = GetField(fieldid);
            if (type != null)
            {
                var fieldtype = System.Type.GetType(type.ClassPath);
                FieldContext _context = new FieldContext(Guid.Parse(fieldid), field.FieldName);
                var fieldobj = Activator.CreateInstance(fieldtype, _context);
                var mi = fieldtype.GetMethod("DoRender");
                return mi.Invoke(fieldobj, null).ToString(); 
            }
            return string.Empty;
        }

         
    }
}
