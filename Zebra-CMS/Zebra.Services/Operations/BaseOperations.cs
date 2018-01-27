using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;

namespace Zebra.Services.Operations
{
    public abstract class BaseOperations<T, E> where E : class
                                       where T : BaseRepository<E>
    {
        protected BaseRepository<E> _base;
        protected dynamic _currentrepository;  
          
        public BaseOperations(T t)
        {
            _base = t;
        }

        public virtual void ReloadEntities()
        {
            _base.ReloadEntities();
        }
    }
}
