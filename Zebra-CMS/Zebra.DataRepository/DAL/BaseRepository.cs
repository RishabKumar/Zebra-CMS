using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public abstract class BaseRepository<T> where T : class
    {
        internal DTOContextContainer _context = new DTOContextContainer();

        public abstract T GetById(T t);

        public virtual T GetById(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {
            return _context.Set<T>().Where<T>(predicate).FirstOrDefault<T>();
        }

        public abstract T GetByName(T t);

        public List<T> GetAll()
        {
            return _context.Set<T>().ToList<T>();
        }
    }
}
