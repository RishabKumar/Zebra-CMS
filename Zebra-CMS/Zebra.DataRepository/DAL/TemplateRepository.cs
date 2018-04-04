using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
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
                dbt.Dispose();
            }
            ReloadEntities();
            return template;
        }

        //Add templates inheritance to other templates.
        [Obsolete("add check if inheritance already present",false)]
        public NodeTemplateMap AddInheritance(Node node, Template newparent)
        {
            NodeTemplateMap newntm = null;
            var ntm = new NodeTemplateMap() { Id = Guid.NewGuid(), NodeId = node.Id, TemplateId = newparent.Id };
            using (var dbt = _context.Database.BeginTransaction())
            {
                newntm = _context.NodeTemplateMaps.Add(ntm);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
            return newntm;
        }

        public List<NodeTemplateMap> GetByCondition(Expression<Func<NodeTemplateMap, bool>> selector)
        {
            return _context.NodeTemplateMaps.Where(selector).ToList();
        }

        public List<Template> GetInheritedTemplate(Node node)
        {
            return GetByCondition(x => x.NodeId == node.Id).Select(y=>y.Template).ToList();
        }

        public bool RemoveInheritance(Node node, Template parent)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var list = _context.NodeTemplateMaps.Where(x=>x.NodeId == node.Id && x.TemplateId == parent.Id).ToList();
                _context.NodeTemplateMaps.RemoveRange(list);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
            return true;
        }

        public Template DeleteTemplate(IEntity entity)
        {
            var template = new Template() { Id = entity.Id };
            using (var dbt = _context.Database.BeginTransaction())
            {
                //foreach (var t in _context.ChangeTracker.Entries())
                //{
                //    t.Reload();
                //}
                template = GetTemplate(template);
                template = _context.Templates.Remove(template);
                try
                {   
                    _context.SaveChanges();
                }
                catch(DbUpdateConcurrencyException e)
                {
                    //foreach(var t in e.Entries)
                    //{
                    //    _context.Entry(t.Entity).State = EntityState.Deleted;
                    //}
                    _context.SaveChanges();
                }
                finally
                {
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
            ReloadEntities();
            return template;
        }

        public override List<Template> GetByCondition(Expression<Func<Template, bool>> selector)
        {
            return _context.Templates.Where(selector).ToList();
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


        public List<Node> GetDerivedNodes(Node node, Template template, List<Node> derived)
        {
            template = GetTemplate(template);
            var nodes = _context.Nodes.Where(x => x.TemplateId == template.Id).ToList();
            var inheritedtemplatenodes = _context.NodeTemplateMaps.Where(x => x.TemplateId == template.Id).Select(x => x.Node);
            nodes.AddRange(inheritedtemplatenodes);
            derived.AddRange(nodes);
            foreach (var n in nodes)
            {
                var tmp = _context.Templates.Find(n.Id);
                if (tmp != null && node.Id != n.Id)
                {
                    GetDerivedNodes(n, tmp, derived);
                }
            }
            return derived;
        }

        public List<Node> GetInheritedTemplateNodes(Template template)
        {
            return _context.NodeTemplateMaps.Where(x => x.TemplateId == template.Id).Select(x => x.Node).ToList();
        }
    }
}
