using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    class TemplateRepository : BaseRepository<Template>
    {
        public override List<Template> GetByCondition(Expression<Func<Template, bool>> selector)
        {
            throw new NotImplementedException();
        }

        public override Template GetByName(Template t)
        {
            throw new NotImplementedException();
        }

        public override List<Template> GetListById(IEntity t)
        {
            throw new NotImplementedException();
        }
    }
}
