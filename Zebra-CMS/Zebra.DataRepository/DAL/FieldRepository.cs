using System;
using System.Collections.Generic;
using System.Data.Entity;
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

        public Models.TemplateFieldMap AddFieldToTemplate(Template template, Field field)
        {
            Models.TemplateFieldMap tfm = null;
            using (var dbt = _context.Database.BeginTransaction())
            {
                tfm = _context.TemplateFieldMaps.Add(new Models.TemplateFieldMap() { Id = Guid.NewGuid(), FieldId = field.Id, TemplateId = template.Id });
                _context.SaveChanges();
                dbt.Commit();
            }
            return tfm;
        }

        public List<FieldType> GetFieldTypeFromField(Field field)
        {
            field = _context.Fields.Find(field.Id);
            if (field == null)
            {
                return null;
            }
            return _context.FieldTypes.Where(x => x.Id == field.TypeId).ToList();
        }

        public FieldType GetFieldType(IEntity field)
        {
            return _context.Fields.Find(field.Id).FieldType;
        }

        public Field CreateField(Field field, Template template)
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

        public Field DeleteField(Field field)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                field = _context.Fields.Find(field.Id);
                if (field == null)
                {
                    return null;
                }
                field = _context.Fields.Remove(field);
                _context.SaveChanges();
                dbt.Commit();
            }
            return field;
        }

        [Obsolete("Will be removed in future release")]
        public void RemoveFieldTemplateRelation(Field field)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                field = _context.Fields.Find(field.Id);
                if(field == null)
                {
                    return;
                }
                var list = _context.TemplateFieldMaps.Where(x => x.FieldId == field.Id).ToList();
                foreach(var tmp in list)
                {
                    _context.TemplateFieldMaps.Remove(tmp);
                }
                _context.SaveChanges();
                dbt.Commit();
            }
        }

        public void RemoveFieldTemplateRelation(Models.TemplateFieldMap tmp)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                tmp = _context.TemplateFieldMaps.Find(tmp.Id);
                if (tmp == null)
                {
                    return;
                }
                _context.TemplateFieldMaps.Remove(tmp);
                _context.SaveChanges();
                dbt.Commit();
            }
        }

        public Field UpdateField(Field field)
        {
            Field tmp = null;
            using (var dbt = _context.Database.BeginTransaction())
            {
                tmp = _context.Fields.Find(field.Id);
                if (tmp == null)
                {
                    return tmp;
                }
                //_context.Fields.Attach(tmp);
                tmp.FieldName = field.FieldName;
                tmp.TypeId = field.TypeId;
                //   _context.Entry(tmp).State = EntityState.Modified;
                _context.SaveChanges();
                dbt.Commit();
            }
            return _context.Fields.Find(tmp.Id);
        }
    }
}
