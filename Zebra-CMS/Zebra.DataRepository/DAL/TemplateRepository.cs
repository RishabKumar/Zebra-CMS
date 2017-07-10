using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    class TemplateRepository : BaseRepository<Templates>
    {
        public override Templates GetById(Templates t)
        {
           return _context.Templates.Where(x => x.TemplateId.Equals(t.TemplateId)).FirstOrDefault();
        }

        public override Templates GetByName(Templates t)
        {
            throw new NotImplementedException();
        }
    }
}
