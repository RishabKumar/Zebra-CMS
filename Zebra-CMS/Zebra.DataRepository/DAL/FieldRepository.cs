using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Models;

namespace Zebra.DataRepository.DAL
{
    public class FieldRepository : BaseRepository<Field>, IFieldRepository
    {
        public override List<Field> GetByCondition(Expression<Func<Field, bool>> selector)
        {
            throw new NotImplementedException();
        }

        //public override Field CreateField()
        //{
        //    return null;
        //}


        public FieldType CreateFieldType(FieldType ft)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                ft = _context.FieldTypes.Add(ft);
                _context.SaveChanges();
                dbt.Commit();
            }
            return ft;
             
        }


        public override Field GetByName(Field field)
        {
            throw new NotImplementedException();
        }

        //public override FieldType GetFieldType(IEntity field)
        //{
        //    return _context.Fields.Attach((Field)field).FieldType;
        //} 

        public List<FieldType> GetAllFieldTypes()
        {
            return _context.FieldTypes.ToList();
        }
        
        public override List<Field> GetListById(IEntity field)
        {
            throw new NotImplementedException();
        }

        public List<Field> GetFieldsFromTemplate(Template template)
        {
            return _context.TemplateFieldMaps.Where(x => x.TemplateId == template.Id).Select(x=>x.Field).ToList();
        }

        public List<FieldType> GetFieldTypeFromField(Field field)
        {
            field = _context.Fields.Find(field.Id);
            return _context.FieldTypes.Where(x => x.Id == field.TypeId).ToList();
        }

        public FieldType GetFieldType(IEntity field)
        {
            return _context.Fields.Find((Field)field).FieldType;
        }

        public Field CreateField(Field field)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                field = _context.Fields.Add(field);
                _context.SaveChanges();
                dbt.Commit();
            }
            return field;
        }

        public Field GetField(IEntity field)
        {
            return _context.Fields.Find(field.Id);
        }
    }
}
