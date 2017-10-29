using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class TemplateRepository : BaseRepository<Template>, ITemplateRepository
    {
        public Template CreateTemplate(Template template)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                template = _context.Templates.Add(template);
                _context.SaveChanges();
                dbt.Commit();
            }
            return template;
        }

        public Template DeleteTemplate(IEntity entity)
        {
            var template = new Template() { Id = entity.Id };
            using (var dbt = _context.Database.BeginTransaction())
            {
                template = _context.Templates.Find(template.Id);
                template = _context.Templates.Remove(template);
                _context.SaveChanges();
                dbt.Commit();
            }
            return template;
        }

        public override List<Template> GetByCondition(Expression<Func<Template, bool>> selector)
        {
            throw new NotImplementedException();
        }

        public override Template GetByName(Template t)
        {
            throw new NotImplementedException();
        }

        public override List<Template> GetListById(IEntity t)
        {
            return _context.Templates.ToList<Template>();
        }

        public Template GetTemplate(IEntity entity)
        {
            return _context.Templates.Find(entity.Id);
        }
    }
}
