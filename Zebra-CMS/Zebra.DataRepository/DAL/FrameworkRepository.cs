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
    public class FrameworkRepository : BaseRepository<FrameworkData>, IFrameworkRepository
    {
        public bool DeleteFrameworkData(FrameworkData frameworkData)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmp = _context.FrameworkDatas.Remove(frameworkData);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
                return tmp == null ? false : true;
            }
        }

        public override List<FrameworkData> GetByCondition(Expression<Func<FrameworkData, bool>> selector)
        {
            return _context.FrameworkDatas.Where(selector).ToList();
        }

        public override FrameworkData GetByName(FrameworkData t)
        {
            return _context.FrameworkDatas.Where(x=> x.ProcessName == t.ProcessName).FirstOrDefault();
        }

        public FrameworkData GetFrameworkData(FrameworkData frameworkData)
        {
            return _context.FrameworkDatas.Where(x=> x.Id == frameworkData.Id).FirstOrDefault();
        }

        public override List<FrameworkData> GetListById(IEntity t)
        {
            return GetByCondition(x => x.Id == t.Id);
        }

        public bool SaveFrameworkData(FrameworkData frameworkData)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmp = _context.FrameworkDatas.Add(frameworkData);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
                return tmp == null ? false : true;
            }
        }

        public void UpdateFrameworkData(FrameworkData frameworkData)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmp = GetFrameworkData(frameworkData);
                _context.FrameworkDatas.Attach(tmp);
                tmp.NodeId = frameworkData.NodeId;
                tmp.ProcessData = frameworkData.ProcessData;
                tmp.ProcessName = frameworkData.ProcessName;
                tmp.RelatedId = frameworkData.RelatedId;
                tmp.Value = frameworkData.Value;
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
        }
    }
}
