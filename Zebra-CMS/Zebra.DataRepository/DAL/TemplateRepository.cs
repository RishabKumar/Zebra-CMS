using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    class TemplateRepository : BaseRepository<Template>
    {
        public override Template GetByName(Template t)
        {
            throw new NotImplementedException();
        }
    }
}
