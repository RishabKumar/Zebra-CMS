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

        //public override Template GetById(IEntity t)
        //{
        //    return _context.Nodes.Where(x => x.Id.Equals(t.Id)).FirstOrDefault();
        //}





    }
}
