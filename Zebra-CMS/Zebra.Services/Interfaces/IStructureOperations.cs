using System.Collections.Generic;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    interface IStructureOperations
    {
        List<Fields> GetFieldsByTemplate(Templates t);

        Templates CreateTemplate(Templates t);

        bool CreateField(Fields f);

        bool CreateField(List<Fields> lst);

        Templates AddField(Fields f, Templates t);

        Templates UpdateTemplate(List<Fields> lst, Templates t);

        bool DeleteTemplate(Templates t);

        bool DeleteField(Fields f);

    }
}
