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

        public virtual Template GetById(IEntity t)
        {
            return _context.Templates.Where(x => x.Id.Equals(t.Id)).FirstOrDefault();
        }

        public abstract T GetByName(T t);

        public virtual List<T> GetAll()
        {
            return _context.Set<T>().ToList<T>();
        }
    }
}
