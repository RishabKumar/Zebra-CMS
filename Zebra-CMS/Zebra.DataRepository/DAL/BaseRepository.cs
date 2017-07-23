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
        internal DTOContextContainer _context = new DTOContextContainer();
        
        //need to change, return type Template needs to be generic
        public virtual Template GetById(IEntity t)
        {
            return _context.Templates.Where(x => x.Id.Equals(t.Id)).FirstOrDefault();
        }

        public abstract List<T> GetListById(IEntity t);

        #warning "Do not use GetByCondition() method"
        public abstract List<T> GetByCondition(Expression<Func<T, bool>> selector); 

        public abstract T GetByName(T t);

        public virtual List<T> GetAll()
        {
            return _context.Set<T>().ToList<T>();
        }
    }
}
