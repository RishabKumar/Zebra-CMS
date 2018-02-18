using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public abstract class BaseRepository<T> where T : class
    {
        protected DTOContextContainer _Context = new DTOContextContainer();

        protected DTOContextContainer _context { get { lock (_Context) { return _Context; } } }

        #warning "This method will be removed in future release."
        public virtual dynamic GetById(IEntity t)
        {
            return _context.Templates.Where(x => x.Id.Equals(t.Id)).FirstOrDefault();
        }

        public abstract List<T> GetListById(IEntity t);

        #warning "This method will be removed in future release."
        public abstract List<T> GetByCondition(Expression<Func<T, bool>> selector); 

        public abstract T GetByName(T t);

        public virtual List<T> GetAll()
        {
            return _context.Set<T>().ToList<T>();
        }

        public virtual void ReloadEntities()
        {
            foreach (var t in _context.ChangeTracker.Entries())
            {
                t.Reload();
            }
        }
    }
}
