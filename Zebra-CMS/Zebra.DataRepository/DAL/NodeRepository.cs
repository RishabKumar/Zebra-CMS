﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading;
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
                dbt.Dispose();
            }
            ReloadEntities();
            return node;

        }

        public bool AddLanguageToNode(Node node, Language language)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                _context.NodeLanguageMaps.Add(new NodeLanguageMap() { Id = Guid.NewGuid(), NodeId = node.Id, LanguageId = language.Id });
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
            return true;
        }

        public List<Language> GetNodeLanguages(IEntity node)
        {
            return _context.NodeLanguageMaps.Where(x => x.NodeId == node.Id).Select(y => y.Language).ToList();
        }

        public NodeLanguageMap GetNodeLanguageMap(NodeLanguageMap nlmap)
        {
            return _context.NodeLanguageMaps.Where(x => x.Id == nlmap.Id).FirstOrDefault();
        }

        public bool RegisterFieldsForNode(IEntity node, Field field, IEntity language)
        {
            if (_context.Database.CurrentTransaction != null)
            {
                var nodefieldmap = new NodeFieldMap() { Id = Guid.NewGuid(), FieldId = field.Id, NodeId = node.Id, NodeData = string.Empty, LanguageId = language.Id };
                nodefieldmap = _context.NodeFieldMaps.Add(nodefieldmap);
                //explicit transaction is not used as it was causing issue with foreach loop.
                _context.SaveChanges();
            }
            else
            {
                using (var dbt = _context.Database.BeginTransaction())
                {
                    var nodefieldmap = new NodeFieldMap() { Id = Guid.NewGuid(), FieldId = field.Id, NodeId = node.Id, NodeData = string.Empty, LanguageId = language.Id };
                    nodefieldmap = _context.NodeFieldMaps.Add(nodefieldmap);
                    //explicit transaction is not used as it was causing issue with foreach loop.
                    _context.SaveChanges();
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
            ReloadEntities();
            return true;
        }
        /// <summary>
        /// Registers fields for node in all the 'locales' that are already registered for that node.
        /// </summary>
        /// <param name="node"></param>
        /// <param name="fields"></param>
        /// <returns></returns>
        public bool RegisterFieldsForNode(IEntity node, Field field)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                    //var t = from nodefieldmap in _context.NodeFieldMaps where nodefieldmap.NodeId == node.Id group nodefieldmap.LanguageId by nodefieldmap.LanguageId;
                    //var nodefieldmaps1 = _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).GroupBy(y => y.LanguageId).Select(s => s.Key).ToList();
                var languages = _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).Select(y=>y.LanguageId).Distinct();
                //var languages = _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).Select(y => y.LanguageId);
                foreach (var lang in languages)
                {
                    RegisterFieldsForNode(node, field, new Language() { Id = lang.Value });
                }
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
            return true;
        }

        public bool RemoveFieldFromNode(IEntity node, Field field)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var nodefieldmap = _context.NodeFieldMaps.Where(x => x.NodeId == node.Id && x.FieldId == field.Id).ToList();
                 _context.NodeFieldMaps.RemoveRange(nodefieldmap);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
            return true;
        }

        public bool RemoveFieldFromNode(IEntity node, Field field, Language language)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var nodefieldmap = _context.NodeLanguageMaps.Where(x => x.NodeId == node.Id && x.Id == field.Id && x.LanguageId == language.Id).ToList();
                _context.NodeLanguageMaps.RemoveRange(nodefieldmap);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
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
                DeleteEntryFromNodeLanguageMap(nodes);
                DeleteEntryFromNodeTemplateMap(nodes);
                var rnodes = _context.Nodes.RemoveRange(nodes.AsEnumerable());
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
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
            ReloadEntities();
        }

        private void DeleteEntryFromNodeTemplateMap(List<Node> nodes)
        {
            foreach (var node in nodes)
            {
                var entrieslist = _context.NodeTemplateMaps.Where(x => x.NodeId == node.Id).ToList();
                entrieslist.AddRange(_context.NodeTemplateMaps.Where(x => x.TemplateId == node.Id).ToList());
                _context.NodeTemplateMaps.RemoveRange(entrieslist);
            }
            _context.SaveChanges();
            ReloadEntities();
        }

        private void DeleteEntryFromNodeLanguageMap(List<Node> nodes)
        {
            foreach (var node in nodes)
            {
                var entrieslist = _context.NodeLanguageMaps.Where(x => x.NodeId == node.Id).ToList();
                _context.NodeLanguageMaps.RemoveRange(entrieslist);
            }
            _context.SaveChanges();
            ReloadEntities();
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

        public List<Node> GetNodesByType(Template t)
        {
            return _context.Nodes.Where(x => x.TemplateId == t.Id).OrderBy(x=>x.CreationDate).ToList();
        }

        public override List<Node> GetByCondition(Expression<Func<Node, bool>> selector)
        {
            return _context.Nodes.Where(selector).ToList();
        }

        public List<NodeLanguageMap> GetByCondition(Expression<Func<NodeLanguageMap, bool>> selector)
        {
            return _context.NodeLanguageMaps.Where(selector).ToList();
        }

        public List<NodeFieldMap> GetByCondition(Expression<Func<NodeFieldMap, bool>> selector)
        {
            return _context.NodeFieldMaps.Where(selector).ToList();
        }

        public override Node GetByName(Node t)
        {
            return _context.Nodes.Where(x => x.NodeName.ToLower().Equals(t.NodeName.ToLower())).FirstOrDefault();
        }

        public List<Node> GetChildNodes(Node parent)
        {
            return _context.Nodes.Where(x => x.ParentId == parent.Id).OrderBy(x=>x.CreationDate).ToList();
        }

        public override List<Node> GetListById(IEntity t)
        {
            return _context.Nodes.Where(x => x.Id.Equals(t.Id)).OrderBy(x=>x.CreationDate).ToList();
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
        public bool CreateAndSaveNodeData(Node node, Field field, Language language, dynamic data)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var nodedata = new NodeFieldMap() { Id = Guid.NewGuid(), NodeId = node.Id, FieldId = field.Id, NodeData = data.ToString(), LanguageId = language.Id };
                nodedata = _context.NodeFieldMaps.Add(nodedata);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            ReloadEntities();
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
                    dbt.Dispose();
                }
            }
            return true;
        }

        public List<NodeFieldMap> GetNodeFieldMapData(Node node)
        { 
            return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id).OrderBy(x=>x.CreationDate).ToList();  
        }

        public List<NodeFieldMap> GetNodeFieldMapData(Node node, Language language)
        {
            return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id && (x.LanguageId == language.Id || x.Field.IsStatic)).OrderBy(x => x.CreationDate).ToList();
        }

        public List<NodeFieldMap> GetNodeFieldMapData(Node node, Field field)
        {
            return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id && x.FieldId == field.Id).OrderBy(x => x.CreationDate).ToList();
        }

        public List<NodeFieldMap> GetNodeFieldMapData(Node node, Field field, Language language)
        {
            return _context.NodeFieldMaps.Where(x => x.NodeId == node.Id && x.FieldId == field.Id && x.LanguageId == language.Id).OrderBy(x => x.CreationDate).ToList();
        }

        public string GetNodeFieldMapData(Node node, string fieldname)
        {
            var nodefieldmap = (from s in _context.NodeFieldMaps join sa in _context.Fields on s.FieldId equals sa.Id where s.NodeId == node.Id && sa.FieldName == fieldname select s).FirstOrDefault();
            return nodefieldmap.NodeData;
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
                    dbt.Dispose();
                }
            }
        }
    }
}
