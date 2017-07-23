using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    class FieldRepository : BaseRepository<Field>
    {
        public override List<Field> GetByCondition(Expression<Func<Field, bool>> selector)
        {
            throw new NotImplementedException();
        }

        public override Field GetByName(Field t)
        {
            throw new NotImplementedException();
        }

        public override List<Field> GetListById(IEntity t)
        {
            throw new NotImplementedException();
        }
    }
}
