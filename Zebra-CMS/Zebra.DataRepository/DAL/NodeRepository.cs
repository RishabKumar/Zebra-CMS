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

        public bool RegisterFieldsForNode(IEntity node, List<Field> fields)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                foreach (var field in fields)
                {
                    var nodefieldmap = new NodeFieldMap() { Id = Guid.NewGuid(), FieldId = field.Id, NodeId = node.Id, NodeData = string.Empty };
                    nodefieldmap = _context.NodeFieldMaps.Add(nodefieldmap);
                }
                _context.SaveChanges();
                dbt.Commit();
            }
            return true;
        }

        public override dynamic GetById(IEntity t)
        {
            return _context.Nodes.Where(x => x.Id == t.Id);
        }

        //deletes nodes and nodefieldmaps
        public bool DeleteNode(Node node)
        {
            using ( var dbt = _context.Database.BeginTransaction())
            {
                node = _context.Nodes.Where(x => x.Id == node.Id).FirstOrDefault();
                List<Node> nodes = GetAllChildren(node, new List<Node>());
                if (nodes == null)
                    return false;
                nodes.Add(node);
                DeleteEntryFromNodeFieldMap(nodes);
                var rnodes = _context.Nodes.RemoveRange(nodes.AsEnumerable());
                _context.SaveChanges();
                dbt.Commit();
            }
            return true;
        }

        private void DeleteEntryFromNodeFieldMap(List<Node> nodes)
        {
            foreach (var node in nodes)
            {
                var entrieslist = _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).ToList();
                _context.NodeFieldMaps.RemoveRange(entrieslist);
            }
            _context.SaveChanges();
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

        public Template GetTemplate(Node n)
        {
            return _context.Nodes.Find(n.Id).Template;
        }

        //creates a new nodefieldmap and saves data
        public bool CreateAndSaveNodeData(Node node, Field field, dynamic data)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var nodedata = new NodeFieldMap() { Id = Guid.NewGuid(), NodeId = node.Id, FieldId = field.Id, NodeData = data.ToString() };
                nodedata = _context.NodeFieldMaps.Add(nodedata);
                _context.SaveChanges();
                dbt.Commit();
            }
            return true;
        }

        public bool SaveNodeData(NodeFieldMap nodefieldmap)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var oldnodefieldmap = _context.NodeFieldMaps.Find(nodefieldmap.Id);
                if (oldnodefieldmap != null)
                {
                    oldnodefieldmap.NodeData = nodefieldmap.NodeData;
                    _context.SaveChanges();
                    dbt.Commit();
                }
            }
            return true;
        }

        public List<NodeFieldMap> GetNodeFieldMapData(Node node, Field field = null)
        {
            if(field == null)
                return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).ToList();
            else
                return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id && x.FieldId == field.Id).ToList();
        }

        public NodeFieldMap GetNodeFieldMap(IEntity entity)
        {
            return _context.NodeFieldMaps.Find(entity.Id);
        }

        public void MoveNode(IEntity node, IEntity newparent)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                Node existingnode = _context.Nodes.Find(node.Id);
                Node parent = _context.Nodes.Find(newparent.Id);
                if (existingnode != null && parent != null && existingnode.ParentId != null && existingnode.ParentId != existingnode.Id)
                {
                    existingnode.ParentId = parent.Id;
                    _context.SaveChanges();
                    dbt.Commit();
                }
            }
        }
    }
}
