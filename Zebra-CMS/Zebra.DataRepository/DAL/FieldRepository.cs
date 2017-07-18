using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    class FieldRepository : BaseRepository<Field>
    {
        public override Field GetByName(Field t)
        {
            throw new NotImplementedException();
        }
    }
}
