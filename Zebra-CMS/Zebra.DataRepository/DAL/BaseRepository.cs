using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public abstract class BaseRepository<T> where T : class
    {
        public BaseRepository()
        {
            
       //     _Context = new DTOContextContainer();
         //   _Context = EFContextContainer.GetInstance().GetDBContext();
            //          _Context.Database.CommandTimeout = 180;
            //    _Context.Configuration.LazyLoadingEnabled = true;
            //          ((IObjectContextAdapter)_Context).ObjectContext.CommandTimeout = 180;
            //_Context.Database.Connection.Open();
        }

        static BaseRepository()
        {
            
        }

        protected DTOContextContainer _Context;

        protected DTOContextContainer _context
        {
            get
            {
                if(_Context == null)
                    _Context = (DTOContextContainer)HttpContext.Current.Items["DTOContextContainer"];
                lock (_Context)
                {
                  //  _Context = EFContextContainer.GetInstance().GetDBContext();
                    if (_Context.Database.Connection.State == ConnectionState.Closed)
                    {
                        _Context.Database.Connection.Open();
                    }
                    return _Context;
                }
            }
        }

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
            //foreach (var t in _context.ChangeTracker.Entries())
            //{
            //    t.Reload();
            //}
        }
    }

    public sealed class EFContextContainer : IDisposable
    {
        private DTOContextContainer _context;
        public static EFContextContainer _efContext; 
        private EFContextContainer()
        {
            _context = new DTOContextContainer();
        }
        public static EFContextContainer GetInstance()
        {
            if(_efContext == null || _efContext._context == null)
            {
                _efContext = new EFContextContainer();
            }
            return _efContext;
        }
        public DTOContextContainer GetDBContext()
        {
            return _context;
        }

        public void Dispose()
        {
            _context.Dispose();
            _context = null;
            _efContext = null;
        }
    }
     
}
