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
    public class NodeRepository : BaseRepository<Node>, INodeRepository
    {
        public Node CreateNode(Node node)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                node = _context.Nodes.Add(node);
                _context.SaveChanges();
                dbt.Commit();
            }
            return node;

        }

        public override dynamic GetById(IEntity t)
        {
            return _context.Nodes.Where(x => x.Id == t.Id);
        }

        public bool DeleteNode(Node node)
        {
            dynamic rnodes = null;
            using (var dbt = _context.Database.BeginTransaction())
            {
                node = _context.Nodes.Where(x => x.Id == node.Id).FirstOrDefault();
                List<Node> nodes = GetAllChildren(node, new List<Node>());
                if (nodes == null)
                    return false;
                nodes.Add(node);
                rnodes = _context.Nodes.RemoveRange(nodes.AsEnumerable());
                _context.SaveChanges();
                dbt.Commit();
            }
            if(rnodes != null)
            {
                return true;
            }
            return false;
        }

        private List<Node> GetAllChildren(Node node, List<Node> children)
        {

            var nodes = GetChildNodes(node);
            children.AddRange(nodes);
            foreach (var n in nodes)
            {
                GetAllChildren(n, children);
            }

            return children;
        }

        public override List<Node> GetByCondition(Expression<Func<Node, bool>> selector)
        {
            return _context.Nodes.Where(selector).ToList();
        }

        public override Node GetByName(Node t)
        {
            return _context.Nodes.Where(x => x.NodeName.ToLower().Equals(t.NodeName.ToLower())).FirstOrDefault();
        }

        public List<Node> GetChildNodes(Node parent)
        {
            return _context.Nodes.Where(x => x.ParentId == parent.Id).ToList();
        }

        public override List<Node> GetListById(IEntity t)
        {
            return _context.Nodes.Where(x => x.Id.Equals(t.Id)).ToList();
        }

        public Node GetNode(Node node)
        {
            return _context.Nodes.Where(x=> x.Id == node.Id).FirstOrDefault();
        }

        public Template GetTemplate(IEntity t)
        {
            return _context.Nodes.Attach((Node)t).Template;
        }
    }
}
